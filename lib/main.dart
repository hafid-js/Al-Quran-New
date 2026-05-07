import 'package:alquran_new/core/network/network_controller.dart';
import 'package:alquran_new/features/pengaturan/pengaturan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  Get.put(NetworkController());
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('id', null);
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: PengaturanScreen(),
      darkTheme: ThemeData.dark(),
    );
  }
}

// // SplashScreen untuk cek token
// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final token = TokenStorage.getToken();

//     // Delay sebentar untuk menunggu GetStorage ready
//     Future.microtask(() {
//       if (token != null) {
//         Get.off(() => const MainScreen());
//       } else {
//         Get.off(() => const LoginScreen());
//       }
//     });

//     return const Scaffold(
//       body: Center(child: CircularProgressIndicator()),
//     );
//   }
// }
