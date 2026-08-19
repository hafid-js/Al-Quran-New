import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class SettingsSlider extends StatefulWidget {
  final String label;
  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;
  final int divisions;

  const SettingsSlider({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.min = 10,
    this.max = 30,
    this.divisions = 30,
  });

  @override
  State<SettingsSlider> createState() => _SettingsSliderState();
}

class _SettingsSliderState extends State<SettingsSlider> {
  late double _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(SettingsSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 16,
            color: HexColor.fromHex("#256980"),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  padding: EdgeInsets.only(right: 16),
                  trackHeight: 3,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 8,
                  ),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
                ),
                child: Slider(
                  activeColor: HexColor.fromHex("#D39D52"),
                  inactiveColor: HexColor.fromHex("#D7D4D5"),
                  value: _value,
                  min: widget.min,
                  max: widget.max,
                  onChanged: (value) {
                    setState(() => _value = value);
                    widget.onChanged(value);
                  },
                ),
              ),
            ),
            Text("${_value.toInt()} px", style: TextStyle(color: HexColor.fromHex("#256980")),),
          ],
        ),

      ],
    );
  }
}
