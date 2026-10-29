import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'hijri_calendar_config.dart';
import 'hijri_date.dart';
import 'hijri_view_model.dart';

class IslamicHijriCalendar extends StatefulWidget {
  final bool? isHijriView;

  final Color highlightBorder;

  final Color defaultBorder;

  final Color? highlightTextColor;

  final DateTime? day;

  final Color defaultTextColor;

  final Color defaultBackColor;

  final int adjustmentValue;

  final bool? isGoogleFont;

  final String? fontFamilyName;

  final Function(DateTime selectedDate)? getSelectedEnglishDate;

  final Function(HijriDate selectedDate)? getSelectedHijriDate;

  final bool? isDisablePreviousNextMonthDates;

  const IslamicHijriCalendar({
    super.key,
    this.isHijriView = true,
    this.highlightBorder = Colors.blue,
    this.defaultBorder = const Color(0xfff2f2f2),
    this.highlightTextColor,
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

  @override
  void didUpdateWidget(IslamicHijriCalendar oldWidget) {
    if (oldWidget.adjustmentValue != widget.adjustmentValue) {
      viewmodel.adjustmentValue = widget.adjustmentValue;
    }
    super.didUpdateWidget(oldWidget);
  }

  String direction = 'None';

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

  void funcGetMonth({required bool isPrevious}) {
    isPrevious ? viewmodel.getPreviousMonth() : viewmodel.getNextMonth();
    setState(() {});
  }

  List<DateTime> _getDaysInMonth(DateTime date) {
    days = [];

    DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);
    DateTime lastDayOfMonth = DateTime(date.year, date.month + 1, 0);

    int firstWeekday = firstDayOfMonth.weekday;
    int lastWeekday = lastDayOfMonth.weekday;

    for (int i = firstWeekday - 1; i > 0; i--) {
      days.add(firstDayOfMonth.subtract(Duration(days: i)));
    }

    for (int i = 0; i < lastDayOfMonth.day; i++) {
      days.add(firstDayOfMonth.add(Duration(days: i)));
    }

    for (int i = 1; i <= 7 - lastWeekday; i++) {
      days.add(lastDayOfMonth.add(Duration(days: i)));
    }
    return days;
  }

  Widget funcCalendarDaysView({
    required TextStyle textStyle,
    required double rowHeight,
    required double fontSize,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onPanUpdate: (details) => _onPanUpdate(details),
      onPanEnd: (details) => _onPanEnd(),
      child: GridView.builder(
        padding: EdgeInsets.all(0),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          mainAxisExtent: rowHeight,
          crossAxisSpacing: 4,
          mainAxisSpacing: 3,
        ),
        itemCount: days.length,
        itemBuilder: (BuildContext context, int index) {
          return viewmodel.getDate(
            hijriDefaultTextColor: isDark ? Theme.of(
              context,
            ).textTheme.labelSmall?.color : AppColors.textPrimaryDark,
            isHijriView: widget.isHijriView!,
            fontSize: fontSize,
            dateHijriTextSize: 11,
            defaultTextColor:
                AppColors.textPrimaryDark,
            highlightTextColor:
                AppColors.textPrimaryDark,
            day: days[index],
            highlightBorder: widget.highlightBorder,
            defaultBorder: widget.defaultBorder,
            backgroundColor: isDark ? null : AppColors.primary,
            deActiveDateBorderColor: widget.defaultBorder,
            eventBackgroundColor: AppColors.secondary,
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

        double minRowHeight = 58;
        double fontSize = 16;

        if (parentWidth > 600) {
          fontSize = 18;
        } else if (parentWidth > 400) {
          fontSize = 16;
        } else {
          fontSize = 16;
        }

        final isDark = Theme.of(context).brightness == Brightness.dark;

        return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? Theme.of(context).cardColor : null,
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                    AppColors.primary.withAlpha(210),
                    BlendMode.srcATop,
                  ),
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/image.png"),
                ),
                borderRadius: BorderRadius.circular(16),
                gradient: isDark ? null : LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary,
                  ],
                ),
              ),
              child: Column(
                children: [
                  Text("Hari ini", style: TextStyle(color: AppColors.light)),
                  SizedBox(height: 8),
                  Text(
                    viewmodel.getHijriNow(),
                    style: TextStyle(
                      fontSize: 27,
                      color: AppColors.light,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),

                  Text(dateNow, style: TextStyle(color: AppColors.light)),
                ],
              ),
            ),

            Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => funcGetMonth(isPrevious: true),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: isDark ? Theme.of(context).cardColor : AppColors.primary ,
                    ),
                    child: Icon(
                      Icons.arrow_circle_left_rounded,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "${viewmodel.getHijriMonthYear()} - ${HijriCalendarConfig.fromDate(viewmodel.currentDisplayMonthYear).hYear} H",
                          textAlign: TextAlign.center,
                          style: textStyle.copyWith(
                            fontSize: 13,
                            color: isDark ? AppColors.textPrimaryDark : AppColors.primary, fontWeight: FontWeight.w600
                          ),
                        ),
                        SizedBox(height: 5),

                        SizedBox(height: 5),
                        Text(
                          viewmodel.getMonthYearRange(),
                          style: textStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: isDark ? AppColors.textPrimaryDark : AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () => funcGetMonth(isPrevious: false),
                  child: Container(
                    
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color:isDark ? Theme.of(context).cardColor : AppColors.primary
                    ),
                    child: Icon(
                      Icons.arrow_circle_right_rounded,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),),

            !widget.isHijriView!
                ? const SizedBox()
                :
                  Container(
                    padding: EdgeInsets.all(12),
                    
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: 
                    Column(
                      children: [
                       Padding(
                            padding: const EdgeInsets.only(bottom: 15),
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
                                              ? AppColors.secondary
                                              : AppColors.primary,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
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
            viewmodel
                    .getMonthlyEvents(viewmodel.currentDisplayMonthYear)
                    .isNotEmpty
                ? Column(
                    children: [
                      Padding(padding: EdgeInsets.symmetric(vertical: 10), child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: isDark ? Theme.of(context).cardColor : AppColors.primary,
                                ),
                                child: Icon(
                                  Icons.star_rate_rounded,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Hari Besar Bulan Ini",
                                style: Theme.of(context).textTheme.titleSmall!
                                    .copyWith(
                                      color: isDark ? AppColors.textPrimaryDark : AppColors.primary,
                                    ),
                              ),
                            ],
                          ),

                          if (events.length > 10)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  showAllEvents = !showAllEvents;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
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
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: showAllEvents
                            ? events.length
                            : (events.length > 10 ? 10 : events.length),
                        itemBuilder: (context, index) {
                          final event = events[index];

                          return Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: isDark ? AppColors.primary.withAlpha(50) : AppColors.primary,
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              event['hijriDay'].toString(),
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              event['gregorianDay'].toString(),
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Expanded(child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                       Text(
                                          event['title'],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                fontSize: 14,
                                                color:isDark ? AppColors.textPrimaryDark : AppColors.primary
                                              ),
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Text(
                                              event['hijri'],
                                              style: Theme.of(
                                                context,
                                              ).textTheme.labelSmall,
                                            ),
                                            SizedBox(width: 6),
                                            CircleAvatar(
                                              radius: 2,
                                              backgroundColor: HexColor.fromHex(
                                                "#7c97a6",
                                              ),
                                            ),
                                            SizedBox(width: 6),
                                            Expanded(child: Text(
                                              event['date'],
                                               maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.labelSmall,
                                            ),)
                                          ],
                                        ),
                                      ],
                                    ),)
                                  ],
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
