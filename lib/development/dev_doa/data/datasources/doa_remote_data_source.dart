import 'package:alquran_new/core/constants/api_endpoints.dart';
import 'package:alquran_new/core/network/dio_client.dart';
import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/development/dev_doa/data/models/api_response.dart';
import 'package:alquran_new/development/dev_doa/data/models/doa_dto.dart';

abstract class DoaRemoteDataSource {
  Future<Result<List<DoaDto>>> getAllDoa();
}

class DoaRemoteDataSourceImpl implements DoaRemoteDataSource {
  final DioClient _client;

  DoaRemoteDataSourceImpl(this._client);

  @override
  Future<Result<List<DoaDto>>> getAllDoa() async {
    final result = await _client.get(ApiEndpoints.doa);

    return result.when(
      success: (response) {
        try {
          final parsed = ApiResponse<List<DoaDto>>.fromJson(
            _readBody(response.data),
            (data) => (data as List)
                .map(
                  (e) => DoaDto.fromJson(Map<String, dynamic>.from(e as Map)),
                )
                .toList(),
          );

          if (parsed.code != 200) {
            return Failure(parsed.message, statusCode: parsed.code);
          }

          return Success(parsed.data ?? const <DoaDto>[]);
        } on FormatException catch (e) {
          return Failure(e.message);
        } catch (_) {
          return const Failure('Gagal memproses data doa ');
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
