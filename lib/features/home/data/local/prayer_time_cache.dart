import 'package:hive/hive.dart';
import 'package:alquran_new/features/home/models/prayer_time_model.dart';

part 'prayer_time_cache.g.dart';

@HiveType(typeId: 8)
class PrayerTimeCache extends HiveObject {
  PrayerTimeCache();

  @HiveField(0)
  late int day;
  @HiveField(1)
  late String tanggalLengkap;
  @HiveField(2)
  late String hari;
  @HiveField(3)
  late String imsak;
  @HiveField(4)
  late String subuh;
  @HiveField(5)
  late String terbit;
  @HiveField(6)
  late String dhuha;
  @HiveField(7)
  late String dzuhur;
  @HiveField(8)
  late String ashar;
  @HiveField(9)
  late String maghrib;
  @HiveField(10)
  late String isya;
  @HiveField(11)
  String? province;
  @HiveField(12)
  String? city;

  PrayerTimeModel toEntity() => PrayerTimeModel(
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

  factory PrayerTimeCache.fromEntity(PrayerTimeModel model,
      {String? province, String? city}) {
    return PrayerTimeCache()
      ..day = model.day
      ..tanggalLengkap = model.tanggalLengkap
      ..hari = model.hari
      ..imsak = model.imsak
      ..subuh = model.subuh
      ..terbit = model.terbit
      ..dhuha = model.dhuha
      ..dzuhur = model.dzuhur
      ..ashar = model.ashar
      ..maghrib = model.maghrib
      ..isya = model.isya
      ..province = province
      ..city = city;
  }
}
