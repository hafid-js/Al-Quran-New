

import 'package:alquran_new/features/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp(), );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen()
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
