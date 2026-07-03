import 'package:alquran_new/features/kalender/hijri_calendar/islamic_hijri_calendar.dart';
import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/core/helpers/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class KalenderScreen extends StatelessWidget {
  const KalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: AnimatedRotation(
            turns: 1.5,
            duration: Duration(milliseconds: 300),
            child: Icon(Icons.not_started_rounded, color:  Theme.of(context).textTheme.titleLarge?.color,),
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Kalender Islam",
          style: TextStyle(
            fontSize: 22,
            color: Theme.of(context).textTheme.titleLarge?.color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context), vertical: 16),
          child: IslamicHijriCalendar(
                        defaultBorder: HexColor.fromHex("#132e3a"),
                        defaultBackColor: HexColor.fromHex("#132e3a"),
                ),
        ),
      ),
    );
  }
}
