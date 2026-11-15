import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/development/dev_doa/domain/entities/doa.dart';
import 'package:alquran_new/development/dev_doa/domain/repositories/doa_repository.dart';

class GetAllDoa {
  final DoaRepository _repository;

  GetAllDoa(this._repository);

  Future<Result<List<Doa>>> call() => _repository.getAllDoa();
}
