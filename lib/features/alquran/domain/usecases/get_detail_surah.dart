import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/features/alquran/domain/entities/detail_surah.dart';
import 'package:alquran_new/features/alquran/domain/repositories/surah_repository.dart';

class GetDetailSurah {
  final SurahRepository repository;

  GetDetailSurah(this.repository);

  Future<Result<DetailSurah>> call(int nomor) async {
    return repository.getDetailSurah(nomor);
  }
}
