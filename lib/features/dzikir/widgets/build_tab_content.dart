import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildTabContent(String name, int counter) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: [
        const SizedBox(height: 14),

        Container(
          height: 110,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: HexColor.fromHex("#132e3a"),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name == "Subhanallah"
                    ? "سُبْحَانَ اللّهُ"
                    : name == "Alhamdulillah"
                        ? "الْحَمْدُ لِلّهِ"
                        : "اللّهُ أَكْبَرُ",
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                name,
                style: TextStyle(
                  color: HexColor.fromHex("#7c97a6"),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}