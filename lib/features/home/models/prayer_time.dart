class PrayerTime {
  final int day;
  final String fullDate;
  final String weekday;
  final String imsak;
  final String fajr;
  final String sunrise;
  final String dhuha;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  PrayerTime({
    required this.day,
    required this.fullDate,
    required this.weekday,
    required this.imsak,
    required this.fajr,
    required this.sunrise,
    required this.dhuha,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  factory PrayerTime.fromJson(Map<String, dynamic> json) {
    return PrayerTime(
      day: json['tanggal'],
      fullDate: json['tanggal_lengkap'],
      weekday: json['hari'],
      imsak: json['imsak'],
      fajr: json['subuh'],
      sunrise: json['terbit'],
      dhuha: json['dhuha'],
      dhuhr: json['dzuhur'],
      asr: json['ashar'],
      maghrib: json['maghrib'],
      isha: json['isya'],
    );
  }
}