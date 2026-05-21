import 'package:alquran_new/core/network/dio_client.dart';
import 'package:alquran_new/features/doa/data/datasources/doa_remote_data_source.dart';
import 'package:alquran_new/features/doa/data/repositories/doa_repository_impl.dart';
import 'package:alquran_new/features/doa/domain/repositories/doa_repository.dart';
import 'package:alquran_new/features/doa/domain/usecases/get_all_doa.dart';
import 'package:get/get.dart';

class DoaBinding extends Bindings {
  @override
  void dependencies() {

    // datasource
    Get.lazyPut<DoaRemoteDataSource>(
      () => DoaRemoteDataSourceImpl(
        Get.find<DioClient>(),
      ),
    );

    // repository
    Get.lazyPut<DoaRepository>(
      () => DoaRepositoryImpl(
        Get.find<DoaRemoteDataSource>(),
      ),
    );

    // usecase
    Get.lazyPut(
      () => GetAllDoa(
        Get.find<DoaRepository>(),
      ),
    );
  }
}