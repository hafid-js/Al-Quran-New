import 'package:alquran_new/development/shared/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerDzikirGrid extends StatelessWidget {
  const ShimmerDzikirGrid({super.key});

  static const _arabWidths = [110.0, 90.0, 130.0, 100.0];
  static const _latinWidths = [130.0, 100.0, 144.0, 118.0];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      physics: const AlwaysScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.82,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        final arabW = _arabWidths[index % _arabWidths.length];
        final latinW = _latinWidths[index % _latinWidths.length];
        return Shimmer.fromColors(
          baseColor: isDark ? const Color(0xFF263238) : const Color(0xFFE3E7EC),
          highlightColor:
              isDark ? const Color(0xFF3A464F) : const Color(0xFFF4F6F9),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const ShimmerBox(width: 44, height: 20, radius: 12),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: ShimmerBox(
                        width: double.infinity,
                        height: 12,
                        radius: 6,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const ShimmerBox(width: 30, height: 20, radius: 12),
                  ],
                ),
                const SizedBox(height: 18),
                Align(
                  alignment: Alignment.centerRight,
                  child: ShimmerBox(
                    width: arabW,
                    height: 56,
                    radius: 6,
                  ),
                ),
                const SizedBox(height: 10),
                ShimmerBox(width: latinW, height: 12, radius: 6),
                const SizedBox(height: 16),
                ShimmerBox(
                  width: double.infinity,
                  height: 4,
                  radius: 2,
                ),
                const SizedBox(height: 14),
                const Center(
                  child: ShimmerBox(width: 90, height: 13, radius: 6),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}