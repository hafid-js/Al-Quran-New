import 'dart:core';

abstract class DateFunctions {
  static const List<String> hijriNumbers = [
  '0',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9'
];

  static DateTime getLastDayOfCurrentMonth({required DateTime currentMonth}) {
    DateTime firstDayOfNextMonth =
        DateTime(currentMonth.year, currentMonth.month + 1, 1);
    DateTime lastDayOfCurrentMonth =
        firstDayOfNextMonth.subtract(const Duration(days: 1));
    return lastDayOfCurrentMonth;
  }

  static String convertEnglishToHijriNumber(int numbers) {
    String hijriNumber = "";
    '$numbers'.split('').forEach((char) {
      hijriNumber = "$hijriNumber${hijriNumbers[int.parse(char)]}";
    });
    return hijriNumber;
  }

  int getHijriDay(String hijri) {
  return int.parse(hijri.split(' ')[0]);
}
}