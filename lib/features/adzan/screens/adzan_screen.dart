import 'dart:math';

import 'package:alquran_new/features/adzan/controllers/adzan_controller.dart';
import 'package:alquran_new/features/home/screens/home_screen.dart';
import 'package:alquran_new/features/onboarding/screens/consent_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AdzanScreen extends StatefulWidget {
  const AdzanScreen({super.key});

  @override
  State<AdzanScreen> createState() => _AdzanScreenState();
}

class _AdzanScreenState extends State<AdzanScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveAnimController;
  late final AdzanController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<AdzanController>()
        ? Get.find<AdzanController>()
        : Get.put(AdzanController());

    _waveAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _waveAnimController.dispose();
    super.dispose();
  }

  void _dismiss() {
    controller.stopAdzan();
    Get.delete<AdzanController>();
    if (!mounted) return;
    final box = GetStorage();
    final hasConsented = box.read('has_consented') ?? false;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) =>
            hasConsented ? const HomeScreen() : const ConsentScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: const Color(0xFF0A1E2C),
      body: Stack(
        children: [
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primary.withAlpha(20),
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            left: -80,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primary.withAlpha(15),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primary.withAlpha(30),
                  ),
                  child: Icon(
                    Icons.mosque_rounded,
                    size: 60,
                    color: primary,
                  ),
                ),
                const SizedBox(height: 40),
                AnimatedBuilder(
                  animation: _waveAnimController,
                  builder: (context, child) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(5, (i) {
                        final phase = _waveAnimController.value * 2 * pi +
                            i * 1.256;
                        final scale = (sin(phase) + 1) / 2;
                        final height = 10 + scale * 30;
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: 4,
                          height: height,
                          decoration: BoxDecoration(
                            color: primary.withAlpha(180),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    );
                  },
                ),
                const SizedBox(height: 32),
                Obx(() {
                  if (controller.isLoading.value) {
                    return const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white70,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),
                Obx(() {
                  final err = controller.errorMessage.value;
                  if (err == null) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      err,
                      style: const TextStyle(color: Colors.redAccent, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  );
                }),
                const SizedBox(height: 16),
                Text(
                  "Allahu Akbar, Allahu Akbar",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: primary,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Asyhadu an laa ilaaha illallah",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 48),
                Obx(() {
                  if (controller.isLoading.value) return const SizedBox.shrink();
                  return GestureDetector(
                    onTap: _dismiss,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: primary.withAlpha(30),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: primary.withAlpha(100),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            controller.isPlaying.value
                                ? Icons.stop_circle_outlined
                                : Icons.play_circle_filled_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            controller.isPlaying.value
                                ? "Matikan & Lanjutkan"
                                : "Lanjutkan",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                if (controller.isLoading.value)
                  GestureDetector(
                    onTap: _dismiss,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        "Lewati",
                        style: TextStyle(
                          color: Colors.white38,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
