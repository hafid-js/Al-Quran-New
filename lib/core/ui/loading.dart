import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> dot1;
  late Animation<double> dot2;
  late Animation<double> dot3;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();

    dot1 = Tween(begin: 0.0, end: -8.0).animate(_controller);
    dot2 = Tween(begin: 0.0, end: -8.0).animate(_controller);
    dot3 = Tween(begin: 0.0, end: -8.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _dot(Animation<double> anim) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Transform.translate(
          offset: Offset(0, anim.value),
          child: Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black.withOpacity(0.55),

        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // dots row
              _Dots(),
              SizedBox(height: 16),
              Text(
                "Sedang memuat data...",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// FIX: separate widget biar tidak layout error
class _Dots extends StatefulWidget {
  const _Dots();

  @override
  State<_Dots> createState() => _DotsState();
}

class _DotsState extends State<_Dots>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;

  late Animation<double> d1;
  late Animation<double> d2;
  late Animation<double> d3;

  @override
  void initState() {
    super.initState();

    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();

    d1 = Tween(begin: 0.0, end: -8.0).animate(_c);
    d2 = Tween(begin: 0.0, end: -8.0).animate(_c);
    d3 = Tween(begin: 0.0, end: -8.0).animate(_c);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  Widget dot(Animation<double> a) {
    return AnimatedBuilder(
      animation: _c,
      builder: (_, __) {
        return Transform.translate(
          offset: Offset(0, a.value),
          child: Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        dot(d1),
        dot(d2),
        dot(d3),
      ],
    );
  }
}