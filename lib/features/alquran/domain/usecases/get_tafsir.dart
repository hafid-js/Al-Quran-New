import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/features/alquran/domain/entities/tafsir.dart';
import 'package:alquran_new/features/alquran/domain/repositories/surah_repository.dart';

class GetTafsir {
  final SurahRepository repository;

  GetTafsir(this.repository);

  Future<Result<List<TafsirAyat>>> call(int nomor) async {
    return repository.getTafsir(nomor);
  }
}
