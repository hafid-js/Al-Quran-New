import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/development/doa/domain/entities/doa.dart';
import 'package:alquran_new/development/doa/domain/repositories/doa_repository.dart';

class GetAllDoa {
  final DoaRepository repository;

  GetAllDoa(this.repository);

  Future<Result<List<Doa>>> call() async {
    return repository.getAllDoa();
  }
}
