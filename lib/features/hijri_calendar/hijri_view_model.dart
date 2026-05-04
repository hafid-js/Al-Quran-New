import 'package:alquran_new/utils/constants/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

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

    return GestureDetector(
      onTap: () {
        if (!isCurrentMonthDays) {
          currentDisplayMonthYear = day;
        }
        selectedDate = day;
        onSelectedEnglishDate!(DateTime(day.year, day.month, day.day));
        onSelectedHijriDate!(
          HijriDate(
            year: DateFunctions.convertEnglishToHijriNumber(hijridate.hYear),
            month: DateFunctions.convertEnglishToHijriNumber(hijridate.hMonth),
            day: DateFunctions.convertEnglishToHijriNumber(hijridate.hDay),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color:
              day.year == todayDate.year &&
                  day.month == todayDate.month &&
                  day.day == DateTime.now().day
              ? HexColor.fromHex("#2dc8b9").withAlpha(40)
              : backgroundColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              day.day.toString(),
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
                        TextStyle(fontSize: fontSize, color: highlightTextColor)
                  : style?.copyWith(
                      fontSize: fontSize,
                      color: !isCurrentMonthDays
                          ? (isDisablePreviousNextMonthDates
                                ? defaultTextColor.withValues(alpha: 0.1)
                                : defaultTextColor)
                          : defaultTextColor,
                    ),
            ),
            !isHijriView
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
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
                                  fontSize: 10,
                                  color: highlightTextColor,
                                ) ??
                                TextStyle(
                                  fontSize: fontSize,
                                  color: highlightTextColor,
                                )
                          : style?.copyWith(
                                  fontSize: dateHijriTextSize,
                                  color: !isCurrentMonthDays
                                      ? (isDisablePreviousNextMonthDates
                                            ? defaultTextColor.withValues(
                                                alpha: 0.1,
                                              )
                                            : defaultTextColor)
                                      : hijriDefaultTextColor,
                                ) ??
                                TextStyle(fontSize: fontSize),
                    ),
                  ),
                   day.year == todayDate.year &&
                      day.month == todayDate.month &&
                      day.day == todayDate.day
                  ?
                  Column(
                    children: [
                      SizedBox(height: 4),
                  CircleAvatar(
                          radius: 2,
                          backgroundColor: HexColor.fromHex("#2dc8b9"),
                        )
                    ],
                  ) : SizedBox.shrink()
          ],
        ),
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
}
