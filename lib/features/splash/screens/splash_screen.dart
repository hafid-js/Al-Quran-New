import 'dart:math';

import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/main_screen.dart';
import 'package:alquran_new/features/onboarding/screens/consent_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      final box = GetStorage();
      final hasConsented = box.read('has_consented') ?? false;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) =>
              hasConsented ? const MainScreen() : const ConsentScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: HexColor.fromHex("#256980"),
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
        child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
  width: 150,
  height: 150,
  padding: const EdgeInsets.all(2),
  decoration: BoxDecoration(
    
    borderRadius: BorderRadius.circular(16),
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(14),
    child: Image.asset(
      'assets/images/logo/hafidtechlogo.png',
      width: 150,
      height: 150,
      fit: BoxFit.contain,
    ),
  ),
),
            const SizedBox(height: 32),
            AnimatedBuilder(
              animation: _animController,
              builder: (context, child) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(3, (i) {
                    final phase = _animController.value * 2 * pi +
                        i * 2.094;
                    final opacity = (sin(phase) + 1) / 2;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(
                          (opacity * 255).toInt(),
                        ),
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ),
      )
    );
  }
}
