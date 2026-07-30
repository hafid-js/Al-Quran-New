import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/core/helpers/responsive_helper.dart';
import 'package:alquran_new/features/kalender/hijri_calendar/islamic_hijri_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class HijriahScreen extends StatelessWidget {
  const HijriahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#F9F5EF"),
      appBar: AppBar(
        backgroundColor: HexColor.fromHex("#F9F5EF"),
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: Text(
          "Kalender Islam",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.padding(context),
            vertical: 10,
          ),
          child: IslamicHijriCalendar(
            defaultBorder: HexColor.fromHex("#D39D52"),
            defaultBackColor: HexColor.fromHex("#256980"),
          ),
        ),
      ),
    );
  }
}
