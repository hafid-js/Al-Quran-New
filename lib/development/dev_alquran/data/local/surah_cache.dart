import 'package:hive_ce/hive_ce.dart';

part 'surah_cache.g.dart';

@HiveType(typeId:20)
class SurahCache {
@HiveField(0)
late int nomor;

@HiveField(1)
late String nama;

@HiveField(2)
late String namaLatin;

@HiveField(3)
late int jumlahAyat;

@HiveField(4)
late String tempatTurun;

@HiveField(5)
late String arti;

@HiveField(6)
late String deskripsi;

@HiveField(7)
late String audioFullJson;

}