// This example demonstrates how to play a playlist with a mix of URI and asset
// audio sources, and the ability to add/remove/reorder playlist items.
//
// To run:
//
// flutter run -t lib/example_playlist.dart

import 'dart:async';

import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/development/just_audio/common.dart' hide ambiguate;
import 'package:get/get.dart' hide Rx;
import 'package:get/get_core/get_core.dart' hide ambiguate;
import 'package:iconsax/iconsax.dart';

import 'media_kit_stub.dart' if (dart.library.io) 'media_kit_impl.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class DetailMurrotalScreen extends StatefulWidget {
  const DetailMurrotalScreen({Key? key}) : super(key: key);

  @override
  DetailMurrotalScreenState createState() => DetailMurrotalScreenState();
}

class DetailMurrotalScreenState extends State<DetailMurrotalScreen>
    with WidgetsBindingObserver {
  late AudioPlayer _player;
  static final _playlist = [
    ClippingAudioSource(
      start: const Duration(seconds: 60),
      end: const Duration(seconds: 90),
      child: AudioSource.uri(
        Uri.parse(
          "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3",
        ),
      ),
      tag: AudioMetadata(
        album: "Al-Baqarah",
        title: "Mishary Rasyid",
        artwork:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRudO-FlgLK_mrwkKT9NCn_CGwPJ4KPM2-Prm1nCIHtBUoQKdo589DsU9Y&s=10",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
        "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3",
      ),
      tag: AudioMetadata(
        album: "Science Friday",
        title: "A Salute To Head-Scratching Science",
        artwork:
            "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
      ),
    ),
    AudioSource.uri(
      Uri.parse("https://s3.amazonaws.com/scifri-segments/scifri201711241.mp3"),
      tag: AudioMetadata(
        album: "Science Friday",
        title: "From Cat Rheology To Operatic Incompetence",
        artwork:
            "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
      ),
    ),
    AudioSource.uri(
      Uri.parse("asset:///audio/nature.mp3"),
      tag: AudioMetadata(
        album: "Public Domain",
        title: "Nature Sounds",
        artwork:
            "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
      ),
    ),
  ];
  int _addedCount = 0;
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    ambiguate(WidgetsBinding.instance)!.addObserver(this);
    _player = AudioPlayer(maxSkipsOnError: 3);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.black),
    );
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.errorStream.listen((e) {
      print('A stream error occurred: $e');
    });
    try {
      await _player.setAudioSources(_playlist);
    } on PlayerException catch (e) {
      // Catch load errors: 404, invalid url...
      print("Error loading playlist: $e");
    }
    // Show a snackbar whenever reaching the end of an item in the playlist.
    _player.positionDiscontinuityStream.listen((discontinuity) {
      if (discontinuity.reason == PositionDiscontinuityReason.autoAdvance) {
        _showItemFinished(discontinuity.previousEvent.currentIndex);
      }
    });
    _player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        _showItemFinished(_player.currentIndex);
      }
    });
  }

  void _showItemFinished(int? index) {
    if (index == null) return;
    final sequence = _player.sequence;
    if (index >= sequence.length) return;
    final source = sequence[index];
    final metadata = source.tag as AudioMetadata;
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text('Finished playing ${metadata.title}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  void dispose() {
    ambiguate(WidgetsBinding.instance)!.removeObserver(this);
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _player.stop();
    }
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
        // backgroundColor: HexColor.fromHex("#256980"),
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
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      metadata.artwork,
                                      fit: BoxFit.cover,
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
                Row(
                  children: [
                    // StreamBuilder<LoopMode>(
                    //   stream: _player.loopModeStream,
                    //   builder: (context, snapshot) {
                    //     final loopMode = snapshot.data ?? LoopMode.off;
                    //     const icons = [
                    //       Icon(Icons.repeat, color: Colors.grey),
                    //       Icon(Icons.repeat, color: Colors.orange),
                    //       Icon(Icons.repeat_one, color: Colors.orange),
                    //     ];
                    //     const cycleModes = [
                    //       LoopMode.off,
                    //       LoopMode.all,
                    //       LoopMode.one,
                    //     ];
                    //     final index = cycleModes.indexOf(loopMode);
                    //     return IconButton(
                    //       icon: icons[index],
                    //       onPressed: () {
                    //         _player.setLoopMode(cycleModes[
                    //             (cycleModes.indexOf(loopMode) + 1) %
                    //                 cycleModes.length]);
                    //       },
                    //     );
                    //   },
                    // ),
                    // Expanded(
                    //   child: Text(
                    //     "Playlist",
                    //     style: Theme.of(context).textTheme.titleLarge,
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),
                    // StreamBuilder<bool>(
                    //   stream: _player.shuffleModeEnabledStream,
                    //   builder: (context, snapshot) {
                    //     final shuffleModeEnabled = snapshot.data ?? false;
                    //     return IconButton(
                    //       icon: shuffleModeEnabled
                    //           ? const Icon(Icons.shuffle, color: Colors.orange)
                    //           : const Icon(Icons.shuffle, color: Colors.grey),
                    //       onPressed: () async {
                    //         final enable = !shuffleModeEnabled;
                    //         if (enable) {
                    //           await _player.shuffle();
                    //         }
                    //         await _player.setShuffleModeEnabled(enable);
                    //       },
                    //     );
                    //   },
                    // ),
                  ],
                ),
                SizedBox(
                  height: 240.0,
                  child: StreamBuilder<SequenceState?>(
                    stream: _player.sequenceStateStream,
                    builder: (context, snapshot) {
                      final state = snapshot.data;
                      final sequence = state?.sequence ?? [];
                      // return ReorderableListView(
                      //   // ignore: deprecated_member_use
                      //   onReorder: (int oldIndex, int newIndex) {
                      //     if (oldIndex < newIndex) newIndex--;
                      //     _player.moveAudioSource(oldIndex, newIndex);
                      //   },
                      //   children: [
                      //     for (var i = 0; i < sequence.length; i++)
                      //       Dismissible(
                      //         key: ValueKey(sequence[i]),
                      //         background: Container(
                      //           color: Colors.redAccent,
                      //           alignment: Alignment.centerRight,
                      //           child: const Padding(
                      //             padding: EdgeInsets.only(right: 8.0),
                      //             child: Icon(Icons.delete, color: Colors.white),
                      //           ),
                      //         ),
                      //         onDismissed: (dismissDirection) =>
                      //             _player.removeAudioSourceAt(i),
                      //         child: Material(
                      //           color: i == state!.currentIndex
                      //               ? Colors.grey.shade300
                      //               : null,
                      //           child: ListTile(
                      //             title: Text(sequence[i].tag.title as String),
                      //             onTap: () => _player
                      //                 .seek(Duration.zero, index: i)
                      //                 .catchError((e, st) {}),
                      //           ),
                      //         ),
                      //       ),
                      //   ],
                      // );
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
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: ListTile(
                                        visualDensity: const VisualDensity(
                                          vertical: -1,
                                        ),
                                        contentPadding: EdgeInsets.zero,
                                        leading: Icon(
                                          Iconsax.play_circle5,
                                          size: 40,
                                          color: HexColor.fromHex("#256980"),
                                        ),
                                        title: Text(
                                          "Al-Kahfi",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: HexColor.fromHex("#256980"),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        subtitle: Text(
                                          "Mishary Rasyid",
                                          style: TextStyle(
                                            color: HexColor.fromHex("#676767"),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        ),
                                        trailing: Text(
                                          "24:17",
                                          style: TextStyle(
                                            color: HexColor.fromHex("#676767"),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                          ),
                                        ),
                                        minVerticalPadding: 10,
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
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            _player.addAudioSource(AudioSource.uri(
              Uri.parse("asset:///audio/nature.mp3"),
              tag: AudioMetadata(
                album: "Public Domain",
                title: "Nature Sounds ${++_addedCount}",
                artwork:
                    "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
              ),
            ));
          },
        ),
      ),
    );
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // IconButton(
        //   icon: const Icon(Icons.volume_up),
        //   onPressed: () {
        //     showSliderDialog(
        //       context: context,
        //       title: "Adjust volume",
        //       divisions: 10,
        //       min: 0.0,
        //       max: 1.0,
        //       value: player.volume,
        //       stream: player.volumeStream,
        //       onChanged: player.setVolume,
        //     );
        //   },
        // ),
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
                width: 64.0,
                height: 64.0,
                child: CircularProgressIndicator(
                  color: HexColor.fromHex("#D39D52"),
                ),
              );
            } else if (!playing) {
              return IconButton(
                icon: const Icon(Iconsax.play_circle5, color: Colors.white),
                iconSize: 64.0,
                onPressed: sequenceLength > 0 ? player.play : null,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(Iconsax.pause5, color: Colors.white),
                iconSize: 64.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.replay),
                iconSize: 64.0,
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
        // StreamBuilder<double>(
        //   stream: player.speedStream,
        //   builder: (context, snapshot) => IconButton(
        //     icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
        //         style: const TextStyle(fontWeight: FontWeight.bold)),
        //     onPressed: () {
        //       showSliderDialog(
        //         context: context,
        //         title: "Adjust speed",
        //         divisions: 10,
        //         min: 0.5,
        //         max: 1.5,
        //         value: player.speed,
        //         stream: player.speedStream,
        //         onChanged: player.setSpeed,
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}

class AudioMetadata {
  final String album;
  final String title;
  final String artwork;

  AudioMetadata({
    required this.album,
    required this.title,
    required this.artwork,
  });
}
