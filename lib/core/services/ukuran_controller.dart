import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UkuranController extends GetxController {
  static const _keyArab = 'ukuran_teks_arab';
  static const _keyLatin = 'ukuran_latin_terjemah';
  static const _keyShowLatin = 'tampilan_latin';
  static const _keyShowTerjemah = 'tampilan_terjemah';
  static const _keyGetar = 'getar_saat_tap';
  static const _keyTasbih = 'tasbih_scroll';
  static const _defaultArab = 18.0;
  static const _defaultLatin = 14.0;

  final _box = GetStorage();

  final ukuranTeksArab = RxDouble(_defaultArab);
  final ukuranLatinTerjemah = RxDouble(_defaultLatin);
  final latin = true.obs;
  final terjemah = true.obs;
  final getar = true.obs;
  final tasbih = true.obs;

  @override
  void onInit() {
    super.onInit();
    ukuranTeksArab.value = _box.read(_keyArab) ?? _defaultArab;
    ukuranLatinTerjemah.value = _box.read(_keyLatin) ?? _defaultLatin;
    latin.value = _box.read(_keyShowLatin) ?? true;
    terjemah.value = _box.read(_keyShowTerjemah) ?? true;
    getar.value = _box.read(_keyGetar) ?? true;
    tasbih.value = _box.read(_keyTasbih) ?? true;

    ever(ukuranTeksArab, (val) => _box.write(_keyArab, val));
    ever(ukuranLatinTerjemah, (val) => _box.write(_keyLatin, val));
    ever(latin, (val) => _box.write(_keyShowLatin, val));
    ever(terjemah, (val) => _box.write(_keyShowTerjemah, val));
    ever(getar, (val) => _box.write(_keyGetar, val));
    ever(tasbih, (val) => _box.write(_keyTasbih, val));
  }
}
