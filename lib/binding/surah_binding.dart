import 'package:alquran_new/core/network/dio_client.dart';
import 'package:alquran_new/core/network/network_controller.dart';
import 'package:alquran_new/development/alquran_controller.dart';
import 'package:alquran_new/development/hizb_controller.dart';
import 'package:alquran_new/features/alquran/controllers/surah_controller.dart';
import 'package:alquran_new/features/alquran/data/datasources/surah_remote_data_source.dart';
import 'package:alquran_new/features/alquran/data/repositories/surah_repository_impl.dart';
import 'package:alquran_new/features/alquran/domain/repositories/surah_repository.dart';
import 'package:alquran_new/features/alquran/domain/usecases/get_all_surah.dart';
import 'package:alquran_new/features/alquran/domain/usecases/get_detail_surah.dart';
import 'package:alquran_new/features/alquran/domain/usecases/get_tafsir.dart';
import 'package:alquran_new/features/surat/controllers/detail_surah_controller.dart';
import 'package:get/get.dart';

class SurahBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<DioClient>(() => DioClient(), fenix: true);

    Get.lazyPut<SurahRemoteDataSource>(
      () => SurahRemoteDataSourceImpl(
        Get.find<DioClient>(),
      ),
      fenix: true,
    );

    Get.lazyPut<SurahRepository>(
      () => SurahRepositoryImpl(
        Get.find<SurahRemoteDataSource>(),
      ),
      fenix: true,
    );

    Get.lazyPut(() => GetAllSurah(Get.find()), fenix: true);
    Get.lazyPut(() => GetDetailSurah(Get.find()), fenix: true);
    Get.lazyPut(() => GetTafsir(Get.find()), fenix: true);

    Get.lazyPut(() => SurahController(), fenix: true);
    Get.lazyPut(() => DetailSurahController(), fenix: true);
    Get.lazyPut(() => JuzController(), fenix: true);
    Get.lazyPut(() => HizbController(), fenix: true);
    Get.lazyPut(() => NetworkController(), fenix: true);
  }
}