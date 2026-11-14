import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/development/dev_alquran/data/datasources/surah_remote_data_source.dart';
import 'package:alquran_new/development/dev_alquran/data/local/cache_mapper.dart';
import 'package:alquran_new/development/dev_alquran/data/local/surah_local_data_source.dart';
import 'package:alquran_new/development/dev_alquran/data/models/surah_detail_dto.dart';
import 'package:alquran_new/development/dev_alquran/data/models/surah_dto.dart';
import 'package:alquran_new/development/dev_alquran/domain/entities/surah.dart';
import 'package:alquran_new/development/dev_alquran/domain/entities/surah_detail.dart';
import 'package:alquran_new/development/dev_alquran/domain/repositories/surah_repository.dart';

class SurahRepositoryImpl implements SurahRepository {
  final SurahRemoteDataSource _remoteDataSource;
  final SurahLocalDataSource _localDataSource;

  SurahRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Result<List<Surah>>> getAllSurah() async {
    final result = await _remoteDataSource.getAllSurah();

    return result.when(
      success: (dtos) async {
        final surahs = dtos.map((dto) => dto.toEntity()).toList();

        await _localDataSource.saveAllSurah(surahs.map(surahToCache).toList());

        return Success<List<Surah>>(surahs);
      },

      failure: (message, statusCode) async {
        final cached = await _localDataSource.getAllSurah();

        if (cached.isNotEmpty) {
          return Success<List<Surah>>(cached.map((e) => e.toEntity()).toList());
        }

        return Failure(message, statusCode: statusCode);
      },
    );
  }

  @override
  Future<Result<SurahDetail>> getDetailSurah(int nomor) async {
    final result = await _remoteDataSource.getDetailSurah(nomor);

    return result.when(
      success: (dto) async {
        final detail = dto.toEntity();

        await _localDataSource.saveSurahDetail(
          surahToCache(detail.surah),
          detail.ayat.map((ayat) => ayatToCache(ayat, detail.surah.nomor)).toList()
        );

        return Success<SurahDetail>(detail);
      },
      failure: (message, statusCode) async {
        final cachedSurah = await _localDataSource.getSurahByNomor(nomor);

        if(cachedSurah != null) {
          final cachedAyat = await _localDataSource.getAyatBySurah(nomor);

          return Success<SurahDetail>(
            SurahDetail(
              surah: cachedSurah.toEntity(),
              ayat: cachedAyat.map((e) => e.toEntity()).toList()
            )
          );
        }

        return Failure<SurahDetail>(message, statusCode: statusCode);
      }
    );
  }
}
