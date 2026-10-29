import 'package:flutter/material.dart';

class CategoryFilter extends StatelessWidget {
  final String tabName;
  final int counter;

  const CategoryFilter({
    super.key,
    required this.tabName,
    required this.counter,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text(tabName, style: const TextStyle(fontSize: 14)),
                  SizedBox(width: 5),
                  Text(
                    "$counter/33",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              
            ),
          ),
        ),

        SizedBox(width: 20)

      ],
    );
  }
}
