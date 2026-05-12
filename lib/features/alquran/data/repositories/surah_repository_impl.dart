import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/features/alquran/data/datasources/surah_remote_data_source.dart';
import 'package:alquran_new/features/alquran/domain/entities/surah.dart';
import 'package:alquran_new/features/alquran/domain/entities/detail_surah.dart';
import 'package:alquran_new/features/alquran/domain/entities/tafsir.dart';
import 'package:alquran_new/features/alquran/domain/repositories/surah_repository.dart';

class SurahRepositoryImpl implements SurahRepository {
  final SurahRemoteDataSource _remoteDataSource;

  SurahRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<Surah>>> getAllSurah() async {
    final result = await _remoteDataSource.getAllSurah();
    return result.when(
      success: (dto) => Success(dto.data.map((e) => e.toEntity()).toList()),
      failure: (message, statusCode) => Failure(message, statusCode: statusCode),
    );
  }

  @override
  Future<Result<DetailSurah>> getDetailSurah(int nomor) async {
    final result = await _remoteDataSource.getDetailSurah(nomor);
    return result.when(
      success: (dto) => Success(dto.data.toEntity()),
      failure: (message, statusCode) => Failure(message, statusCode: statusCode),
    );
  }

  @override
  Future<Result<List<TafsirAyat>>> getTafsir(int nomor) async {
    final result = await _remoteDataSource.getTafsir(nomor);
    return result.when(
      success: (dto) =>
          Success(dto.data.tafsir.map((e) => e.toEntity()).toList()),
      failure: (message, statusCode) => Failure(message, statusCode: statusCode),
    );
  }
}
