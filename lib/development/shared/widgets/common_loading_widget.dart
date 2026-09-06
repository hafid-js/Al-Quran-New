import 'package:alquran_new/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CommonLoadingWidget extends StatelessWidget {
  final double height;
  final bool padded;
  final bool bordered;

  const CommonLoadingWidget({
    super.key,
    this.height = 100,
    this.padded = false,
    this.bordered = false,
  });

  Widget _buildInner(context) {
    return Container(
      decoration: bordered
          ? BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(16),
            )
          : null,
      color: bordered ? null : Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Image.asset(
          'assets/animations/bar_loader.gif',
          height: height,
          color: AppColors.primary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    if (padded) {
      return Padding(
        padding: EdgeInsets.all(8),
        child: _buildInner(context),
      );
    }
    return _buildInner(context);
  }
}
