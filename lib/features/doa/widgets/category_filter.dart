import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CategoryFilter extends StatelessWidget {
  final List<String> categories;
  final String? activeCategory;
  final Function(String?) onCategorySelected;

  const CategoryFilter({
    super.key,
    required this.categories,
    this.activeCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isActive = activeCategory != null && category == activeCategory;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton(
              onPressed: () {
                final isSelected = activeCategory == category;
                if(isSelected) {
                  onCategorySelected(null);
                }else {
                  onCategorySelected(category);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isActive
                    ? HexColor.fromHex("#2cc4b6")
                    : HexColor.fromHex("#132e3a"),
                foregroundColor: isActive ? Colors.white : HexColor.fromHex("#7c97a6"),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                elevation: 0,
              ),
              child: Text(
                category,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
