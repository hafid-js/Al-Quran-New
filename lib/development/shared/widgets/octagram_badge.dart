import 'package:flutter/material.dart';

class OctagramBadge extends StatelessWidget {
  final String number;
  final Color? numberColor;
  final double size;

  const OctagramBadge({
    super.key,
    required this.number,
    this.numberColor,
    this.size = 35,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(10),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            number,
            style: TextStyle(
              color: numberColor ?? Color(0xFF1E4355),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          Image.asset(
            "assets/icon/octagram.png",
            height: size,
            width: size,
            color: Color(0xFFDBB893),
          ),
        ],
      ),
    );
  }
}
