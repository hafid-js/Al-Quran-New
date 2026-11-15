import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/development/dev_doa/data/datasources/doa_remote_data_source.dart';
import 'package:alquran_new/development/dev_doa/data/models/doa_dto.dart';
import 'package:alquran_new/development/dev_doa/domain/entities/doa.dart';
import 'package:alquran_new/development/dev_doa/domain/repositories/doa_repository.dart';

class DoaRepositoryImpl implements DoaRepository {
  final DoaRemoteDataSource _remoteDataSource;

  DoaRepositoryImpl(this._remoteDataSource, Object object);

  @override
  Future<Result<List<Doa>>> getAllDoa() async {
    final result = await _remoteDataSource.getAllDoa();

    return result.when(
      success: (dtos) async {
        final doas = dtos.map((dto) => dto.toEntity()).toList();

        return Success<List<Doa>>(doas);
      },
      failure: (message, statusCode) async {
        return Failure(message, statusCode: statusCode);
      }
    );
  }
}