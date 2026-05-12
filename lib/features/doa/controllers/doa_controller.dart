import 'dart:async';

import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/features/doa/domain/entities/doa.dart';
import 'package:alquran_new/features/doa/domain/usecases/get_all_doa.dart';
import 'package:get/get.dart';

class DoaController extends GetxController {
  final GetAllDoa _getAllDoa = Get.find();

  var isLoading = false.obs;
  var doaList = <Doa>[].obs;
  var filteredDoa = <Doa>[].obs;
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
      final result = await _getAllDoa.call();
      if (result is Success<List<Doa>>) {
        doaList.value = result.data;
        filteredDoa.value = result.data;
      } else if (result is Failure<List<Doa>>) {
        Get.snackbar('Error', result.message);
      }
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
    } else if (searchQuery.value.isNotEmpty) {
      result = result
          .where((e) =>
              e.nama.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
              e.grup.toLowerCase().contains(searchQuery.value.toLowerCase()))
          .toList();
    } else {
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
            .where(
                (e) => e.nama.toLowerCase() == activeCategory.value!.toLowerCase())
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
