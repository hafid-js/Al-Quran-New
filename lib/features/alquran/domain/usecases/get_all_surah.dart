import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/features/alquran/domain/entities/surah.dart';
import 'package:alquran_new/features/alquran/domain/repositories/surah_repository.dart';

class GetAllSurah {
  final SurahRepository repository;

  GetAllSurah(this.repository);

  Future<Result<List<Surah>>> call() async {
    return repository.getAllSurah();
  }
}
