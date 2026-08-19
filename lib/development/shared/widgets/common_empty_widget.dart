import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CommonEmptyWidget extends StatelessWidget {
  final String message;
  final bool padded;
  final bool bordered;

  const CommonEmptyWidget({
    super.key,
    this.message = "Data Tidak Ditemukan",
    this.padded = false,
    this.bordered = false,
  });

  Widget _buildInner() {
    return Container(
      decoration: bordered
          ? BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            )
          : null,
      color: bordered ? null : Colors.white,
      child: Stack(
        children: [
          Positioned(
            top: -100,
            right: 0,
            left: 0,
            bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/animations/empty.json',
                  width: 180,
                  height: 180,
                ),
                Text(
                  message,
                  style: TextStyle(color: Color(0xFF246177)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (padded) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: _buildInner(),
        ),
      );
    }
    return Center(child: _buildInner());
  }
}
