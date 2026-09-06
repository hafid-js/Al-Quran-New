import 'package:alquran_new/development/shared/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerDetailSurah extends StatelessWidget {
  const ShimmerDetailSurah({super.key});

   @override
Widget build(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;


  return SizedBox(
  height: double.infinity,
  child: Shimmer.fromColors(
    baseColor: isDark
        ? const Color(0xFF263238)
        : const Color(0xFFE3E7EC),
    highlightColor: isDark
        ? const Color(0xFF3A464F)
        : const Color(0xFFF4F6F9),
    child: Column(
      children: [

        Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),


        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.2,
            ),
            itemCount: 2,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: ShimmerBox(
                    width: 44,
                    height: 20,
                    radius: 12,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  ),
);
}
}