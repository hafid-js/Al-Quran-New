import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/development/dev_alquran/domain/entities/surah.dart';
import 'package:alquran_new/development/dev_alquran/domain/entities/surah_detail.dart';

abstract class SurahRepository {
  Future<Result<List<Surah>>> getAllSurah();

  Future<Result<SurahDetail>> getDetailSurah(int nomor);
}
