// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:get/get.dart';

// class NetworkController extends GetxController {
//   var isConnected = true.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     _initConnectivity();
//   }

//   void _initConnectivity() {
//     try {
//       Connectivity().onConnectivityChanged.listen((results) {
//         isConnected.value = results.isNotEmpty &&
//             !results.contains(ConnectivityResult.none);
//       });
//     } catch (_) {
//       isConnected.value = true;
//     }
//   }
// }


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  var isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    _initConnectivity();
  }

  Future<void> _initConnectivity() async {
    try {

      final result = await _connectivity.checkConnectivity();

      isConnected.value = result.isNotEmpty &&
          !result.contains(ConnectivityResult.none);


      _connectivity.onConnectivityChanged.listen((results) {
        isConnected.value = results.isNotEmpty &&
            !results.contains(ConnectivityResult.none);
      });
    } catch (_) {
      isConnected.value = false;
    }
  }
}