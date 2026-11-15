import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/development/dev_doa/domain/entities/doa.dart';

abstract class DoaRepository {
  Future<Result<List<Doa>>> getAllDoa();
}
