import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class PrayerItemWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String time;
  final String nextPrayer;

  const PrayerItemWidget({
    super.key,
    required this.time,
    required this.label,
    required this.icon,
    required this.nextPrayer,
  });

  @override
  Widget build(BuildContext context) {
    if (nextPrayer == label) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              border: BoxBorder.all(
                width: 0.5,
                color: HexColor.fromHex("#2dc8b9"),
              ),
              color: HexColor.fromHex("#17404a").withAlpha(140),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: HexColor.fromHex("#2dc8b9")),
                SizedBox(height: 5),
                Text(
                  label,
                  style: TextStyle(color: HexColor.fromHex("#2dc8b9")),
                ),
                SizedBox(height: 5),
                Text(
                  time,
                  style: TextStyle(
                    color: HexColor.fromHex("#2dc8b9"),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                Icon(
                  Icons.brightness_1_rounded,
                  size: 8,
                  color: HexColor.fromHex("#2dc8b9"),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: HexColor.fromHex("#5a7b8a")),
          SizedBox(height: 5),
          Text(label, style: TextStyle(color: HexColor.fromHex("#5a7b8a"))),
          SizedBox(height: 5),
          Text(
            time,
            style: TextStyle(
              color: HexColor.fromHex("#5a7b8a"),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }
  }
}
