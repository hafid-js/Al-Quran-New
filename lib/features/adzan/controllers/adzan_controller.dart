import 'dart:async';
import 'dart:io';

import 'package:alquran_new/core/services/adzan_scheduler_service.dart';
import 'package:alquran_new/core/services/volume_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

class AdzanController extends GetxController {
  late final AudioPlayer player;
  var isPlaying = false.obs;
  var isLoading = true.obs;
  var errorMessage = RxnString();
  var isNativePlaying = false.obs;
  var playerFinished = false.obs;
  StreamSubscription? _processingSubscription;

  @override
  void onInit() {
    super.onInit();
    player = AudioPlayer();
    _initPlayer();
  }

  Future<String> _extractAssetToFile() async {
    final data = await rootBundle.load('assets/sound/adzan_makkah.mp3');
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/adzan_temp.mp3');
    await file.writeAsBytes(data.buffer.asUint8List());
    return file.path;
  }

  Future<void> _initPlayer() async {
    try {
      isLoading.value = true;

      final nativePlaying = await AdzanSchedulerService.isAdzanPlaying();
      if (nativePlaying) {
        isNativePlaying.value = true;
        isPlaying.value = true;
        isLoading.value = false;
        return;
      }

      final path = await _extractAssetToFile();
      await VolumeService.setMediaVolume(0.7);
      await player.setFilePath(path);
      await player.play();
      isPlaying.value = true;

      _processingSubscription = player.processingStateStream.listen((state) {
        if (state == ProcessingState.completed) {
          playerFinished.value = true;
          isPlaying.value = false;
        }
      });
    } catch (e) {
      errorMessage.value = 'Gagal memainkan adzan';
      debugPrint('AdzanController error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> stopAdzan() async {
    await _processingSubscription?.cancel();
    _processingSubscription = null;
    await AdzanSchedulerService.stopAdzan();
    player.stop();
    isPlaying.value = false;
    isNativePlaying.value = false;
  }

  @override
  void onClose() {
    _processingSubscription?.cancel();
    player.stop();
    player.dispose();
    super.onClose();
  }
}
