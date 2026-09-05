import 'package:alquran_new/core/constants/app_colors.dart';
import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

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
    final list = map.entries.where((e) => e.value.any((c) => c > 0)).toList()
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: HexColor.fromHex("#F9F5EF"),
        title: Text(
          "Konfirmasi",
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(message, style: TextStyle(color: AppColors.primary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(
              "Batal",
              style: TextStyle(fontSize: 14, color: AppColors.secondary),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(
              "Hapus",
              style: TextStyle(fontSize: 14, color: Colors.red),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: isDark
            ? Theme.of(context).cardColor
            : AppColors.primary,
        surfaceTintColor: isDark
            ? Theme.of(context).cardColor
            : AppColors.primary,
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
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        actions: [
          if (entries.isNotEmpty)
            TextButton(
              onPressed: _confirmDeleteAll,
              child: Text(
                "Hapus Semua",
                style: TextStyle(fontSize: 14, color: AppColors.secondary),
              ),
            ),
        ],
      ),
      body: entries.isEmpty
          ? _emptyState()
          : Container(
              decoration: BoxDecoration(
                color: isDark ? Theme.of(context).cardColor : AppColors.primary,
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                    AppColors.primary.withAlpha(210),
                    BlendMode.srcATop,
                  ),
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/image.png"),
                ),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                itemCount: entries.length,
                itemBuilder: (context, index) => _historyCard(entries[index]),
              ),
            ),
    );
  }

  Widget _emptyState() {
        final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
          color: isDark ? Theme.of(context).cardColor : AppColors.primary,
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            AppColors.primary.withAlpha(210),
            BlendMode.srcATop,
          ),
          fit: BoxFit.cover,
          image: AssetImage("assets/images/image.png"),
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Stack(
            children: [
              Positioned(
                top: -100,
                right: 0,
                left: 0,
                bottom: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/animations/empty.json',
                      width: 180,
                      height: 180,
                    ),

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
                      style: TextStyle(
                        color: Colors.white.withAlpha(180),
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _historyCard(MapEntry<String, List<int>> entry) {
    final total = entry.value.fold(0, (a, b) => a + b);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Theme.of(context).cardColor : AppColors.primary,
        borderRadius: BorderRadius.circular(16),
        border: BoxBorder.all(width: 0.3, color: AppColors.textPrimaryDark),
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
                    color: AppColors.secondary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _formatDate(entry.key),
                    style: TextStyle(
                      color: AppColors.textPrimaryDark,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => _confirmDeleteEntry(entry.key),
                child: Icon(
                  Iconsax.close_circle,
                  color: HexColor.fromHex("#D35252"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(
            color: isDark
                ? Colors.white24
                : AppColors.textPrimaryDark.withAlpha(100),
            height: 1,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: TextStyle(
                  color: AppColors.textPrimaryDark,
                  fontSize: 13,
                ),
              ),
              Row(
                children: [
                  Text.rich(
                    TextSpan(
                      text: "$total",
                      style: TextStyle(color: AppColors.secondary),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text.rich(
                    TextSpan(
                      text: "kali",
                      style: TextStyle(color: AppColors.textPrimaryDark),
                    ),
                  ),
                ],
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
                              ? AppColors.secondary
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
                    Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            text: "${entry.value[i]}",
                            style: TextStyle(color: AppColors.secondary),
                          ),
                        ),
                        SizedBox(width: 5),
                        Text.rich(
                          TextSpan(
                            text: "kali",
                            style: TextStyle(color: AppColors.textPrimaryDark),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}
