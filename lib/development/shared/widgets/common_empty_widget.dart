import 'package:alquran_new/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
    final isDark = Get.theme.brightness == Brightness.dark;
    return Container(
      decoration: bordered
          ? BoxDecoration(
              color: Get.theme.cardColor,
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
                  style: TextStyle(color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
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
