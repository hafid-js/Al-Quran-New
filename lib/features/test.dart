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
            child: Icon(Icons.not_started_rounded, color: Colors.white),
            duration: Duration(milliseconds: 300),
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
          padding: EdgeInsets.symmetric(horizontal: 16),
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
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      child: IslamicHijriCalendar(
                        defaultBorder: HexColor.fromHex("#132e3a"),
                        defaultBackColor: HexColor.fromHex("#132e3a"),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: HexColor.fromHex("#132e3a"),
                        ),
                        child: Icon(
                          Icons.star_rate_rounded,
                          size: 30,
                          color: HexColor.fromHex("#2dc8b9"),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Hari Besar Bulan Ini",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: HexColor.fromHex("#1a3a4a"),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      "Lihat Semua",
                      style: TextStyle(
                        fontSize: 12,
                        color: HexColor.fromHex("#2dc8b9"),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: HexColor.fromHex("#132e3a"),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: HexColor.fromHex("#2dc8b9").withAlpha(40),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "8",
                            style: TextStyle(
                              fontSize: 18,
                              color: HexColor.fromHex("#2dc8b9"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "25",
                            style: TextStyle(
                              fontSize: 10,
                              color: HexColor.fromHex("#2dc8b9").withAlpha(170),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  title: Text(
                    "Hari Tarwiyah",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        "8 Zulhijah 1447 H",
                        style: TextStyle(color: HexColor.fromHex("#7c97a6")),
                      ),
                      SizedBox(width: 6),
                      CircleAvatar(
                        radius: 2,
                        backgroundColor: HexColor.fromHex("#7c97a6"),
                      ),
                      SizedBox(width: 6),
                      Text(
                        "25 Mei 2026",
                        style: TextStyle(color: HexColor.fromHex("#7c97a6")),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
