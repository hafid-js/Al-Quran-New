import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class SettingsSwitchTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsSwitchTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: HexColor.fromHex("#256980"),
            fontWeight: FontWeight.w500,
          ),
        ),
        Transform.scale(
          scale: 0.8,
          child: Switch(
            value: value,
            activeThumbColor: Colors.white,
            inactiveThumbColor: Colors.white,
            activeTrackColor: HexColor.fromHex("#D39D52"),
            inactiveTrackColor: HexColor.fromHex("#D7D4D5"),
            trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
