import 'package:alquran_new/core/constants/api_endpoints.dart';
import 'package:alquran_new/core/network/dio_client.dart';
import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/features/alquran/data/models/surah_response_dto.dart';
import 'package:alquran_new/features/alquran/data/models/detail_surah_response_dto.dart';
import 'package:alquran_new/features/alquran/data/models/tafsir_response_dto.dart';

abstract class SurahRemoteDataSource {
  Future<Result<SurahListResponseDTO>> getAllSurah();
  Future<Result<DetailSurahResponseDTO>> getDetailSurah(int nomor);
  Future<Result<TafsirResponseDTO>> getTafsir(int nomor);
}

class SurahRemoteDataSourceImpl implements SurahRemoteDataSource {
  final DioClient _client;

  SurahRemoteDataSourceImpl(this._client);

  @override
  Future<Result<SurahListResponseDTO>> getAllSurah() async {
    final result = await _client.get(ApiEndpoints.surah);
    return result.when(
      success: (response) {
        final dto = SurahListResponseDTO.fromJson(response.data);
        return Success(dto);
      },
      failure: (message, statusCode) => Failure(message, statusCode: statusCode),
    );
  }

  @override
  Future<Result<DetailSurahResponseDTO>> getDetailSurah(int nomor) async {
    final result = await _client.get(ApiEndpoints.detailSurah(nomor));
    return result.when(
      success: (response) {
        final dto = DetailSurahResponseDTO.fromJson(response.data);
        return Success(dto);
      },
      failure: (message, statusCode) => Failure(message, statusCode: statusCode),
    );
  }

  @override
  Future<Result<TafsirResponseDTO>> getTafsir(int nomor) async {
    final result = await _client.get(ApiEndpoints.tafsirAyat(nomor));
    return result.when(
      success: (response) {
        final dto = TafsirResponseDTO.fromJson(response.data);
        return Success(dto);
      },
      failure: (message, statusCode) => Failure(message, statusCode: statusCode),
    );
  }
}

