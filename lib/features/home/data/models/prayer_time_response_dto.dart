import 'package:alquran_new/features/home/domain/entities/prayer_time.dart';

class PrayerTimeResponseDTO {
  final String province;
  final String city;
  final List<PrayerTimeDTO> schedules;

  const PrayerTimeResponseDTO({
    required this.province,
    required this.city,
    required this.schedules,
  });

  factory PrayerTimeResponseDTO.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return PrayerTimeResponseDTO(
      province: data['provinsi'] ?? '',
      city: data['kabkota'] ?? '',
      schedules: (data['jadwal'] as List<dynamic>? ?? [])
          .map((e) => PrayerTimeDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class PrayerTimeDTO {
  final int day;
  final String tanggalLengkap;
  final String hari;
  final String imsak;
  final String subuh;
  final String terbit;
  final String dhuha;
  final String dzuhur;
  final String ashar;
  final String maghrib;
  final String isya;

  const PrayerTimeDTO({
    required this.day,
    required this.tanggalLengkap,
    required this.hari,
    required this.imsak,
    required this.subuh,
    required this.terbit,
    required this.dhuha,
    required this.dzuhur,
    required this.ashar,
    required this.maghrib,
    required this.isya,
  });

  factory PrayerTimeDTO.fromJson(Map<String, dynamic> json) {
    return PrayerTimeDTO(
      day: (json['tanggal'] as num?)?.toInt() ?? 0,
      tanggalLengkap: json['tanggal_lengkap'] ?? '',
      hari: json['hari'] ?? '',
      imsak: json['imsak'] ?? '',
      subuh: json['subuh'] ?? '',
      terbit: json['terbit'] ?? '',
      dhuha: json['dhuha'] ?? '',
      dzuhur: json['dzuhur'] ?? '',
      ashar: json['ashar'] ?? '',
      maghrib: json['maghrib'] ?? '',
      isya: json['isya'] ?? '',
    );
  }

  PrayerTime toEntity() {
    return PrayerTime(
      day: day,
      tanggalLengkap: tanggalLengkap,
      hari: hari,
      imsak: imsak,
      subuh: subuh,
      terbit: terbit,
      dhuha: dhuha,
      dzuhur: dzuhur,
      ashar: ashar,
      maghrib: maghrib,
      isya: isya,
    );
  }
}
