import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/development/dev_alquran/domain/entities/surah.dart';
import 'package:alquran_new/development/dev_alquran/domain/repositories/surah_repository.dart';

class GetAllSurah {
  final SurahRepository _repository;

  GetAllSurah(this._repository);

  Future<Result<List<Surah>>> call() => _repository.getAllSurah();
}