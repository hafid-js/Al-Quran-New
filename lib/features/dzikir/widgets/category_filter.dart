import 'package:alquran_new/utils/constants/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CategoryFilter extends StatelessWidget {
  // final List<String> categories;
  // final String activeCategory;
  // final Function(String) onCategorySelected;

  const CategoryFilter({
    super.key,
    // required this.categories,
    // required this.activeCategory,
    // required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor.fromHex("#2cc4b6"),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          "Subhanallah",
                          style: const TextStyle(fontSize: 14),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "3/33",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor.fromHex("#5a7b8a").withAlpha(30),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          "Alhamduillah",
                          style: TextStyle(
                            fontSize: 14,
                            color: HexColor.fromHex("#7c97a6"),
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "0/33",
                          style: TextStyle(
                            fontSize: 12,
                            color: HexColor.fromHex("#7c97a6"),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor.fromHex("#5a7b8a").withAlpha(30),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          "Allahuakbar",
                          style: TextStyle(
                            fontSize: 14,
                            color: HexColor.fromHex("#7c97a6"),
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "0/33",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: HexColor.fromHex("#7c97a6"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
