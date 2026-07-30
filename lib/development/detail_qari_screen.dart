import 'dart:async';

import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/development/murrotal/controllers/murrotal_controller.dart';
import 'package:alquran_new/development/murrotal/detail_murrotal_screen.dart';

import 'package:alquran_new/features/alquran/controllers/surah_controller.dart';
import 'package:alquran_new/features/alquran/domain/entities/surah.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class DetailQariScreen extends StatefulWidget {
  final int qariIndex;
  const DetailQariScreen({super.key, required this.qariIndex});

  @override
  State<DetailQariScreen> createState() => _DetailQariScreenState();
}

class _DetailQariScreenState extends State<DetailQariScreen> {
  final _searchController = TextEditingController();
  final surahController = Get.find<SurahController>();
  Timer? _debounce;
  List<Surah> _filteredSurah = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _filteredSurah = surahController.surahList;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      final query = value.toLowerCase().trim();
      setState(() {
        _isSearching = query.isNotEmpty;
        if (query.isEmpty) {
          _filteredSurah = surahController.surahList;
        } else {
          _filteredSurah = surahController.surahList
              .where((s) =>
                  s.namaLatin.toLowerCase().contains(query) ||
                  s.nama.toLowerCase().contains(query) ||
                  s.arti.toLowerCase().contains(query))
              .toList();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final qariData = MurrotalController.qariData[widget.qariIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor.fromHex("#256980"),
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
              HexColor.fromHex("#256980").withAlpha(210),
              BlendMode.srcATop,
            ),
            fit: BoxFit.cover,
            image: AssetImage("assets/images/image.png"),
          ),
          color: HexColor.fromHex("#256980"),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 26, vertical: 0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(16),
                    child: Image.asset(
                      qariData["image"]!,
                      width: 100,
                      height: 110,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    qariData["title"]!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    qariData["deskripsi"] ?? "",
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 12,
                top: 20,
                left: 12,
                right: 12,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      "Pilihan Surat",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 140,
                      child: TextField(
                        controller: _searchController,
                        onChanged: _onSearchChanged,
                        autofocus: false,
                        decoration: const InputDecoration(
                          hintText: 'Cari...',
                          prefixIcon: Icon(Iconsax.search_normal_1),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          isDense: true,
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 28,
                            minHeight: 28,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                final surahList = _isSearching
                    ? _filteredSurah
                    : surahController.surahList;
                if (surahList.isEmpty) {
                  return Center(
                    child: Text(
                      _isSearching ? "Surat tidak ditemukan" : "Memuat...",
                      style: TextStyle(color: Colors.white70),
                    ),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  itemCount: surahList.length,
                  itemBuilder: (context, index) {
                    final surah = surahList[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          visualDensity: const VisualDensity(vertical: -1),
                          contentPadding: EdgeInsets.only(right: 4, left: 4),
                          title: Text(
                            surah.namaLatin,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: HexColor.fromHex("#256980"),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          subtitle: Text(
                            surah.arti,
                            style: TextStyle(
                              color: HexColor.fromHex("#676767"),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              Get.to(
                                () => DetailMurrotalScreen(
                                  qariIndex: widget.qariIndex,
                                  surahNomor: surah.nomor,
                                  surahNama: surah.namaLatin,
                                  surahArti: surah.arti,
                                  qariNama: qariData["title"]!,
                                  qariImage: qariData["image"]!,
                                ),
                              );
                            },
                            child: Icon(
                              Iconsax.play_circle5,
                              color: HexColor.fromHex("#256980"),
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
