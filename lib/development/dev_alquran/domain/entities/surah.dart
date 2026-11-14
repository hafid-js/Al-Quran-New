import 'package:alquran_new/development/dev_alquran/domain/entities/tempat_turun.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'surah.freezed.dart';

@freezed
abstract class Surah with _$Surah {
  const factory Surah({
    required int nomor,
    required String nama,
    required String namaLatin,
    required int jumlahAyat,
    required TempatTurun tempatTurun,
    required String arti,
    required String deskripsi,
    required Map<String, String> audioFull,
  }) = _Surah;
}
