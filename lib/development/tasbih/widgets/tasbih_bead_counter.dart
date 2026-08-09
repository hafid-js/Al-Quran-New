import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TasbihBeadCounter extends StatefulWidget {
  /// jumlah hitungan saat ini (ditampilkan di biji paling kiri)
  final int count;

  /// apakah masih bisa dihitung (false saat sudah mencapai target)
  final bool enabled;

  /// dipanggil saat biji diusap ke kanan
  final VoidCallback onCount;

  const TasbihBeadCounter({
    super.key,
    required this.count,
    required this.onCount,
    this.enabled = true,
  });

  @override
  State<TasbihBeadCounter> createState() => _TasbihBeadCounterState();
}

class _TasbihBeadCounterState extends State<TasbihBeadCounter>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  double _dragOffset = 0;
  Animation<double>? _anim;

  static const double _beadSize = 60;
  static const double _gap = 45;
  static const double _step = _beadSize + _gap;
  static const int _slots = 2;
  static const double _paddingH = 20;
  static const double _paddingV = 20;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _dragStart(DragStartDetails details) {
    if (!widget.enabled) return;
    _controller.stop();
    _clearAnim();
    setState(() => _dragOffset = 0);
  }

  void _clearAnim() {
    final anim = _anim;
    if (anim == null) return;
    anim.removeListener(_onUpdate);
    anim.removeStatusListener(_onDone);
    _anim = null;
  }

  void _onUpdate() => setState(() => _dragOffset = _anim!.value);

  void _onDone(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;
    final anim = _anim;
    if (anim == null) return;
    anim.removeListener(_onUpdate);
    anim.removeStatusListener(_onDone);
    _anim = null;
    widget.onCount();
    setState(() => _dragOffset = 0);
  }

  void _dragUpdate(DragUpdateDetails details) {
    if (!widget.enabled) return;
    setState(() {
      _dragOffset = (_dragOffset - details.delta.dx).clamp(0.0, _step * 1.4);
    });
  }

  void _dragEnd(DragEndDetails details) {
    if (!widget.enabled) return;
    final drop = _dragOffset >= _step * 0.55;
    _anim = Tween<double>(
      begin: _dragOffset,
      end: drop ? _step : 0.0,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _anim!.addListener(_onUpdate);
    _anim!.addStatusListener(_onDone);
    _controller.forward(from: 0);
  }

  Widget _bead({int number = 0, required bool active}) {
    final primary = HexColor.fromHex("#D39D52");
    return Container(
      width: _beadSize,
      height: _beadSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? primary : primary.withAlpha(35),
        boxShadow: active
            ? [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ]
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final contentWidth = _slots * _beadSize + (_slots - 1) * _gap;

    return Container(
      width: contentWidth + (_paddingH * 2),
      height: _beadSize + (_paddingV * 2),
      padding: const EdgeInsets.symmetric(horizontal: _paddingH, vertical: _paddingV),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          // tali tasbih
          Positioned.fill(
            child: Center(
              child: Container(
                height: 3,
                decoration: BoxDecoration(
                  color: HexColor.fromHex("#D39D52").withAlpha(25),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
          // biji di kiri (tumpukan) tanpa nomor
          for (int i = 1; i < _slots; i++)
            Positioned(
              left: contentWidth - (i * _step) - _beadSize,
              child: _bead(active: false),
            ),
          // biji aktif paling kanan yang bisa diusap ke kiri
          Positioned(
            left: contentWidth - _beadSize,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onHorizontalDragStart: widget.enabled ? _dragStart : null,
              onHorizontalDragUpdate: widget.enabled ? _dragUpdate : null,
              onHorizontalDragEnd: widget.enabled ? _dragEnd : null,
              child: Transform.translate(
                offset: Offset(-_dragOffset, 0),
                child: _bead(number: widget.count, active: true),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
