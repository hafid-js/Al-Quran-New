import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/features/doa/data/datasources/doa_remote_data_source.dart';
import 'package:alquran_new/features/doa/domain/entities/doa.dart';
import 'package:alquran_new/features/doa/domain/repositories/doa_repository.dart';

class DoaRepositoryImpl implements DoaRepository {
  final DoaRemoteDataSource _remoteDataSource;

  DoaRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<Doa>>> getAllDoa() async {
    final result = await _remoteDataSource.getAllDoa();
    return result.when(
      success: (dto) => Success(dto.data.map((e) => e.toEntity()).toList()),
      failure: (message, statusCode) => Failure(message, statusCode: statusCode),
    );
  }
}
