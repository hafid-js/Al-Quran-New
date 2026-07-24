import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class AppSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hintText;

  const AppSearchBar({
    super.key,
    required this.onChanged,
    this.hintText = "Cari...",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextField(
          onChanged: onChanged,
          style: TextStyle(color: HexColor.fromHex("#1E4355")),
          decoration: InputDecoration(
            icon: Icon(
              Icons.search,
              color: HexColor.fromHex("#1E4355"),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: HexColor.fromHex("#676767"),
              fontSize: 14,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
