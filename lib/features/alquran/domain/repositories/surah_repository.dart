import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/features/alquran/domain/entities/surah.dart';
import 'package:alquran_new/features/alquran/domain/entities/detail_surah.dart';
import 'package:alquran_new/features/alquran/domain/entities/tafsir.dart';

abstract class SurahRepository {
  Future<Result<List<Surah>>> getAllSurah();
  Future<Result<DetailSurah>> getDetailSurah(int nomor);
  Future<Result<List<TafsirAyat>>> getTafsir(int nomor);
}
