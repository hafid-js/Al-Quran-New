import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MapsLoading extends StatelessWidget {
  const MapsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/maps.json',
            width: 100,
            height: 100,
            repeat: true,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 16),
          Text(
            "Sedang memuat data lokasi...",
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
