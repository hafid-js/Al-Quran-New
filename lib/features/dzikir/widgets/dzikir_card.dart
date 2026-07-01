import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/features/pengaturan/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class DzikirCard extends StatefulWidget {
  DzikirCard({
    super.key,
    required this.dibaca,
    required this.title,
    required this.hitung,
    required this.jumlah,
    required this.arab,
    required this.latin,
    required this.arti,
    required this.ukuranTeksArab,
    required this.ukuranTeksLatinTerjemah,
    this.showLatin = true,
    this.showTerjemah = true,
    this.onIncrement,
  });

  final int dibaca;
  final String title;
  final int hitung;
  final int jumlah;
  final String arab;
  final String latin;
  final String arti;
  final bool showLatin;
  final bool showTerjemah;
  final VoidCallback? onIncrement;
  final double ukuranTeksArab;
  final double ukuranTeksLatinTerjemah;

  @override
  State<DzikirCard> createState() => _DzikirCardState();
}

class _DzikirCardState extends State<DzikirCard> {
  @override
  Widget build(BuildContext context) {
    final SettingsController setting = Get.find<SettingsController>();
    final selectedIndex = setting.fontSelected.value;
    final fontFamily = fontArabs[selectedIndex]["title"];
    return Container(
      constraints: BoxConstraints(minHeight: 260),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withAlpha(30),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "${widget.dibaca} x",
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.labelSmall?.fontSize,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "${widget.title}",
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withAlpha(30),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "${widget.hitung}/${widget.jumlah}",
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.labelSmall?.fontSize,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "${widget.arab}",
              softWrap: true,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: widget.ukuranTeksArab,
                fontFamily: fontFamily,
              ),
            ),
          ),
          if (widget.showLatin) ...[
            SizedBox(height: 10),
            Text(
              "${widget.latin}",
              style: TextStyle(
                color: Colors.white,
                fontSize: widget.ukuranTeksLatinTerjemah,
                fontFamily: fontFamily,
              ),
            ),
          ],
          if (widget.showTerjemah) ...[
            SizedBox(height: 10),
            Text(
              "${widget.arti}",
              style: TextStyle(
                color: Colors.white,
                fontSize: widget.ukuranTeksLatinTerjemah,
                fontFamily: fontFamily,
              ),
            ),
          ],
          SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {
              return LinearPercentIndicator(
                backgroundColor: Theme.of(context).disabledColor,
                padding: EdgeInsets.zero,
                animateFromLastPercent: true,
                barRadius: Radius.circular(16),
                width: constraints.maxWidth,
                animation: true,
                lineHeight: 6.0,
                animationDuration: 500,
                percent: (widget.hitung / widget.jumlah).clamp(0.0, 1.0),
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Theme.of(context).colorScheme.primary,
              );
            },
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              widget.onIncrement?.call();
            },
            child: Center(
              child: Text(
                widget.hitung == widget.jumlah
                    ? "Target tercapai"
                    : "Tap kartu untuk + 1",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
