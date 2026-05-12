import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'hijri_calendar_config.dart';
import 'hijri_date.dart';
import 'hijri_view_model.dart';

class IslamicHijriCalendar extends StatefulWidget {
  ///allowing users to set either the English calendar only or display the Hijri calendar alongside the English calendar
  final bool? isHijriView;

  ///set selected date border color
  final Color highlightBorder;

  ///set default date border color
  final Color defaultBorder;

  ///set today date text color
  final Color highlightTextColor;

  final DateTime? day;

  ///set others dates text color
  final Color defaultTextColor;

  ///set default date background color
  final Color defaultBackColor;

  ///set hijri calendar adjustment value which is set  by user side
  final int adjustmentValue;

  ///set it true if you want to use google fonts else false
  final bool? isGoogleFont;

  ///set your custom font family name or google font name
  final String? fontFamilyName;

  ///when user taps on date get selected date
  final Function(DateTime selectedDate)? getSelectedEnglishDate;

  ///when user taps on date get selected hijri date
  final Function(HijriDate selectedDate)? getSelectedHijriDate;

  ///set dates which are not included in current month should show disabled or enabled
  final bool? isDisablePreviousNextMonthDates;

  const IslamicHijriCalendar({
    super.key,
    this.isHijriView = true,
    this.highlightBorder = Colors.blue,
    this.defaultBorder = const Color(0xfff2f2f2),
    this.highlightTextColor = Colors.white,
    this.defaultTextColor = Colors.white,
    this.defaultBackColor = Colors.black,
    this.day,
    this.adjustmentValue = 0,
    this.getSelectedHijriDate,
    this.getSelectedEnglishDate,
    this.fontFamilyName = "",
    this.isGoogleFont = false,
    this.isDisablePreviousNextMonthDates = true,
  });

  @override
  State<IslamicHijriCalendar> createState() => _HijriCalendarWidgetsState();
}

class _HijriCalendarWidgetsState extends State<IslamicHijriCalendar> {
  HijriViewModel viewmodel = HijriViewModel();
  List<DateTime> days = [];

  bool showAllEvents = false;

  ///update calendar view when directly value change form user side without set state
  @override
  void didUpdateWidget(IslamicHijriCalendar oldWidget) {
    if (oldWidget.adjustmentValue != widget.adjustmentValue) {
      viewmodel.adjustmentValue = widget.adjustmentValue;
    }
    super.didUpdateWidget(oldWidget);
  }

  String direction = 'None';

