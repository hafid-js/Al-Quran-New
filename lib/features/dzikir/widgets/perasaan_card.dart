import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class PerasaanCard extends StatefulWidget {
  final String title;
  final String color;
  final VoidCallback? onTap;

  const PerasaanCard({
    super.key,
    required this.title,
    this.onTap,
    required this.color
  });

  @override
  State<PerasaanCard> createState() => _PerasaanCardState();
}

class _PerasaanCardState extends State<PerasaanCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque, 
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 120,
        width: double.infinity,
        transform: Matrix4.identity()
          ..scale(isPressed ? 0.95 : 1.0),
        decoration: BoxDecoration(
          color: isPressed ? HexColor.fromHex(widget.color) : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize:12, fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}