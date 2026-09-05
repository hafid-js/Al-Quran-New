import 'package:alquran_new/core/constants/app_colors.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
         Center(
            child: Text(
              "Pilih Tanggal",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: isDark ? AppColors.textPrimaryDark : HexColor.fromHex("#5a7b8a"),),
            ),
          ),
          Column(
              children: [
                TableCalendar(
                firstDay: DateTime(2020, 1, 1),
                lastDay: DateTime(2100, 12, 31),
                focusedDay: _focusedDay,
                startingDayOfWeek: StartingDayOfWeek.monday,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: isDark ? AppColors.secondary : HexColor.fromHex("#5a7b8a"), fontSize: 12, fontWeight: FontWeight.w600),
                   weekendStyle: TextStyle(color: isDark ? AppColors.secondary : HexColor.fromHex("#5a7b8a"), fontSize: 12, fontWeight: FontWeight.w600)
                ),
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
                  titleTextStyle: TextStyle(color: isDark? Colors.white : HexColor.fromHex("#5a7b8a"), fontSize: 14, fontWeight: FontWeight.w500),
                  leftChevronIcon: Icon(
                    Iconsax.arrow_circle_left,
                    color: isDark? Colors.white : HexColor.fromHex("#5a7b8a"),
                  ),
                  rightChevronIcon: Icon(
                    Iconsax.arrow_circle_right,
                    color: isDark? Colors.white : HexColor.fromHex("#5a7b8a"),
                  ),
                ),
                calendarStyle: CalendarStyle(
      defaultTextStyle: TextStyle(color: isDark? Colors.white : HexColor.fromHex("#5a7b8a")),
        weekendTextStyle: TextStyle(color: isDark? Colors.white : HexColor.fromHex("#5a7b8a")),
                  todayDecoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: AppColors.secondary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text("Batal", style: TextStyle(color: Theme.of(context).textTheme.titleSmall!.color),),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, _selectedDay),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
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
          
        ],
      ),
    );
  }
}
