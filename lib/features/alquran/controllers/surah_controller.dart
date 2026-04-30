
import 'package:alquran_new/features/alquran/models/surah_model.dart';
import 'package:alquran_new/features/alquran/services/surah_service.dart';
import 'package:get/get.dart';

class SurahController extends GetxController {
  final SurahService _service = SurahService();

  var isLoading = false.obs;
  var surahList = <Surah>[].obs;
  var filteredSurah = <Surah>[].obs;

  var activeCategory = "Surah".obs;

  @override
  void onInit() {
    super.onInit();
    fetchSurah();
  }

  Future<void> fetchSurah() async {
    try {
      isLoading.value = true;

      final result = await _service.getAllSurah();

      print(result);

      surahList.value = result;
      filteredSurah.value = result;
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void filter(String category) {
    activeCategory.value = category;

    if (category == "Surah") {
      filteredSurah.value = surahList;
    } else {
      filteredSurah.value = surahList
          .where(
            (e) => e.tempatTurun.name.toLowerCase() == category.toLowerCase(),
          )
          .toList();
    }
  }

}
