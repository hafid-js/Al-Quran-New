import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  var isConnected = true.obs;

  StreamSubscription<List<ConnectivityResult>>? _subscription;

  @override
  void onInit() {
    super.onInit();
    _initConnectivity();
  }

  Future<void> _initConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      isConnected.value =
          result.isNotEmpty && !result.contains(ConnectivityResult.none);

      _subscription = _connectivity.onConnectivityChanged.listen((results) {
        final connected =
            results.isNotEmpty && !results.contains(ConnectivityResult.none);
        isConnected.value = connected;
      });
    } catch (_) {
      isConnected.value = false;
    }
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
