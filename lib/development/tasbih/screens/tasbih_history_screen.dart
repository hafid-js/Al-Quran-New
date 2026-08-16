import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TasbihHistoryScreen extends StatefulWidget {
  const TasbihHistoryScreen({super.key});

  @override
  State<TasbihHistoryScreen> createState() => _TasbihHistoryScreenState();
}

class _TasbihHistoryScreenState extends State<TasbihHistoryScreen> {
  final box = GetStorage();
  final int target = 33;
  List<MapEntry<String, List<int>>> entries = [];

  static const List<String> dzikirNames = [
    "Subhanallah",
    "Alhamdulillah",
    "Allahu Akbar",
    "La ilaha illallah",
    "Astaghfirullahal adzim",
    "Allahuma sholli ala Muhammad",
  ];

  static const List<String> _months = [
    "Januari",
    "Februari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember",
  ];

  static const List<String> _days = [
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
    "Jumat",
    "Sabtu",
    "Minggu",
  ];

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    final raw = box.read('tasbihHarian');
    final map = <String, List<int>>{};
    if (raw is Map) {
      raw.forEach((k, v) {
        if (v is List) {
          final counts = v.map((e) => (e as num).toInt()).toList();
          while (counts.length < 6) {
            counts.add(0);
          }
          map[k.toString()] = counts;
        }
      });
    }
    final list = map.entries
        .where((e) => e.value.any((c) => c > 0))
        .toList()
      ..sort((a, b) => b.key.compareTo(a.key));
    entries = list;
  }

  String _formatDate(String key) {
    final parts = key.split('-');
    if (parts.length != 3) return key;
    final d = DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
    return '${_days[d.weekday - 1]}, ${d.day} ${_months[d.month - 1]} ${d.year}';
  }

  void _deleteEntry(String date) {
    final dailyMap = Map<String, dynamic>.from(box.read('tasbihHarian') ?? {});
    dailyMap.remove(date);
    box.write('tasbihHarian', dailyMap);
    setState(_load);
  }

  void _deleteAll() {
    box.write('tasbihHarian', <String, dynamic>{});
    setState(_load);
  }

  Future<bool> _confirm(String message) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: HexColor.fromHex("#256980"),
        title: const Text(
          "Konfirmasi",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        content: Text(
          message,
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text(
              "Batal",
              style: TextStyle(color: Colors.white70),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(
              "Hapus",
              style: TextStyle(color: HexColor.fromHex("#D39D52")),
            ),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  Future<void> _confirmDeleteEntry(String date) async {
    if (await _confirm("Hapus riwayat tasbih tanggal ini?")) {
      _deleteEntry(date);
    }
  }

  Future<void> _confirmDeleteAll() async {
    if (await _confirm("Hapus semua riwayat tasbih?")) {
      _deleteAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#256980").withAlpha(200),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 70,
        leadingWidth: 65,
        centerTitle: false,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        titleSpacing: 0,
        title: const Text(
          "Riwayat Tasbih",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          if (entries.isNotEmpty)
            TextButton(
              onPressed: _confirmDeleteAll,
              child: Text(
                "Hapus Semua",
                style: TextStyle(color: HexColor.fromHex("#D39D52")),
              ),
            ),
        ],
      ),
      body: entries.isEmpty
          ? _emptyState()
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              itemCount: entries.length,
              itemBuilder: (context, index) =>
                  _historyCard(entries[index]),
            ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.history,
            size: 70,
            color: Colors.white38,
          ),
          const SizedBox(height: 16),
          const Text(
            "Belum ada riwayat",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Simpan tasbih harian Anda untuk melihat riwayat.",
            style: TextStyle(color: Colors.white.withAlpha(180), fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _historyCard(MapEntry<String, List<int>> entry) {
    final total = entry.value.fold(0, (a, b) => a + b);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HexColor.fromHex("#256980"),
        borderRadius: BorderRadius.circular(16),
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
                    Icons.calendar_today_outlined,
                    size: 16,
                    color: HexColor.fromHex("#D39D52"),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _formatDate(entry.key),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => _confirmDeleteEntry(entry.key),
                child: const Icon(
                  Icons.delete_outline,
                  size: 18,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: Colors.white24, height: 1),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
              Text(
                "$total kali",
                style: TextStyle(
                  color: HexColor.fromHex("#D39D52"),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          for (int i = 0; i < dzikirNames.length; i++)
            if (entry.value[i] > 0)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          entry.value[i] >= target
                              ? Icons.check_circle_rounded
                              : Icons.circle_outlined,
                          size: 14,
                          color: entry.value[i] >= target
                              ? HexColor.fromHex("#D39D52")
                              : Colors.white38,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          dzikirNames[i],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${entry.value[i]}x",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}
