import 'dart:async';

import 'package:alquran_new/features/lokasi/location_controller.dart';
import 'package:alquran_new/features/lokasi/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class LokasiScreen extends StatefulWidget {
  const LokasiScreen({super.key});

  @override
  State<LokasiScreen> createState() => _LokasiScreenState();
}

class _LokasiScreenState extends State<LokasiScreen> {
  late final LocationController c;
  late final ValueNotifier<String?> provinceNotifier;
  late final ValueNotifier<String?> cityNotifier;
  StreamSubscription? _provinceSub;
  StreamSubscription? _citySub;

  @override
  void initState() {
    super.initState();
    c = Get.put(LocationController());
    provinceNotifier = ValueNotifier<String?>(c.selectedProvince.value);
    cityNotifier = ValueNotifier<String?>(c.selectedCity.value);
    _provinceSub = c.selectedProvince.listen((v) => provinceNotifier.value = v);
    _citySub = c.selectedCity.listen((v) => cityNotifier.value = v);
  }

  @override
  void dispose() {
    _provinceSub?.cancel();
    _citySub?.cancel();
    provinceNotifier.dispose();
    cityNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_circle_left_rounded),
          color: Theme.of(context).iconTheme.color,
        ),
        titleSpacing: 20,
        title: Row(
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Icon(
                Icons.menu_book_rounded,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pilih Lokasi",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(() {
          final city = c.selectedCity.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (c.isLoadingProvince.value)
                const Center(child: CircularProgressIndicator())
              else
                Text(
                  "Provinsi",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              SizedBox(height: 10),
              DropdownButtonFormField2<String>(
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(color: Theme.of(context).cardColor),
                ),
                isExpanded: true,
                valueListenable: provinceNotifier,
                items: c.provinces.map((e) {
                  final selected = c.selectedProvince.value == e;

                  return DropdownItem<String>(
                    value: e,

                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              e,
                              style: TextStyle(
                                fontSize: 16,

                                fontWeight: FontWeight.w400,
                                color: selected
                                    ? Theme.of(context).colorScheme.primary
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    c.selectProvince(value);
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(width: 1, color: Colors.white),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(width: 1, color: Colors.white),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                hint: const Text(
                  "Pilih Provinsi",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              const SizedBox(height: 30),
              Text(
                "Kabupaten / Kota",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField2<String>(
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(color: Theme.of(context).cardColor),
                ),
                isExpanded: true,
                valueListenable: cityNotifier,
                items: c.selectedProvince.value == null || c.isLoadingCity.value
                    ? []
                    : c.cities.map((e) {
                        return DropdownItem<String>(
                          value: e,
                          child: Text(
                            e,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                      }).toList(),
                onChanged:
                    c.selectedProvince.value == null || c.isLoadingCity.value
                    ? null
                    : (value) {
                        if (value != null) {
                          c.selectCity(value);
                        }
                      },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(width: 1, color: Colors.white),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(width: 1, color: Colors.white),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                hint: Text(
                  c.isLoadingCity.value
                      ? "Memuat kota..."
                      : c.selectedProvince.value == null
                      ? "Pilih provinsi dulu"
                      : "Pilih kota",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),

              if (city != null) ...[
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final province = c.selectedProvince.value;
                      final city = c.selectedCity.value;

                      if(province == null || city == null) return;

                      await LocationService.saveLocation(province, city);
                      Get.snackbar(
                        "Lokasi Disimpan",
                        "$province, $city",
                      );

               
                    },
                    child: const Text("Simpan"),
                  ),
                ),
              ],
            ],
          );
        })
      ),
    );
  }
}
