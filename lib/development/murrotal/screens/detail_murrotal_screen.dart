import 'dart:async';

import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/development/murrotal/widgets/common.dart' hide ambiguate;
import 'package:alquran_new/development/murrotal/controllers/murrotal_controller.dart';
import 'package:alquran_new/development/alquran/controllers/surah_controller.dart';
import 'package:get/get.dart' hide Rx;
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class DetailMurrotalScreen extends StatefulWidget {
  final int qariIndex;
  final int surahNomor;
  final String surahNama;
  final String surahArti;
  final String qariNama;
  final String qariImage;

  const DetailMurrotalScreen({
    super.key,
    required this.qariIndex,
    required this.surahNomor,
    required this.surahNama,
    required this.surahArti,
    required this.qariNama,
    required this.qariImage,
  });

  @override
  DetailMurrotalScreenState createState() => DetailMurrotalScreenState();
}

class DetailMurrotalScreenState extends State<DetailMurrotalScreen> {
  late final AudioPlayer _player;
  final surahController = Get.find<SurahController>();
  final murrotalController = Get.find<MurrotalController>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  StreamSubscription? _playingSub;

  List<AudioSource> _buildPlaylist() {
    return surahController.surahList.where((surah) {
      final qariKey = (widget.qariIndex + 1).toString().padLeft(2, '0');
      final url = surah.audioFull[qariKey] ?? "";
      return url.isNotEmpty;
    }).map((surah) {
      final qariKey = (widget.qariIndex + 1).toString().padLeft(2, '0');
      final url = surah.audioFull[qariKey]!;
      return AudioSource.uri(
        Uri.parse(url),
        tag: AudioMetadata(
          album: surah.namaLatin,
          title: widget.qariNama,
          artwork: widget.qariImage,
        ),
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _player = murrotalController.player;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.black),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
  }

  Future<void> _init() async {
    _player.errorStream.listen((e) {
      print('A stream error occurred: $e');
    });
    murrotalController.setMurrotalAudio(widget.qariIndex,
        surahController.surahList[widget.surahNomor - 1]);

    try {
      final playlist = _buildPlaylist();
      await _player.setAudioSources(
        playlist,
        initialIndex: widget.surahNomor - 1,
      );
      await _player.play();
    } on PlayerException catch (e) {
      print("Error loading playlist: $e");
    }
    _player.positionDiscontinuityStream.listen((discontinuity) {
      _onTrackChanged(_player.currentIndex);
    });
    _player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        _onTrackChanged(_player.currentIndex);
      }
    });
    _player.playingStream.listen((playing) {
      if (mounted) {
        murrotalController.isMurrotalPlaying.value = playing;
      }
    });
  }

  void _onTrackChanged(int? index) {
    if (index == null) return;
    final sequence = _player.sequence;
    if (index >= sequence.length) return;
    final source = sequence[index];
    final metadata = source.tag as AudioMetadata;
    final surah = surahController.surahList
        .where((s) => s.namaLatin == metadata.album)
        .firstOrNull;
    if (surah != null) {
      murrotalController.murrotalSurahNomor.value = surah.nomor;
      murrotalController.murrotalSurahName.value = surah.namaLatin;
    }
  }

  @override
  void dispose() {
    _playingSub?.cancel();
    super.dispose();
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _player.positionStream,
        _player.bufferedPositionStream,
        _player.durationStream,
        (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: _scaffoldMessengerKey,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor.fromHex("#256980"),
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                HexColor.fromHex("#256980").withAlpha(210),
                BlendMode.srcATop,
              ),
              fit: BoxFit.cover,
              image: AssetImage("assets/images/image.png"),
            ),
            color: HexColor.fromHex("#256980"),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: StreamBuilder<SequenceState?>(
                    stream: _player.sequenceStateStream,
                    builder: (context, snapshot) {
                      final state = snapshot.data;
                      if (state?.sequence.isEmpty ?? true) {
                        return const SizedBox();
                      }
                      final metadata =
                          state!.currentSource!.tag as AudioMetadata;
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      metadata.artwork,
                                      fit: BoxFit.cover,
                                      width: 220,
                                      height: 220,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              metadata.album,
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                            ),
                            Text(
                              metadata.title,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                StreamBuilder<PositionData>(
                  stream: _positionDataStream,
                  builder: (context, snapshot) {
                    final positionData = snapshot.data;
                    return SeekBar(
                      duration: positionData?.duration ?? Duration.zero,
                      position: positionData?.position ?? Duration.zero,
                      bufferedPosition:
                          positionData?.bufferedPosition ?? Duration.zero,
                      onChangeEnd: (newPosition) {
                        _player.seek(newPosition);
                      },
                    );
                  },
                ),
                ControlButtons(_player),
                const SizedBox(height: 8.0),
                SizedBox(
                  height: 240.0,
                  child: StreamBuilder<SequenceState?>(
                    stream: _player.sequenceStateStream,
                    builder: (context, snapshot) {
                      final state = snapshot.data;
                      final sequence = state?.sequence ?? [];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Surah Berikutnya",
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: ListView.builder(
                                  itemCount: () {
                                    final current = state?.currentIndex ?? 0;
                                    final remaining =
                                        sequence.length - (current + 1);
                                    return remaining.clamp(0, 2);
                                  }(),
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final current = state?.currentIndex ?? 0;
                                    final sourceIndex = current + 1 + index;
                                    if (sourceIndex >= sequence.length) {
                                      return SizedBox.shrink();
                                    }
                                    final source = sequence[sourceIndex];
                                    final meta = source.tag as AudioMetadata;
                                    return Container(
                                      margin:
                                          const EdgeInsets.only(bottom: 10),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12),
                                      ),
                                      child: ListTile(
                                        visualDensity:
                                            const VisualDensity(vertical: -1),
                                        contentPadding: EdgeInsets.zero,
                                        leading: Icon(
                                          Iconsax.play_circle5,
                                          size: 40,
                                          color: HexColor.fromHex("#256980"),
                                        ),
                                        title: Text(
                                          meta.album,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: HexColor.fromHex("#256980"),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        subtitle: Text(
                                          meta.title,
                                          style: TextStyle(
                                            color:
                                                HexColor.fromHex("#676767"),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        ),
                                        minVerticalPadding: 10,
                                        onTap: () {
                                          _player.seek(
                                            Duration.zero,
                                            index: sourceIndex,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<bool>(
          stream: player.shuffleModeEnabledStream,
          builder: (context, snapshot) {
            final shuffleModeEnabled = snapshot.data ?? false;
            return IconButton(
              icon: shuffleModeEnabled
                  ? const Icon(
                      Iconsax.shuffle,
                      color: Colors.orange,
                      fontWeight: FontWeight.w700,
                      size: 28,
                    )
                  : const Icon(
                      Iconsax.shuffle,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      size: 28,
                    ),
              onPressed: () async {
                final enable = !shuffleModeEnabled;
                if (enable) {
                  await player.shuffle();
                }
                await player.setShuffleModeEnabled(enable);
              },
            );
          },
        ),
        StreamBuilder<SequenceState?>(
          stream: player.sequenceStateStream,
          builder: (context, snapshot) => IconButton(
            icon: const Icon(Iconsax.previous5, color: Colors.white),
            onPressed: player.hasPrevious ? player.seekToPrevious : null,
          ),
        ),
        StreamBuilder<(bool, ProcessingState, int)>(
          stream: Rx.combineLatest2(
            player.playerEventStream,
            player.sequenceStream,
            (event, sequence) => (
              event.playing,
              event.playbackEvent.processingState,
              sequence.length,
            ),
          ),
          builder: (context, snapshot) {
            final (playing, processingState, sequenceLength) =
                snapshot.data ?? (false, null, 0);
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 55.0,
                height: 55.0,
                child: CircularProgressIndicator(
                  color: HexColor.fromHex("#D39D52"),
                ),
              );
            } else if (!playing) {
              return IconButton(
                icon: const Icon(Iconsax.play_circle5, color: Colors.white),
                iconSize: 50.0,
                onPressed: sequenceLength > 0 ? player.play : null,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(Iconsax.pause5, color: Colors.white),
                iconSize: 50.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.replay),
                iconSize: 50.0,
                onPressed: sequenceLength > 0
                    ? () => player.seek(
                        Duration.zero,
                        index: player.effectiveIndices.first,
                      )
                    : null,
              );
            }
          },
        ),
        StreamBuilder<SequenceState?>(
          stream: player.sequenceStateStream,
          builder: (context, snapshot) => IconButton(
            icon: const Icon(Iconsax.next5, color: Colors.white),
            onPressed: player.hasNext ? player.seekToNext : null,
          ),
        ),
        StreamBuilder<LoopMode>(
          stream: player.loopModeStream,
          builder: (context, snapshot) {
            final loopMode = snapshot.data ?? LoopMode.off;
            const icons = [
              Icon(
                Iconsax.repeate_music,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                size: 28,
              ),
              Icon(
                Iconsax.repeate_music,
                color: Colors.orange,
                fontWeight: FontWeight.w700,
                size: 28,
              ),
              Icon(
                Iconsax.repeate_one,
                color: Colors.orange,
                fontWeight: FontWeight.w700,
                size: 28,
              ),
            ];
            const cycleModes = [LoopMode.off, LoopMode.all, LoopMode.one];
            final index = cycleModes.indexOf(loopMode);
            return IconButton(
              icon: icons[index],
              onPressed: () {
                player.setLoopMode(
                  cycleModes[(cycleModes.indexOf(loopMode) + 1) %
                      cycleModes.length],
                );
              },
            );
          },
        ),
      ],
    );
  }
}


