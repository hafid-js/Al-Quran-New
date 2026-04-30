import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  var isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();

    Connectivity().onConnectivityChanged.listen((result) {
      isConnected.value = result != ConnectivityResult.none;
    });
  }
}