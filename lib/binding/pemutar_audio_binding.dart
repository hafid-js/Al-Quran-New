import 'package:alquran_new/core/network/dio_client.dart';
import 'package:alquran_new/features/alquran/controllers/surah_controller.dart';
import 'package:alquran_new/features/alquran/data/datasources/surah_remote_data_source.dart';
import 'package:alquran_new/features/alquran/data/repositories/surah_repository_impl.dart';
import 'package:alquran_new/features/alquran/domain/repositories/surah_repository.dart';
import 'package:alquran_new/features/alquran/domain/usecases/get_all_surah.dart';
import 'package:get/get.dart';

class PemutarAudioBinding extends Bindings {
  @override
  void dependencies() {
        Get.lazyPut<SurahRemoteDataSource>(
      () => SurahRemoteDataSourceImpl(
        Get.find<DioClient>(),
      ),
    );

    Get.lazyPut<SurahRepository>(
      () => SurahRepositoryImpl(
        Get.find<SurahRemoteDataSource>(),
      ),
    );
    Get.lazyPut(() => GetAllSurah(Get.find()));
    Get.lazyPut(() => SurahController());
  }
}