import 'package:alquran_new/core/db/hive_service.dart';
import 'package:alquran_new/core/network/dio_client.dart';
import 'package:alquran_new/core/network/network_controller.dart';
import 'package:alquran_new/core/services/notification_service.dart';
import 'package:alquran_new/core/utils/constants/app_theme.dart';

import 'package:alquran_new/features/home/data/datasources/prayer_time_remote_data_source.dart';
import 'package:alquran_new/features/home/data/repositories/prayer_time_repository_impl.dart';
import 'package:alquran_new/features/home/domain/repositories/prayer_time_repository.dart';
import 'package:alquran_new/features/home/domain/usecases/get_prayer_times.dart';
import 'package:alquran_new/features/home/screens/home_screen.dart';
import 'package:alquran_new/features/pengaturan/controllers/notification_settings_controller.dart';
import 'package:alquran_new/features/pengaturan/controllers/settings_controller.dart';
import 'package:alquran_new/features/pengaturan/services/notification_settings_service.dart';
import 'package:alquran_new/features/pengaturan/services/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await HiveService.init().timeout(const Duration(seconds: 10));
  } catch (_) {}

  try {
    await GetStorage.init();
  } catch (_) {}

  try {
    await initializeDateFormatting('id', null);
    Intl.defaultLocale = 'id';
  } catch (_) {}

  try {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));
  } catch (_) {}

  try {
    await NotificationService().initialize().timeout(const Duration(seconds: 10));
  } catch (_) {}

  try {
    final settingsService = SettingsService();
    final settingsController = SettingsController(settingsService);
    await settingsController.loadSettings();
    Get.put(settingsController, permanent: true);
  } catch (_) {}

  _registerDependencies();

  runApp(const MyApp());
}

void _registerDependencies() {
  final dioClient = DioClient();
  Get.put(dioClient);

    Get.put(NetworkController(), permanent: true);

  final prayerTimeRemoteDataSource = PrayerTimeRemoteDataSourceImpl(dioClient);

  Get.put<PrayerTimeRemoteDataSource>(prayerTimeRemoteDataSource);

  final prayerTimeRepository = PrayerTimeRepositoryImpl(
    prayerTimeRemoteDataSource,
  );

  Get.put<PrayerTimeRepository>(prayerTimeRepository);

  Get.put(GetPrayerTimes(prayerTimeRepository));

  Get.put(
    SettingsController(SettingsService()),
    permanent: true,
  );

  Get.put(NotificationSettingsService());

  Get.put(
    NotificationSettingsController(
      Get.find<NotificationSettingsService>(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final setting = Get.find<SettingsController>();

    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,

        theme: AppTheme.lightTheme(),
        darkTheme: AppTheme.darkTheme(),

        themeMode: setting.modeSelected.value == 0
            ? ThemeMode.dark
            : ThemeMode.light,

        home: HomeScreen(),
      );
    });
  }
}