  ///on pan update event check direction
  void _onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      direction = 'Right';
    } else if (details.delta.dx < 0) {
      direction = 'Left';
    } else if (details.delta.dy > 0) {
      direction = 'Down';
    } else if (details.delta.dy < 0) {
      direction = 'Up';
    }
  }

  ///on pan gesture update current month
  void _onPanEnd() {
    switch (direction) {
      case "None":
        break;
      case "Right":
        funcGetMonth(isPrevious: true);
        break;
      case "Left":
        funcGetMonth(isPrevious: false);
        break;
      case "Down":
        funcGetMonth(isPrevious: true);
        break;
      case "Up":
        funcGetMonth(isPrevious: false);
        break;
    }
  }

  ///click events of previous & next button
  void funcGetMonth({required bool isPrevious}) {
    isPrevious ? viewmodel.getPreviousMonth() : viewmodel.getNextMonth();
    setState(() {});
  }

  ///get total days in month with previous & next month days in first & last week
  List<DateTime> _getDaysInMonth(DateTime date) {
    days = [];

    DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);
    DateTime lastDayOfMonth = DateTime(date.year, date.month + 1, 0);

    int firstWeekday = firstDayOfMonth.weekday;
    int lastWeekday = lastDayOfMonth.weekday;

    // Add days from previous month
    for (int i = firstWeekday - 1; i > 0; i--) {
      days.add(firstDayOfMonth.subtract(Duration(days: i)));
    }

    // Add days of current month
    for (int i = 0; i < lastDayOfMonth.day; i++) {
      days.add(firstDayOfMonth.add(Duration(days: i)));
    }

    // Add days from next month
    for (int i = 1; i <= 7 - lastWeekday; i++) {
      days.add(lastDayOfMonth.add(Duration(days: i)));
    }
    return days;
  }

  ///set calendar grid view
  Widget funcCalendarDaysView({
    required TextStyle textStyle,
    required double rowHeight,
    required double fontSize,
  }) {
    return GestureDetector(
      onPanUpdate: (details) => _onPanUpdate(details),
      onPanEnd: (details) => _onPanEnd(),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          mainAxisExtent: rowHeight,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
        ),
        itemCount: days.length,
        itemBuilder: (BuildContext context, int index) {
          ///single day block
          return viewmodel.getDate(
            hijriDefaultTextColor: HexColor.fromHex("#7c97a6"),
            isHijriView: widget.isHijriView!,
            fontSize: fontSize,
            dateHijriTextSize: 11,
            defaultTextColor: widget.defaultTextColor,
            highlightTextColor: widget.highlightTextColor,
            day: days[index],
            highlightBorder: widget.highlightBorder,
            defaultBorder: widget.defaultBorder,
            backgroundColor: widget.defaultBackColor,
            deActiveDateBorderColor: widget.defaultBorder,
            style: textStyle,
            onSelectedEnglishDate: (selectedDate) {
              if (widget.getSelectedEnglishDate != null) {
                widget.getSelectedEnglishDate!(selectedDate);
              }
              setState(() {});
            },
            onSelectedHijriDate: (selectedDate) {
              if (widget.getSelectedHijriDate != null) {
                widget.getSelectedHijriDate!(selectedDate);
              }
            },
            isDisablePreviousNextMonthDates:
                widget.isDisablePreviousNextMonthDates!,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ///get total days in current month with previous(first week) & next months(last week) dates
    days = _getDaysInMonth(viewmodel.currentDisplayMonthYear);
    viewmodel.adjustmentValue = widget.adjustmentValue;
    final events = viewmodel.getMonthlyEvents(
      viewmodel.currentDisplayMonthYear,
    );

String dateNow = DateFormat('dd MMMM yyyy', 'id_ID').format(DateTime.now());

    TextStyle textStyle = widget.isGoogleFont!
        ? GoogleFonts.getFont(widget.fontFamilyName!)
        : widget.fontFamilyName!.isEmpty
        ? const TextStyle()
        : TextStyle(fontFamily: widget.fontFamilyName!);

    return LayoutBuilder(
      builder: (context, constraints) {
        double parentWidth = constraints.maxWidth;
        double parentHeight = constraints.maxHeight;

        ///minimum height of particular day box
        double minRowHeight = 70;
        double fontSize = 16;

        if (parentWidth > 600) {
          // Large screen (e.g., tablets), use larger font size
          fontSize = 18;
        } else if (parentWidth > 400) {
          // Medium screen (e.g., larger phones), use medium font size
          fontSize = 16;
        } else {
          // Smaller screen (e.g., small phones), use smaller font size
          fontSize = 16;
        }

        return Column(
          children: [
            // previous month button, month name & year, next month button
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
                         "${viewmodel.getHijriNow()}",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Text(dateNow, style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),

              SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ///navigate to previous month button
                GestureDetector(
                  onTap: () => funcGetMonth(isPrevious: true),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: HexColor.fromHex("#132e3a"),
                    ),
                    child: Icon(
                      Icons.arrow_circle_left_rounded,
                      size: 20,
                      color: HexColor.fromHex("#2dc8b9"),
                    ),
                  ),
                ),

                ///rest of the space set english month name & year
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "${viewmodel.getHijriMonthYear()} - ${HijriCalendarConfig.fromDate(viewmodel.currentDisplayMonthYear).hYear} H",
                          textAlign: TextAlign.center,
                          style: textStyle.copyWith(
                            fontSize: fontSize,
                            color: widget.highlightTextColor,
                          ),
                        ),
                        SizedBox(height: 5),

                        SizedBox(height: 5),
                        Text(
                          // DateFormat(
                          //   'MMM yyyy',
                          // ).format(viewmodel.currentDisplayMonthYear),
                          viewmodel.getMonthYearRange(),
                          style: textStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: HexColor.fromHex("#7c97a6"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                ///navigate to next month button
                GestureDetector(
                  onTap: () => funcGetMonth(isPrevious: false),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: HexColor.fromHex("#132e3a"),
                    ),
                    child: Icon(
                      Icons.arrow_circle_right_rounded,
                      size: 20,
                      color: HexColor.fromHex("#2dc8b9"),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),

            ///show hijri calendar current month name & year
            !widget.isHijriView!
                ? const SizedBox()
                :
                  ///show week name Mon to Sun in a row
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: HexColor.fromHex("#132e3a"),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: HexColor.fromHex("#132e3a"),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                              children: List.generate(
                                viewmodel.headerOfDay.length,
                                (index) {
                                  return Expanded(
                                    child: Center(
                                      child: Text(
                                        viewmodel.headerOfDay[index],
                                        style: textStyle.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: fontSize - 2,
                                          color:
                                              (DateTime.now().weekday - 1 ==
                                                  index)
                                              ? HexColor.fromHex("#2dc8b9")
                                              : HexColor.fromHex("#7c97a6"),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),

                        ///in a rest of the space show calendar
                        parentHeight == double.infinity
                            ? funcCalendarDaysView(
                                textStyle: textStyle,
                                rowHeight: minRowHeight,
                                fontSize: fontSize,
                              )
                            : Expanded(
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    double screenHeight = constraints.maxHeight;
                                    double calculatedRowHeight =
                                        screenHeight / (days.length / 7);
                                    double rowHeight =
                                        calculatedRowHeight < minRowHeight
                                        ? minRowHeight
                                        : calculatedRowHeight;

                                    return funcCalendarDaysView(
                                      textStyle: textStyle,
                                      rowHeight: rowHeight,
                                      fontSize: fontSize,
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
            SizedBox(height: 30),
            viewmodel
                    .getMonthlyEvents(viewmodel.currentDisplayMonthYear)
                    .isNotEmpty
                ? Column(
                    children: [
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

                          if(events.length > 5)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showAllEvents = !showAllEvents;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: HexColor.fromHex("#1a3a4a"),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              child: Text(
                                "Lihat Semua",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: HexColor.fromHex("#2dc8b9"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: showAllEvents
                            ? events.length
                            : (events.length > 5 ? 5 : events.length),
                        itemBuilder: (context, index) {
                          final event = events[index];

                          return Column(
                            children: [
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
                                      color: HexColor.fromHex(
                                        "#2dc8b9",
                                      ).withAlpha(40),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "8",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: HexColor.fromHex(
                                                "#2dc8b9",
                                              ),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            "25",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: HexColor.fromHex(
                                                "#2dc8b9",
                                              ).withAlpha(170),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    event['title'],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Text(
                                        event['hijri'],
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: HexColor.fromHex("#7c97a6"),
                                        ),
                                      ),
                                      SizedBox(width: 6),
                                      CircleAvatar(
                                        radius: 2,
                                        backgroundColor: HexColor.fromHex(
                                          "#7c97a6",
                                        ),
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        event['date'],
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: HexColor.fromHex("#7c97a6"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          );
                        },
                      ),
                    ],
                  )
                : SizedBox.shrink(),
          ],
        );
      },
    );
  }
}
