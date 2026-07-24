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
      height: 40,
      child: ListView.builder(
        padding: EdgeInsets.zero,
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
                if (isSelected) {
                  onCategorySelected(null);
                } else {
                  onCategorySelected(category);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isActive
                    ? HexColor.fromHex("#256980")
                    : Colors.white,
                foregroundColor: isActive
                    ? Colors.white
                    : HexColor.fromHex("#676767"),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: Text(
                category,
                style: TextStyle(
                  fontSize: 12,
                  color: isActive ? Colors.white : HexColor.fromHex("#676767"),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
