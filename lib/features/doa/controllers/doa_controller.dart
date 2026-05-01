import 'dart:async';

import 'package:alquran_new/features/doa/models/doa_model.dart';
import 'package:alquran_new/features/doa/services/doa_service.dart';
import 'package:get/get.dart';

class DoaController extends GetxController {
  final DoaService _service = DoaService();

  var isLoading = false.obs;
  var doaList = <Doa>[].obs;
  RxList<Doa> filteredDoa = <Doa>[].obs;
  var activeCategory = RxnString();
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDoa();
  }

  Future<void> fetchDoa() async {
    try {
      isLoading.value = true;

      final result = await _service.getAllDoa();

      doaList.value = result;
      filteredDoa.value = result;

    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void filter(String? category, String? query) {
    activeCategory.value = category;
    searchQuery.value = query ?? '';
    List<Doa> result = doaList;

    if (category == null) {
      filteredDoa.value = doaList.toList();
    } else if (searchQuery.value.isNotEmpty){
      
      result = result.where((e) {
      return e.nama.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
             e.grup.toLowerCase().contains(searchQuery.value.toLowerCase());
    }).toList();
    }

     else {
      filteredDoa.value = doaList
          .where((e) => e.grup.toLowerCase() == category.toLowerCase())
          .toList();
    }
    


  }

  Timer? _debounce;

void search(String value) {
  _debounce?.cancel();

  _debounce = Timer(const Duration(milliseconds: 300), () {
    final query = value.toLowerCase();

    List<Doa> result = doaList;

    if (activeCategory.value != null) {
      result = result
          .where((e) => e.nama.toLowerCase() ==
              activeCategory.value!.toLowerCase())
          .toList();
    }

    if (query.isNotEmpty) {
      result = result
          .where((e) => e.nama.toLowerCase().contains(query))
          .toList();
    }

    filteredDoa.value = result;
  });
}

  List<String> get categories {
  final set = <String>{};
  for (final e in doaList) {
    set.add(e.grup);
  }
  return set.toList()..sort();
}
}
