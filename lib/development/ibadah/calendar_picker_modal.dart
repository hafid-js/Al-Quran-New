import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPickerModal extends StatefulWidget {
  final DateTime initialDate;
  const CalendarPickerModal({super.key, required this.initialDate});

  @override
  State<CalendarPickerModal> createState() => _CalendarPickerModalState();
}

class _CalendarPickerModalState extends State<CalendarPickerModal> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.initialDate;
    _selectedDay = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(
            child: Text(
              "Pilih Tanggal",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 390,
            child: TableCalendar(
              firstDay: DateTime(2020, 1, 1),
              lastDay: DateTime(2100, 12, 31),
              focusedDay: _focusedDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onPageChanged: (focusedDay) => _focusedDay = focusedDay,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                leftChevronIcon: Icon(
                  Iconsax.arrow_circle_left,
                  color: HexColor.fromHex("#256980"),
                ),
                rightChevronIcon: Icon(
                  Iconsax.arrow_circle_right,
                  color: HexColor.fromHex("#256980"),
                ),
              ),
              calendarStyle: CalendarStyle(
    defaultTextStyle: TextStyle(color: HexColor.fromHex("#256980")),
      weekendTextStyle: TextStyle(color: HexColor.fromHex("#256980")),
                todayDecoration: BoxDecoration(
                  color: HexColor.fromHex("#256980"),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: HexColor.fromHex("#D39D52"),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: HexColor.fromHex("#256980"),
                    side: BorderSide(color: HexColor.fromHex("#256980")),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("Batal"),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, _selectedDay),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor.fromHex("#256980"),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("Pilih"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
