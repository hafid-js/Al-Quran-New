import 'package:alquran_new/development/murrotal/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:just_audio/just_audio.dart';

class SeekPlayBar extends StatelessWidget {
  final AudioPlayer player;

  const SeekPlayBar({super.key, required this.player});

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        player.positionStream,
        player.bufferedPositionStream,
        player.durationStream,
        (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PositionData>(
      stream: _positionDataStream,
      builder: (context, snapshot) {
        final positionData = snapshot.data;
        return SeekBar(
          duration: positionData?.duration ?? Duration.zero,
          position: positionData?.position ?? Duration.zero,
          bufferedPosition:
              positionData?.bufferedPosition ?? Duration.zero,
          onChangeEnd: (newPosition) {
            player.seek(newPosition);
          },
        );
      },
    );
  }
}
