import 'package:alquran_new/core/constants/api_endpoints.dart';
import 'package:alquran_new/core/network/dio_client.dart';
import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/features/doa/data/models/doa_response_dto.dart';

abstract class DoaRemoteDataSource {
  Future<Result<DoaListResponseDTO>> getAllDoa();
}

class DoaRemoteDataSourceImpl implements DoaRemoteDataSource {
  final DioClient _client;

  DoaRemoteDataSourceImpl(this._client);

  @override
  Future<Result<DoaListResponseDTO>> getAllDoa() async {
    final result = await _client.get(
      ApiEndpoints.doa,
      customBaseUrl: ApiEndpoints.baseUrlV1,
    );
    return result.when(
      success: (response) {
        final dto = DoaListResponseDTO.fromJson(response.data);
        return Success(dto);
      },
      failure: (message, statusCode) => Failure(message, statusCode: statusCode),
    );
  }
}
