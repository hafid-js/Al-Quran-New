import 'package:alquran_new/development/dev_alquran/domain/entities/ayat.dart';
import 'package:alquran_new/development/dev_alquran/domain/entities/surah.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'surah_detail.freezed.dart';

@freezed
abstract class SurahDetail with _$SurahDetail {
  const factory SurahDetail ({
    required Surah surah,
    @Default(<Ayat>[]) List<Ayat> ayat,
  }) = _SurahDetail;
}