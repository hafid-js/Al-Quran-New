import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/features/doa/domain/entities/doa.dart';

abstract class DoaRepository {
  Future<Result<List<Doa>>> getAllDoa();
}
