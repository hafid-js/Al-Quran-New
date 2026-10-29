import 'date_functions.dart';
import 'hijri_month_week_names.dart';

class HijriCalendarConfig {
  static String language = 'en';
  late int lengthOfMonth;
  int hDay = 1;
  late int hMonth;
  late int hYear;
  int? wkDay;
  late String longMonthName;
  late String shortMonthName;
  late String dayWeName;
  late String monthArName;
  Map<int, int>? adjustments;

  static const Map<String, Map<String, Map<int, String>>> _local = {
    'en': {
      'long': monthNames,
      'short': monthShortNames,
      'days': wdNames,
      'short_days': shortWdNames
    },
    'ar': {
      'long': arMonthNames,
      'short': arMonthShortNames,
      'days': arWkNames,
      'short_days': arShortWdNames
    },
  };

  factory HijriCalendarConfig.setLocal(String locale) {
    language = locale;
    return HijriCalendarConfig();
  }

  HijriCalendarConfig();

  HijriCalendarConfig.fromDate(DateTime date) {
    gregorianToHijri(date.year, date.month, date.day);
  }

  HijriCalendarConfig.now() {
    _now();
  }

  HijriCalendarConfig.addMonth(int year, int month) {
    hYear = month % 12 == 0 ? year - 1 : year;
    hMonth = month % 12 == 0 ? 12 : month % 12;
    hDay = 1;
  }

  String _now() {
    DateTime today = DateTime.now();
    return gregorianToHijri(today.year, today.month, today.day);
  }

  int getDaysInMonth(int year, int month) {
    int i = _getNewMoonMJDNIndex(year, month);
    return _ummalquraDataIndex(i)! - _ummalquraDataIndex(i - 1)!;
  }

  int _gMod(int n, int m) {
    return ((n % m) + m) % m;
  }

  int _getNewMoonMJDNIndex(int hy, int hm) {
    int cYears = hy - 1, totalMonths = (cYears * 12) + 1 + (hm - 1);
    return totalMonths - 16260;
  }

  int lengthOfYear({int? year = 0}) {
    int total = 0;
    if (year == 0) year = hYear;
    for (int m = 0; m <= 11; m++) {
      total += getDaysInMonth(year!, m);
    }
    return total;
  }

  DateTime hijriToGregorian(int year, int month, int day) {
    int iy = year;
    int im = month;
    int id = day;
    int ii = iy - 1;
    int iln = (ii * 12) + 1 + (im - 1);
    int i = iln - 16260;
    int mcjdn = id + _ummalquraDataIndex(i - 1)! - 1;
    int cjdn = mcjdn + 2400000;
    return julianToGregorian(cjdn);
  }

  DateTime julianToGregorian(int julianDate) {
    int z = (julianDate + 0.5).floor();
    int a = ((z - 1867216.25) / 36524.25).floor();
    a = z + 1 + a - (a / 4).floor();
    int b = a + 1524;
    int c = ((b - 122.1) / 365.25).floor();
    int d = (365.25 * c).floor();
    int e = ((b - d) / 30.6001).floor();
    int day = b - d - (e * 30.6001).floor();
    int month = e - (e > 13.5 ? 13 : 1);
    int year = c - (month > 2.5 ? 4716 : 4715);
    if (year <= 0) {
      year--;
    }
    return DateTime(year, (month), day);
  }

  String gregorianToHijri(int pYear, int pMonth, int pDay) {

    int day = (pDay);
    int month =
        (pMonth);
    int year = (pYear);

    int m = month;
    int y = year;

    if (m < 3) {
      y -= 1;
      m += 12;
    }

    int a = (y / 100).floor();
    int jgc = a - (a / 4.0).floor() - 2;

    int cjdn = (365.25 * (y + 4716)).floor() +
        (30.6001 * (m + 1)).floor() +
        day -
        jgc -
        1524;

    a = ((cjdn - 1867216.25) / 36524.25).floor();
    jgc = a - (a / 4.0).floor() + 1;
    int b = cjdn + jgc + 1524;
    int c = ((b - 122.1) / 365.25).floor();
    int d = (365.25 * c).floor();
    month = ((b - d) / 30.6001).floor();
    day = (b - d) - (30.6001 * month).floor();

    if (month > 13) {
      c += 1;
      month -= 12;
    }

    month -= 1;
    year = c - 4716;

    int mcjdn = cjdn - 2400000;

    int i;
    for (i = 0; i < ummAlquraDateArray.length; i++) {
      if (_ummalquraDataIndex(i)! > mcjdn) break;
    }

    int iln = i + 16260;
    int ii = ((iln - 1) / 12).floor();
    int iy = ii + 1;
    int im = iln - 12 * ii;
    int id = mcjdn - _ummalquraDataIndex(i - 1)! + 1;
    int ml = _ummalquraDataIndex(i)! - _ummalquraDataIndex(i - 1)!;
    lengthOfMonth = ml;
    int wd = _gMod(cjdn + 1, 7);

    wkDay = wd == 0 ? 7 : wd;
    return hDate(iy, im, id);
  }

