import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/core/helpers/responsive_helper.dart';
import 'package:alquran_new/development/kalender/hijri_calendar/islamic_hijri_calendar.dart';
import 'package:alquran_new/development/shared/widgets/common_app_bar.dart';
import 'package:flutter/material.dart';

class HijriahScreen extends StatelessWidget {
  const HijriahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#F9F5EF"),
      appBar: CommonAppBar(
        title: "Kalender Islam",
        backgroundColor: HexColor.fromHex("#F9F5EF"),
        surfaceTintColor: Colors.transparent,
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
