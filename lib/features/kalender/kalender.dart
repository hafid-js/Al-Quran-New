import 'package:alquran_new/features/kalender/data/events_data.dart';
import 'package:alquran_new/features/kalender/widgets/event_card.dart';
import 'package:alquran_new/utils/constants/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

class KalenderScreen extends StatefulWidget {
  const KalenderScreen({super.key});

  @override
  State<KalenderScreen> createState() => _KalenderScreenState();
}

class _KalenderScreenState extends State<KalenderScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.utc(
      _focusedDay.year,
      _focusedDay.month,
      _focusedDay.day,
    );
    initializeDateFormatting('id_ID', null).then((_) => setState(() {}));
  }

  List<Map<String, String>> _getEventsForDay(DateTime day) {
    return eventsData[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
    backgroundColor: Theme.of(context).colorScheme.surface,
        leading: IconButton(
          icon: AnimatedRotation(turns: 1.5, child: Icon(Icons.not_started_rounded, color: Colors.white),  duration: Duration(
                                                      milliseconds: 300,
                                                    ),),
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
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Column(
          children: [
            Container(padding: EdgeInsets.symmetric(vertical: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: HexColor.fromHex("#2dc8b9"),
                borderRadius: BorderRadius.circular(16)
              ),
              child: Column(
                children: [
                  Text("Hari ini"),
                  Text("16 1447 ذو القعدة", style: TextStyle(fontSize: 25,color: Colors.white, fontWeight: FontWeight.w500),),
                  Text("16 Zulkaidah 1447 H"),
                  Text("3 Mei 2026")

                ],
              ),

              
            ),
            SizedBox(height: 40),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              color: HexColor.fromHex("#132e3a"),
              child: TableCalendar(
                firstDay: DateTime(2000),
                lastDay: DateTime(2100),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                // availableCalendarFormats: const {
                //   CalendarFormat.month: 'Bulanan',
                //   CalendarFormat.twoWeeks: '2 Mingguan',
                //   CalendarFormat.week: 'Mingguan',
                // },
                // calendarFormat: _calendarFormat,
                // onFormatChanged: (format) {
                //   setState(() {
                //     _calendarFormat = format;
                //   });
                // },
                headerVisible: true,
                headerStyle: HeaderStyle(
  //                 headerMargin : EdgeInsets.zero,
  // headerPadding : EdgeInsets.zero,
  // formatButtonPadding :EdgeInsets.zero,
  // leftChevronPadding : EdgeInsets.zero,
  // rightChevronPadding : EdgeInsets.zero,
  // leftChevronMargin : EdgeInsets.zero,
                  leftChevronPadding: EdgeInsets.zero,
                  rightChevronPadding: EdgeInsets.zero,
                  headerPadding: EdgeInsets.only(bottom: 40),
                  titleTextStyle: TextStyle(color: Colors.white),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  leftChevronIcon: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: HexColor.fromHex("#132e3a"),
                      ),
                      child: Icon(
                        Icons.arrow_circle_left_rounded,
                        color: HexColor.fromHex("#2dc8b9"),
                      ),
                    ),
                    rightChevronIcon: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: HexColor.fromHex("#132e3a"),
                      ),
                      child: Icon(
                        Icons.arrow_circle_right_rounded,
                        color: HexColor.fromHex("#2dc8b9"),
                      ),
                    ),
                  formatButtonVisible: false,
                  titleCentered: true
                  ),
                calendarStyle: CalendarStyle(
                  // defaultDecoration: BoxDecoration(
                  //   color: HexColor.fromHex("#2dc8b9").withAlpha(40),
                  //   borderRadius: BorderRadius.circular(8)
                  // ),
                defaultTextStyle: TextStyle(color: Colors.white),
                  todayDecoration: BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.blueAccent.withAlpha(130),
                    shape: BoxShape.circle,
                  ),
                ),
                eventLoader: _getEventsForDay,
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    if (events.isNotEmpty) {
                      // return Positioned(
                      //   child: Container(
                      //     height: 60,
                      //     width: 50,
                      //     decoration: BoxDecoration(
                      //       color: HexColor.fromHex("#2dc8b9").withAlpha(40),
                      //       borderRadius: BorderRadius.circular(16)
                      //     ),
                        
                      //   )
                        
                        
                      // );
                      return Positioned(
                        child: CircleAvatar(
                          radius: 2,
                          backgroundColor: HexColor.fromHex("#2dc8b9"),
                        ),
                      ); 
                      
                    }
                    return const SizedBox();
                  },
                ),
                enabledDayPredicate: (day) {
                  return day.isAfter(
                        DateTime.now().subtract(const Duration(days: 1)),
                      ) ||
                      isSameDay(day, DateTime.now());
                },
              ),
            ),
            const SizedBox(height: 16),


            if (_selectedDay != null)
            Column(
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
                    Text("Hari Besar Bulan Ini", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),
                  ],
                 ),

                    Container(
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
                  ],
                )
              ],
            ),
            SizedBox(height: 20),

      

            ..._getEventsForDay(_selectedDay!).map(
                      (event) => 
               
                      
              Container(
                                    padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: HexColor.fromHex("#132e3a"),
                  borderRadius: BorderRadius.circular(16)
                ),
                child: ListTile(
                  leading:  Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: HexColor.fromHex("#2dc8b9").withAlpha(40),
                      ),
                      child: Text(_selectedDay.toString(), style: TextStyle(color: HexColor.fromHex("#2dc8b9")),)
                    ),
                    title: Text(event['title']!, style: TextStyle(color: Colors.white),),
                    subtitle: Row(
                      children: [
                        Text(event['hijri']!, style: TextStyle(color: HexColor.fromHex("#7c97a6")),),
                        SizedBox(width: 6),
                        CircleAvatar(
                          radius: 2,
                          backgroundColor: HexColor.fromHex("#7c97a6"),
                        ),
                             SizedBox(width: 6),
                        Text(event['date']!, style: TextStyle(color: HexColor.fromHex("#7c97a6")),),
                      ],
                    )

                )
              )
            )
          ],
        ),)
      ),
    );
  }
}