  String hDate(int year, int month, int day) {
    hYear = year;
    hMonth = month;
    longMonthName = _local[language]!['long']![month]!;
    dayWeName = _local[language]!['days']![wkDay]!;
    monthArName = _local[language]!['long']![month]!;
    shortMonthName = _local[language]!['short']![month]!;
    hDay = day;
    return format(hYear, hMonth, hDay, "dd/mm/yyyy");
  }

  String toFormat(String format) {
    return this.format(hYear, hMonth, hDay, format);
  }

  String format(int year, int month, int day, String format) {
    String newFormat = format;

    String dayString;
    String monthString;
    String yearString;

    if (language == 'ar') {
      dayString = DateFunctions.convertEnglishToHijriNumber(day);
      monthString = DateFunctions.convertEnglishToHijriNumber(month);
      yearString = DateFunctions.convertEnglishToHijriNumber(year);
    } else {
      dayString = day.toString();
      monthString = month.toString();
      yearString = year.toString();
    }

    if (newFormat.contains("dd")) {
      newFormat = newFormat.replaceFirst("dd", dayString);
    } else {
      if (newFormat.contains("d")) {
        newFormat = newFormat.replaceFirst("d", day.toString());
      }
    }

    if (newFormat.contains("DDDD")) {
      newFormat = newFormat.replaceFirst(
          "DDDD", "${_local[language]!['days']![wkDay ?? weekDay()]}");

    } else if (newFormat.contains("DD")) {
      newFormat = newFormat.replaceFirst(
          "DD", "${_local[language]!['short_days']![wkDay ?? weekDay()]}");
    }

    if (newFormat.contains("mm")) {
      newFormat = newFormat.replaceFirst("mm", monthString);
    } else {
      newFormat = newFormat.replaceFirst("m", monthString);
    }

    if (newFormat.contains("MMMM")) {
      newFormat =
          newFormat.replaceFirst("MMMM", _local[language]!['long']![month]!);
    } else {
      if (newFormat.contains("MM")) {
        newFormat =
            newFormat.replaceFirst("MM", _local[language]!['short']![month]!);
      }
    }

    if (newFormat.contains("yyyy")) {
      newFormat = newFormat.replaceFirst("yyyy", yearString);
    } else {
      newFormat = newFormat.replaceFirst("yy", yearString.substring(2, 4));
    }
    return newFormat;
  }

  bool isBefore(int year, int month, int day) {
    return hijriToGregorian(hYear, hMonth, hDay).millisecondsSinceEpoch <
        hijriToGregorian(year, month, day).millisecondsSinceEpoch;
  }

  bool isAfter(int year, int month, int day) {
    return hijriToGregorian(hYear, hMonth, hDay).millisecondsSinceEpoch >
        hijriToGregorian(year, month, day).millisecondsSinceEpoch;
  }

  bool isAtSameMomentAs(int year, int month, int day) {
    return hijriToGregorian(hYear, hMonth, hDay).millisecondsSinceEpoch ==
        hijriToGregorian(year, month, day).millisecondsSinceEpoch;
  }

  void setAdjustments(Map<int, int> adj) {
    adjustments = adj;
  }

  int? _ummalquraDataIndex(int index) {
    if (index < 0 || index >= ummAlquraDateArray.length) {
      throw ArgumentError(
          "Valid date should be between 1356 AH (14 March 1937 CE) to 1500 AH (16 November 2077 CE)");
    }
    if (adjustments != null && adjustments!.containsKey(index + 16260)) {
      return adjustments![index + 16260];
    }
    return ummAlquraDateArray[index];
  }

  int weekDay() {
    DateTime wkDay = hijriToGregorian(hYear, hMonth, hDay);
    return wkDay.weekday;
  }

  @override
  String toString() {
    String dateFormat = "dd/mm/yyyy";
    if (language == "ar") dateFormat = "yyyy/mm/dd";

    return format(hYear, hMonth, hDay, dateFormat);
  }

  List<int?> toList() => [hYear, hMonth, hDay];

  String fullDate() {
    return format(hYear, hMonth, hDay, "DDDD, MMMM dd, yyyy");
  }

  bool isValid() {
    if (validateHijri(hYear, hMonth, hDay)) {
      if (hDay <= getDaysInMonth(hYear, hMonth)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool validateHijri(int year, int month, int day) {
    if (month < 1 || month > 12) return false;

    if (day < 1 || day > 30) return false;
    return true;
  }

  String getLongMonthName() {
    return _local[language]!['long']![hMonth]!;
  }

  String getShortMonthName() {
    return _local[language]!['short']![hMonth]!;
  }

  String getDayName() {
    return _local[language]!['days']![wkDay]!;
  }
}