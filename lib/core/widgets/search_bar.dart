import 'package:alquran_new/core/constants/shadow_extension.dart';
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
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).cardColor,
        boxShadow: context.shadow.small,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextField(
          onChanged: onChanged,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            icon: Icon(
              Icons.search,
              color: HexColor.fromHex("#7c97a6"),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: HexColor.fromHex("#7c97a6"),
              fontSize: 14,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
