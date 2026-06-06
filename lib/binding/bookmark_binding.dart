import 'package:alquran_new/core/network/dio_client.dart';
import 'package:alquran_new/core/network/network_controller.dart';
import 'package:alquran_new/features/alquran/data/datasources/surah_remote_data_source.dart';
import 'package:alquran_new/features/alquran/data/repositories/surah_repository_impl.dart';
import 'package:alquran_new/features/alquran/domain/repositories/surah_repository.dart';
import 'package:alquran_new/features/alquran/domain/usecases/get_detail_surah.dart';
import 'package:alquran_new/features/alquran/domain/usecases/get_tafsir.dart';
import 'package:alquran_new/features/bookmark/controllers/bookmark_controller.dart';
import 'package:alquran_new/features/surat/controllers/detail_surah_controller.dart';
import 'package:get/get.dart';

class BookmarkBinding extends Bindings {
  @override
  void dependencies() {
    // // ======================
    // // CORE DEPENDENCY
    // // ======================
    Get.lazyPut<DioClient>(() => DioClient());

    Get.lazyPut<SurahRemoteDataSource>(
      () => SurahRemoteDataSourceImpl(Get.find<DioClient>()),
    );

    Get.lazyPut<SurahRepository>(
      () => SurahRepositoryImpl(Get.find<SurahRemoteDataSource>()),
    );

    Get.lazyPut(() => GetDetailSurah(Get.find()));
    Get.lazyPut(() => GetTafsir(Get.find()));
    Get.put(BookmarkController(), permanent: true);
    Get.lazyPut(() => DetailSurahController());
    Get.lazyPut(() => NetworkController());
  }
}
