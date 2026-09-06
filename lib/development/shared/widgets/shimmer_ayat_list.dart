import 'package:alquran_new/development/shared/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerAyatList extends StatelessWidget {
  const ShimmerAyatList({super.key});

  static const _arabWidths = [210.0, 250.0, 190.0, 230.0];
  static const _arabHeights = [38.0, 30.0, 42.0, 34.0];
  static const _latinWidths = [220.0, 180.0, 250.0, 200.0];
  static const _terjemahWidths = [170.0, 200.0, 150.0, 190.0];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final showSumber = (index) => index % 3 != 0;
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: 6,
      itemBuilder: (context, index) {
        final arabW = _arabWidths[index % _arabWidths.length];
        final arabH = _arabHeights[index % _arabHeights.length];
        final latinW = _latinWidths[index % _latinWidths.length];
        final terjemahW = _terjemahWidths[index % _terjemahWidths.length];
        final hasSumber = showSumber(index);
        return Shimmer.fromColors(
          baseColor: isDark ? const Color(0xFF263238) : const Color(0xFFE3E7EC),
          highlightColor:
              isDark ? const Color(0xFF3A464F) : const Color(0xFFF4F6F9),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShimmerBox(width: 26, height: 14, radius: 6),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: ShimmerBox(
                    width: arabW,
                    height: arabH,
                    radius: 6,
                  ),
                ),
                if (index.isEven) ...[
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ShimmerBox(
                      width: latinW,
                      height: 13,
                      radius: 6,
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                const ShimmerBox(
                  width: double.infinity,
                  height: 13,
                  radius: 6,
                ),
                const SizedBox(height: 6),
                ShimmerBox(width: terjemahW, height: 13, radius: 6),
                if (hasSumber) ...[
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ShimmerBox(
                        width: 3,
                        height: index.isEven ? 34 : 28,
                        radius: 2,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ShimmerBox(
                              width: double.infinity,
                              height: 12,
                              radius: 6,
                            ),
                            const SizedBox(height: 5),
                            ShimmerBox(
                              width: 140.0 + (index % 3) * 20,
                              height: 12,
                              radius: 6,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 12),
                const Divider(height: 1, thickness: 1),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const ShimmerBox(width: 34, height: 26, radius: 6),
                    const Spacer(),
                    for (final size in const [26.0, 26.0, 26.0]) ...[
                      ShimmerBox(width: size, height: size, radius: 13),
                      const SizedBox(width: 12),
                    ],
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}