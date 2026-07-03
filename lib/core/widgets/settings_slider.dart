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
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                if (_value > widget.min) {
                  setState(() => _value--);
                  widget.onChanged(_value);
                }
              },
              icon: const Icon(Icons.remove_rounded),
            ),
            Expanded(
              child: Slider(
                padding: EdgeInsets.zero,
                value: _value,
                min: widget.min,
                max: widget.max,
                divisions: widget.divisions,
                label: _value.round().toString(),
                onChanged: (value) {
                  setState(() => _value = value);
                  widget.onChanged(value);
                },
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (_value < widget.max) {
                      setState(() => _value++);
                      widget.onChanged(_value);
                    }
                  },
                  icon: const Icon(Icons.add_rounded),
                ),
                Text("${_value.toInt()}pt"),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
