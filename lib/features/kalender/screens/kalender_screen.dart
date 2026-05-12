import 'package:alquran_new/features/kalender/hijri_calendar/islamic_hijri_calendar.dart';
import 'package:alquran_new/features/kalender/data/events_data.dart';
import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hijri/hijri_calendar.dart';

class KalenderScreen extends StatelessWidget {
  const KalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
              backgroundColor: HexColor.fromHex("#132e3a").withAlpha(120),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: AnimatedRotation(
            turns: 1.5,
            duration: Duration(milliseconds: 300),
            child: Icon(Icons.not_started_rounded, color: Colors.white),
          ),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Kalender Islam",
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: IslamicHijriCalendar(
                        defaultBorder: HexColor.fromHex("#132e3a"),
                        defaultBackColor: HexColor.fromHex("#132e3a"),
                ),
        ),
      ),
    );
  }
}
