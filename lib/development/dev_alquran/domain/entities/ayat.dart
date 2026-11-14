import 'package:freezed_annotation/freezed_annotation.dart';
part 'ayat.freezed.dart';


@freezed
abstract class Ayat with _$Ayat {
  const factory Ayat ({
    required int nomorAyat,
    required String teksArab,
    required String teksLatin,
    required String teksIndonesia,
    required Map<String, String> audio
  }) = _Ayat;
}