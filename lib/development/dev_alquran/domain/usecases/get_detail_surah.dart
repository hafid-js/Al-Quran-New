import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/development/dev_alquran/domain/entities/surah_detail.dart';
import 'package:alquran_new/development/dev_alquran/domain/repositories/surah_repository.dart';

class GetDetailSurah {
  final SurahRepository _repository;

  GetDetailSurah(this._repository);

  Future<Result<SurahDetail>> call(int nomor) =>
      _repository.getDetailSurah(nomor);
}
