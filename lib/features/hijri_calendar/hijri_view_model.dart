import 'package:alquran_new/features/kalender/data/events_data.dart';
import 'package:alquran_new/utils/constants/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'date_functions.dart';
import 'hijri_calendar_config.dart';
import 'hijri_date.dart';

class HijriViewModel {
  ///adjustment value for hijri calendar
  int adjustmentValue = 0;

  ///each day header value
  var headerOfDay = ["Sen", "Sel", "Rab", "Kam", "Jum", "Sab", "Min"];

  var showOfDay = ["Min", "Sen", "Sel", "Rab", "Kam", "Jum", "Sab"];

  ///below date variables to manage highlight, disable, selected date ui
  DateTime currentDisplayMonthYear = DateTime.now();
  DateTime selectedDate = DateTime.now();
  DateTime todayDate = DateTime.now();

  ///this function is used to set each day block
  Widget getDate({
    required bool isHijriView,
    required double fontSize,
    required DateTime day,
    required Color highlightBorder,
    Color? backgroundColor,
    required deActiveDateBorderColor,
    TextStyle? style,
    double? borderRadius,
    double? dateHijriTextSize,
    required Color defaultTextColor,
    required Color hijriDefaultTextColor,
    required Color defaultBorder,
    required Color highlightTextColor,
    Function(DateTime selectedDate)? onSelectedEnglishDate,
    Function(HijriDate selectedDate)? onSelectedHijriDate,
    required bool isDisablePreviousNextMonthDates,
  }) {
    bool isCurrentMonthDays = day.month == currentDisplayMonthYear.month;
final isEventDay = hasEvent(day);
    var hijridate = !adjustmentValue.isNegative
        ? HijriCalendarConfig.fromDate(
            DateTime(
              day.year,
              day.month,
              day.day,
            ).add(Duration(days: adjustmentValue)),
          )
        : HijriCalendarConfig.fromDate(
            DateTime(
              day.year,
              day.month,
              day.day,
            ).subtract(Duration(days: adjustmentValue.abs())),
          );

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color:
          isEventDay && isCurrentMonthDays
        ? HexColor.fromHex("#2dc8b9").withAlpha(40)
        : backgroundColor,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                      DateFunctions.convertEnglishToHijriNumber(
                        hijridate.hDay,
                      ).toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style:
                          day.year == todayDate.year &&
                              day.month == todayDate.month &&
                              day.day == todayDate.day
                          ? style?.copyWith(
                                  fontSize: fontSize,
                                  color: highlightTextColor,
                                ) ??
                                TextStyle(
                                  fontSize: fontSize,
                                  color: highlightTextColor,
                                )
                          : style?.copyWith(
                                  fontSize: fontSize,
                                  color: !isCurrentMonthDays
                                      ? (isDisablePreviousNextMonthDates
                                            ? defaultTextColor.withValues(
                                                alpha: 0.1,
                                              )
                                            : defaultTextColor)
                                      : defaultTextColor,
                                ) ??
                                TextStyle(fontSize: fontSize),
                    ),
            !isHijriView
                ? const SizedBox()
                :
                Text(
              day.day.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style:
                  day.year == todayDate.year &&
                      day.month == todayDate.month &&
                      day.day == todayDate.day
                  ? style?.copyWith(
                          fontSize: fontSize - 6,
                          color: hijriDefaultTextColor,
                        ) ??
                        TextStyle(fontSize: fontSize, color: highlightTextColor)
                  : style?.copyWith(
                      fontSize: fontSize - 6,
                      color: !isCurrentMonthDays
                          ? (isDisablePreviousNextMonthDates
                                ? defaultTextColor.withValues(alpha: 0.1)
                                : defaultTextColor)
                          : hijriDefaultTextColor,
                    ),
            ),
                 
                   day.year == todayDate.year &&
                      day.month == todayDate.month &&
                      day.day == todayDate.day
                  ?
                  Column(
                    children: [
                      SizedBox(height: 4),
                  if (isEventDay)
        Positioned(
          bottom: 6,
          child: CircleAvatar(
            radius: 2,
            backgroundColor: HexColor.fromHex("#2dc8b9"),
          ),
        ),
                    ],
                  ) : SizedBox.shrink()
          ],
        ),
      );
  }

  ///get hijri month year values by passing current displayed month & year
  String getHijriMonthYear() {
    int lastDayOfMonth = DateFunctions.getLastDayOfCurrentMonth(
      currentMonth: currentDisplayMonthYear,
    ).day;
    String firstDateMonthName = HijriCalendarConfig.fromDate(
      DateTime(currentDisplayMonthYear.year, currentDisplayMonthYear.month, 1),
    ).getLongMonthName();
    String lastDateMonthName = HijriCalendarConfig.fromDate(
      DateTime(
        currentDisplayMonthYear.year,
        currentDisplayMonthYear.month,
        lastDayOfMonth,
      ),
    ).getLongMonthName();
    return firstDateMonthName == lastDateMonthName
        ? firstDateMonthName
        : "$firstDateMonthName / $lastDateMonthName";
  }

String getMonthYearRange() {
  // Ambil awal bulan Hijriah (tanggal 1)
  DateTime firstDate = currentDisplayMonthYear;

  // Ambil akhir bulan Hijriah (misalnya 30 hari)
  DateTime lastDate = currentDisplayMonthYear.add(const Duration(days: 29));

  String firstMonth = DateFormat('MMMM yyyy', 'id_ID').format(firstDate);
  String lastMonth = DateFormat('MMMM yyyy', 'id_ID').format(lastDate);

  return firstMonth == lastMonth
      ? firstMonth
      : "$firstMonth - $lastMonth";
}
  

  ///show previous month
  void getPreviousMonth() {
    int year = currentDisplayMonthYear.year;
    int month = currentDisplayMonthYear.month - 1;

    if (month == 0) {
      month = 12;
      year--;
    }

    // Ensure the day is valid for the new month and year
    int day = currentDisplayMonthYear.day;
    int lastDayOfPreviousMonth = DateTime(year, month + 1, 0).day;
    if (day > lastDayOfPreviousMonth) {
      day = lastDayOfPreviousMonth;
    }
    currentDisplayMonthYear = DateTime(year, month, day);
  }

  ///show next month
  void getNextMonth() {
    int year = currentDisplayMonthYear.year;
    int month = currentDisplayMonthYear.month + 1;

    if (month == 13) {
      month = 1;
      year++;
    }

    int day = currentDisplayMonthYear.day;
    int lastDayOfNextMonth = DateTime(year, month + 1, 0).day;
    if (day > lastDayOfNextMonth) {
      day = lastDayOfNextMonth;
    }
    currentDisplayMonthYear = DateTime(year, month, day);
  }

List<Map<String, dynamic>> getMonthlyEvents(DateTime month) {
  return eventsData.entries
      .where((e) =>
          e.key.year == month.year &&
          e.key.month == month.month)
      .expand((e) => e.value)
      .toList();
}

bool hasEvent(DateTime day) {
  final key = DateTime.utc(day.year, day.month, day.day);
  return eventsData.containsKey(key);
}

}
