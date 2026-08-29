import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

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
        color: Theme.of(context).cardColor,
      ),
      child: Align( 
        alignment: Alignment.centerLeft,
        child: TextField(
          cursorColor:Theme.of(context).textTheme.labelSmall!.color,
          onChanged: onChanged,
          style: TextStyle(color: Theme.of(context).textTheme.labelSmall!.color),
          decoration: InputDecoration(
            icon:       Icon(Iconsax.search_normal_1, color: Theme.of(context).textTheme.labelSmall!.color),
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.labelMedium,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
