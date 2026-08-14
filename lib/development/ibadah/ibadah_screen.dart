import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class IbadahScreen extends StatefulWidget {
  const IbadahScreen({super.key});

  @override
  State<IbadahScreen> createState() => _IbadahScreenState();
}

class _IbadahScreenState extends State<IbadahScreen> {
  final List<Map<String, dynamic>> _sholatWajib = [
    {'name': 'Subuh', 'done': true},
    {'name': 'Dzuhur', 'done': true},
    {'name': 'Ashar', 'done': false},
    {'name': 'Maghrib', 'done': false},
    {'name': 'Isya', 'done': false},
  ];

  final List<Map<String, String>> _tilawahList = [
    {'surah': 'Al-Fatihah', 'halaman': '1'},
    {'surah': 'Al-Baqarah', 'halaman': '12'},
    {'surah': 'Al-Kahfi', 'halaman': '7'},
    {'surah': 'Al-Ikhlas', 'halaman': '1'},
  ];

  Future<void> _showCatatModal() async {
    final result = await showModalBottomSheet<Map<String, String>>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const _CatatTilawahModal(),
    );
    if (result != null) {
      setState(() {
        _tilawahList.add({
          'surah': result['surah']!,
          'halaman': result['halaman']!,
        });
      });
    }
  }

  void _showSholatModal(String name, VoidCallback onConfirm) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Iconsax.tick_circle,
                size: 45,
                color: HexColor.fromHex("#D39D52"),
              ),
              const SizedBox(height: 10),
              Text(
                "Shalat $name",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Apakah kamu sudah melaksanakan shalat $name?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: HexColor.fromHex("#5a7b8a"),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 42,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onConfirm();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor.fromHex("#D39D52"),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("Sudah"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSholatItem(String name, bool done) {
    return GestureDetector(
      onTap: () {
        _showSholatModal(name, () {
          setState(() {
            final index = _sholatWajib.indexWhere((e) => e['name'] == name);
            if (index != -1) _sholatWajib[index]['done'] = true;
          });
        });
      },
      child: Column(
        children: [
          Icon(
            done ? Icons.check_circle_rounded : Iconsax.tick_circle,
            size: 45,
            color: done
                ? HexColor.fromHex("#D39D52")
                : HexColor.fromHex("#C9CFD4"),
          ),
          const SizedBox(height: 4),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: HexColor.fromHex("#5a7b8a"),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#F9F5EF"),
      appBar: AppBar(
        toolbarHeight: 0,
        surfaceTintColor: HexColor.fromHex("#F9F5EF"),
        backgroundColor: HexColor.fromHex("#F9F5EF"),
        foregroundColor: HexColor.fromHex("#F9F5EF"),
        actionsPadding: EdgeInsets.symmetric(horizontal: 12),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Progress Harian",
                          style: TextStyle(
                            color: HexColor.fromHex("#256980"),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Iconsax.calendar_1,
                              color: HexColor.fromHex("#256980"),
                              size: 30,
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Iconsax.chart_21,
                              color: HexColor.fromHex("#256980"),
                              size: 30,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Selesaikan checklist ibadah hari ini.",
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "8 dari 24 Selesai",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: HexColor.fromHex("#256980"),
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 6),
                    StepProgressIndicator(
                      totalSteps: 38,
                      currentStep: 10,
                      selectedColor: HexColor.fromHex("#256980"),
                      size: 28,
                      padding: 3,
                      unselectedColor: Colors.grey,
                      roundedEdges: const Radius.circular(5),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: HexColor.fromHex("#256980"),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          "Barangsiapa yang mengerjakan amal yang saleh maka (pahalanya) untuk dirinya sendiri. (Q.S. Fussilat: 46)",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sholat Wajib",
                      style: TextStyle(
                        color: HexColor.fromHex("#256980"),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (final sholat in _sholatWajib)
                          _buildSholatItem(sholat['name'], sholat['done']),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.menu_book_rounded,
                              color: HexColor.fromHex("#256980"),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Tilawah Hari Ini",
                              style: TextStyle(
                                color: HexColor.fromHex("#256980"),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        ElevatedButton(
                          onPressed: _showCatatModal,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: HexColor.fromHex("#256980"),
                            foregroundColor: Colors.white,
                            // minimumSize: const Size(0, 38),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 13,
                              vertical: 6,
                            ),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Row(
                            children: [
                              Text(
                                "Catat",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(Iconsax.add_circle5),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),
                    for (var i = 0; i < _tilawahList.length; i++) ...[
                      if (i > 0) const SizedBox(height: 16),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _tilawahList[i]['surah']!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: HexColor.fromHex("#D39D52"),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "${_tilawahList[i]['halaman']} Halaman",
                                    style: TextStyle(
                                      color: HexColor.fromHex("#256980"),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _tilawahList.removeAt(i);
                                  });
                                },
                                child: Icon(
                                  Iconsax.close_circle,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CatatTilawahModal extends StatefulWidget {
  const _CatatTilawahModal();

  @override
  State<_CatatTilawahModal> createState() => _CatatTilawahModalState();
}

class _CatatTilawahModalState extends State<_CatatTilawahModal> {
  final _surahController = TextEditingController();
  final _halamanController = TextEditingController();

  @override
  void dispose() {
    _surahController.dispose();
    _halamanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Catat Tilawah",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _surahController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: "Surah & Ayat",
              hintStyle: TextStyle(color: HexColor.fromHex("#5a7b8a")),
              filled: true,
              fillColor: HexColor.fromHex("#F9F5EF"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _halamanController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Jumlah Halaman",
              hintStyle: TextStyle(color: HexColor.fromHex("#5a7b8a")),
              filled: true,
              fillColor: HexColor.fromHex("#F9F5EF"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: HexColor.fromHex("#256980"),
                    side: BorderSide(color: HexColor.fromHex("#256980")),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("Batal"),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_surahController.text.trim().isEmpty ||
                        _halamanController.text.trim().isEmpty) {
                      return;
                    }
                    Navigator.pop(context, {
                      'surah': _surahController.text.trim(),
                      'halaman': _halamanController.text.trim(),
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor.fromHex("#256980"),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("Simpan"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
