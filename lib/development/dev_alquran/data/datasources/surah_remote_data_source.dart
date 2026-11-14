import 'package:alquran_new/core/constants/api_endpoints.dart';
import 'package:alquran_new/core/network/dio_client.dart';
import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/development/dev_alquran/data/models/api_response.dart';
import 'package:alquran_new/development/dev_alquran/data/models/surah_detail_dto.dart';
import 'package:alquran_new/development/dev_alquran/data/models/surah_dto.dart';

abstract class SurahRemoteDataSource {
  Future<Result<List<SurahDto>>> getAllSurah();

  Future<Result<SurahDetailDto>> getDetailSurah(int nomor);
}

class SurahRemoteDataSourceImpl implements SurahRemoteDataSource {
  final DioClient _client;

  SurahRemoteDataSourceImpl(this._client);

  @override
  Future<Result<List<SurahDto>>> getAllSurah() async {
    final result = await _client.get(ApiEndpoints.surah);

    return result.when(
      success: (response) {
        try {
          final parsed = ApiResponse<List<SurahDto>>.fromJson(
            _readBody(response.data),
            (data) => (data as List)
                .map(
                  (e) => SurahDto.fromJson(Map<String, dynamic>.from(e as Map)),
                )
                .toList(),
          );

          if (parsed.code != 200) {
            return Failure(parsed.message, statusCode: parsed.code);
          }

          return Success(parsed.data ?? const <SurahDto>[]);
        } on FormatException catch (e) {
          return Failure(e.message);
        } catch (_) {
          return const Failure('Gagal memproses detail surah.');
        }
      },
      failure: (message, statusCode) =>
          Failure(message, statusCode: statusCode),
    );
  }

  @override
  Future<Result<SurahDetailDto>> getDetailSurah(int nomor) async {
    final result = await _client.get(ApiEndpoints.detailSurah(nomor));

    return result.when(
      success: (response) {
        try {
          final parsed = ApiResponse<SurahDetailDto>.fromJson(
            _readBody(response.data),
            (data) =>
                SurahDetailDto.fromJson(Map<String, dynamic>.from(data as Map)),
          );

          if (parsed.code != 200) {
            return Failure(parsed.message, statusCode: parsed.code);
          }

          final detail = parsed.data;

          if (detail == null) {
            return const Failure('Data surah tidak tersedia');
          }

          return Success(detail);
        } on FormatException catch (e) {
          return Failure(e.message);
        } catch (_) {
          return const Failure('Gagal memproses detail surah.');
        }
      },
      failure: (message, statusCode) =>
          Failure(message, statusCode: statusCode),
    );
  }
}

Map<String, dynamic> _readBody(dynamic data) {
  if (data is Map<String, dynamic>) {
    return data;
  }
  if (data is Map) {
    return Map<String, dynamic>.from(data);
  }

  throw const FormatException('Format response dari server tidak valid');
}
