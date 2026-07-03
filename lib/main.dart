import 'package:alquran_new/core/db/hive_service.dart';
import 'package:alquran_new/core/network/dio_client.dart';
import 'package:alquran_new/core/network/network_controller.dart';
import 'package:alquran_new/core/services/notification_service.dart';
import 'package:alquran_new/core/services/ukuran_controller.dart';
import 'package:alquran_new/core/constants/app_theme.dart';

import 'package:alquran_new/features/home/data/datasources/prayer_time_remote_data_source.dart';
import 'package:alquran_new/features/home/data/repositories/prayer_time_repository_impl.dart';
import 'package:alquran_new/features/home/domain/repositories/prayer_time_repository.dart';
import 'package:alquran_new/features/home/domain/usecases/get_prayer_times.dart';
import 'package:alquran_new/features/pengaturan/controllers/notification_settings_controller.dart';
import 'package:alquran_new/features/pengaturan/controllers/settings_controller.dart';
import 'package:alquran_new/features/pengaturan/services/notification_settings_service.dart';
import 'package:alquran_new/features/pengaturan/services/settings_service.dart';
import 'package:alquran_new/features/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  _configureSystemUI();

  try {
    await HiveService.init().timeout(const Duration(seconds: 10));
  } catch (e) {
    debugPrint('HiveService.init error: $e');
  }

  try {
    await GetStorage.init();
  } catch (e) {
    debugPrint('GetStorage.init error: $e');
  }

  try {
    await initializeDateFormatting('id', null);
    Intl.defaultLocale = 'id';
  } catch (e) {
    debugPrint('initializeDateFormatting error: $e');
  }

  try {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));
  } catch (e) {
    debugPrint('tz.initializeTimeZones error: $e');
  }

  try {
    await NotificationService().initialize().timeout(const Duration(seconds: 10));
  } catch (e) {
    debugPrint('NotificationService.init error: $e');
  }

  try {
    final settingsService = SettingsService();
    final settingsController = SettingsController(settingsService);
    await settingsController.loadSettings();
    Get.put(settingsController, permanent: true);
  } catch (e) {
    debugPrint('Settings init error: $e');
  }

  _registerDependencies();

  runApp(const MyApp());
}

void _configureSystemUI() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
}

void _registerDependencies() {
  Get.put(UkuranController(), permanent: true);

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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => FlutterNativeSplash.remove());
    _updateSystemUIOverlay();
  }

  void _updateSystemUIOverlay() {
    final isDark = Get.find<SettingsController>().modeSelected.value == 0;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness:
          isDark ? Brightness.light : Brightness.dark,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final setting = Get.find<SettingsController>();

    return Obx(() {
      final isDark = setting.modeSelected.value == 0;

      WidgetsBinding.instance.addPostFrameCallback((_) => _updateSystemUIOverlay());

      return GetMaterialApp(
        debugShowCheckedModeBanner: false,

        theme: AppTheme.lightTheme(),
        darkTheme: AppTheme.darkTheme(),

        themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.noScaling,
            ),
            child: child!,
          );
        },

        home: const SplashScreen(),
      );
    });
  }
}
