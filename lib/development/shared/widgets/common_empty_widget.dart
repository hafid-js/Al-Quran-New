import 'package:alquran_new/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CommonEmptyWidget extends StatelessWidget {
  final String message;
  final bool padded;
  final bool bordered;
  final bool showRefresh;
  final VoidCallback refresh;

  const CommonEmptyWidget({
    super.key,
    this.message = "Data Tidak Ditemukan",
    this.padded = false,
    this.bordered = false,
    this.showRefresh = true,
    required this.refresh
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
      color: bordered ? null : (isDark ? Get.theme.cardColor : Colors.white) ,
      child: Stack(
        children: [
          Positioned(
            top: -100,
            right: 16,
            left: 16,
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
                  textAlign: TextAlign.center,
                  style: TextStyle(color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                ),
                SizedBox(height: 10),
                showRefresh ? ElevatedButton(
                  onPressed: refresh,
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(AppColors.primary)
                  ),
                   child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.refresh, color: AppColors.textPrimaryDark, size: 18),
                    SizedBox(width: 5),
                    Text("Refresh", style: TextStyle(fontSize: 14,color: AppColors.textPrimaryDark))
                  ],
                )) : SizedBox.shrink()
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
