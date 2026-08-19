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

  Widget _buildInner() {
    return Container(
      decoration: bordered
          ? BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            )
          : null,
      color: bordered ? null : Colors.white,
      child: Center(
        child: Image.asset(
          'assets/animations/bar_loader.gif',
          height: height,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (padded) {
      return Padding(
        padding: EdgeInsets.all(8),
        child: _buildInner(),
      );
    }
    return _buildInner();
  }
}
