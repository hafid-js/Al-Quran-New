import 'package:alquran_new/core/network/network_controller.dart';
import 'package:alquran_new/core/network/dio_client.dart';
import 'package:alquran_new/core/services/notification_service.dart';

import 'package:alquran_new/features/alquran/data/datasources/surah_remote_data_source.dart';
import 'package:alquran_new/features/alquran/data/repositories/surah_repository_impl.dart';
import 'package:alquran_new/features/alquran/domain/repositories/surah_repository.dart';
import 'package:alquran_new/features/alquran/domain/usecases/get_all_surah.dart';
import 'package:alquran_new/features/alquran/domain/usecases/get_detail_surah.dart';
import 'package:alquran_new/features/alquran/domain/usecases/get_tafsir.dart';

import 'package:alquran_new/features/doa/data/datasources/doa_remote_data_source.dart';
import 'package:alquran_new/features/doa/data/repositories/doa_repository_impl.dart';
import 'package:alquran_new/features/doa/domain/repositories/doa_repository.dart';
import 'package:alquran_new/features/doa/domain/usecases/get_all_doa.dart';

import 'package:alquran_new/features/home/controllers/prayer_time_controller.dart';
import 'package:alquran_new/features/home/data/datasources/prayer_time_remote_data_source.dart';
import 'package:alquran_new/features/home/data/repositories/prayer_time_repository_impl.dart';
import 'package:alquran_new/features/home/domain/repositories/prayer_time_repository.dart';
import 'package:alquran_new/features/home/domain/usecases/get_prayer_times.dart';
import 'package:alquran_new/features/home/screens/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init storage dulu
  await GetStorage.init();

  // init locale Indonesia SEBELUM runApp
  await initializeDateFormatting('id', null);

  // optional: set default locale
  Intl.defaultLocale = 'id';

  // register dependency
  Get.put(NetworkController());
  _registerDependencies();

  // init notification (singleton)
  try {
    await NotificationService().initialize();
  } catch (e) {
    debugPrint('Notification init error: $e');
  }

  runApp(const MyApp());
}

void _registerDependencies() {
  final dioClient = DioClient();
  Get.put(dioClient);

  // SURAH
  final surahRemoteDataSource = SurahRemoteDataSourceImpl(dioClient);
  Get.put<SurahRemoteDataSource>(surahRemoteDataSource);

  final surahRepository =
      SurahRepositoryImpl(surahRemoteDataSource);

  Get.put<SurahRepository>(surahRepository);

  Get.put(GetAllSurah(surahRepository));
  Get.put(GetDetailSurah(surahRepository));
  Get.put(GetTafsir(surahRepository));

  // DOA
  final doaRemoteDataSource =
      DoaRemoteDataSourceImpl(dioClient);

  Get.put<DoaRemoteDataSource>(doaRemoteDataSource);

  final doaRepository =
      DoaRepositoryImpl(doaRemoteDataSource);

  Get.put<DoaRepository>(doaRepository);

  Get.put(GetAllDoa(doaRepository));

  // PRAYER TIME
  final prayerTimeRemoteDataSource =
      PrayerTimeRemoteDataSourceImpl(dioClient);

  Get.put<PrayerTimeRemoteDataSource>(
    prayerTimeRemoteDataSource,
  );

  final prayerTimeRepository =
      PrayerTimeRepositoryImpl(
    prayerTimeRemoteDataSource,
  );

  Get.put<PrayerTimeRepository>(
    prayerTimeRepository,
  );

  Get.put(GetPrayerTimes(prayerTimeRepository));

  // Get.put(
  //   PrayerTimeController(repo: PrayerTimeRepository),
  //   permanent: true,
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}