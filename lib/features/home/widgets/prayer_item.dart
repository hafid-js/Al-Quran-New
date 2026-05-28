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
            width: 90,
            height: 95,
            decoration: BoxDecoration(
              border: BoxBorder.all(
                width: 0.5,
                color: Theme.of(context).colorScheme.primary,
              ),
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.primary, size: 18,),
                SizedBox(height: 5),
                Text(label, style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 14,)),
                SizedBox(height: 5),
                Text(time, style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 14, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Icon(
                  Icons.brightness_1_rounded,
                  size: 8,
                  color: Theme.of(context).colorScheme.primary,
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
          Icon(icon, color: Theme.of(context).textTheme.labelLarge?.color, size: 18,),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12
            ),
          ),
          SizedBox(height: 5),
          Text(time, style: TextStyle(color: Theme.of(context).textTheme.labelMedium?.color, fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      );
    }
  }
}
