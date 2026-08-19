import 'dart:async';
import 'dart:math';

import 'package:alquran_new/core/helpers/helper_functions.dart';
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
  StreamSubscription? _adzanFinishedListener;

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

    _adzanFinishedListener = controller.playerFinished.listen((finished) {
      if (finished) {
        _dismiss();
      }
    });
  }

  @override
  void dispose() {
    _adzanFinishedListener?.cancel();
    _waveAnimController.dispose();
    super.dispose();
  }

  Future<void> _dismiss() async {
    await controller.stopAdzan();
    _adzanFinishedListener?.cancel();
    HomeScreen.markAdzanDismissed();
    await Future.delayed(const Duration(milliseconds: 500));
    Get.delete<AdzanController>();
    if (!mounted) return;
    final box = GetStorage();
    final hasConsented = box.read('has_consented') ?? false;
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) =>
              hasConsented ? const HomeScreen() : const ConsentScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = HexColor.fromHex("#256980");

    return Scaffold(
      backgroundColor: HexColor.fromHex("#256980"),
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
                color: HexColor.fromHex("#0F202B").withAlpha(20),
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
                color: HexColor.fromHex("#0F202B").withAlpha(15),
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
                    borderRadius: BorderRadius.circular(24),
                    color: primary.withAlpha(30),
                    image: DecorationImage(
                image: AssetImage(
                  "assets/icon/albarokah.png",
                ),
                fit: BoxFit.cover,
              ),
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
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    );
                  },
                ),
                const SizedBox(height: 20),
                
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
                    color: Colors.white,
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
                GestureDetector(
                  onTap: _dismiss,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Lewati",
                      style: TextStyle(
                        color: Colors.amber,
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
