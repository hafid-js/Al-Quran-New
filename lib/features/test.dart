import 'package:alquran_new/features/hijri_calendar/islamic_hijri_calendar.dart';
import 'package:alquran_new/features/kalender/data/events_data.dart';
import 'package:alquran_new/utils/constants/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hijri/hijri_calendar.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 30),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [
                      HexColor.fromHex("#23867c"),
                      HexColor.fromHex("#37b0a5"),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Text("Hari ini", style: TextStyle(color: Colors.white)),
                    SizedBox(height: 8),
                    Text(
                      "16 1447 ذو القعدة",
                      style: TextStyle(
                        fontSize: 27,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "16 Zulkaidah 1447 H",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Text("3 Mei 2026", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: IslamicHijriCalendar(
                        defaultBorder: HexColor.fromHex("#132e3a"),
                        defaultBackColor: HexColor.fromHex("#132e3a"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
