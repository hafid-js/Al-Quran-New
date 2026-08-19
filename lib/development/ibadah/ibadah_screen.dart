import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/development/ibadah/calendar_picker_modal.dart';
import 'package:alquran_new/development/ibadah/statistik_ibadah.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'dart:math';

class IbadahScreen extends StatefulWidget {
  const IbadahScreen({super.key});

  @override
  State<IbadahScreen> createState() => _IbadahScreenState();
}

class _IbadahScreenState extends State<IbadahScreen> {
  final GetStorage _storage = GetStorage();

  int _quoteIndex = 0;

  final List<String> _quotes = [
    "Barangsiapa yang mengerjakan amal yang saleh maka (pahalanya) untuk dirinya sendiri. (Q.S. Fussilat: 46)",
    "Setiap amalan anak adam untuknya, kecuali puasa. Maka sesungguhnya, ia (puasa) untuk-Ku yang akan membalasnya. (HR. Bukhari & Muslim)",
  ];

  late DateTime _selectedDate;

  List<Map<String, dynamic>> _sholatWajib = [
    {'name': 'Subuh', 'done': false},
    {'name': 'Dzuhur', 'done': false},
    {'name': 'Ashar', 'done': false},
    {'name': 'Maghrib', 'done': false},
    {'name': 'Isya', 'done': false},
  ];

  List<Map<String, dynamic>> _sholatSunnah = [
    {'name': 'Dhuha', 'done': false},
    {'name': 'Tahajud', 'done': false},
    {'name': 'Rawatib', 'done': false},
    {'name': 'Witir', 'done': false},
  ];

  List<Map<String, dynamic>> _dzikirList = [
    {'name': 'Dzikir Pagi', 'done': false, 'icon': Iconsax.sun_1},
    {'name': 'Dzikir Petang', 'done': false, 'icon': Iconsax.moon},
  ];

  List<Map<String, dynamic>> _puasaList = [
    {
      'name': 'Senin-Kamis',
      'done': false,
      'icon': Iconsax.calendar_tick,
      'question': "Apakah kamu sudah berpuasa Senin-Kamis hari ini?",
    },
    {
      'name': 'Ayyamul-Bidh',
      'done': false,
      'icon': Iconsax.moon,
      'question': "Apakah kamu sudah berpuasa Ayyamul-Bidh hari ini?",
    },
    {
      'name': 'Daud',
      'done': false,
      'icon': Iconsax.medal,
      'question': "Apakah kamu sudah berpuasa Daud hari ini?",
    },
  ];

  List<Map<String, String>> _tilawahList = [];

  List<int> _sedekahList = [];

  int get _totalSedekah => _sedekahList.fold(0, (a, b) => a + b);

  int get _totalChecklistDone =>
      _sholatWajib.where((e) => e['done'] == true).length +
      _sholatSunnah.where((e) => e['done'] == true).length +
      _dzikirList.where((e) => e['done'] == true).length +
      _puasaList.where((e) => e['done'] == true).length;

  int get _totalChecklist =>
      _sholatWajib.length +
      _sholatSunnah.length +
      _dzikirList.length +
      _puasaList.length;

  int get _tilawahPagesDone =>
      _tilawahList.fold(
        0,
        (a, t) => a + (int.tryParse(t['halaman'] ?? '') ?? 0),
      );

  int get _totalDone =>
      _totalChecklistDone + _tilawahPagesDone + _sedekahList.length;

  int get _totalAll =>
      _totalChecklist + _tilawahPagesDone + _sedekahList.length;

  @override
  void initState() {
    super.initState();

    _selectedDate = DateTime.now();

    _repairStoredData();
    _cleanupOldMonths();

    _loadData();

    _quoteIndex = Random().nextInt(_quotes.length);
  }

  void _cleanupOldMonths() {
    final now = DateTime.now();
    final currentMonth = '${now.year}-${now.month.toString().padLeft(2, '0')}';

    for (final key in _storage.getKeys()) {
      final keyStr = key.toString();
      if (!keyStr.startsWith('ibadah_')) continue;

      final datePart = keyStr.replaceFirst('ibadah_', '');
      final parts = datePart.split('-');
      if (parts.length == 3) {
        final keyMonth = '${parts[0]}-${parts[1]}';
        if (keyMonth != currentMonth) {
          _storage.remove(keyStr);
        }
      }
    }
  }

  void _repairStoredData() {
    for (final key in _storage.getKeys()) {
      if (!key.toString().startsWith('ibadah_')) continue;

      final data = _storage.read(key.toString());

      if (data is! Map) continue;

      var changed = false;

      final wajib = data['sholatWajib'];

      if (wajib is List && wajib.isEmpty) {
        data['sholatWajib'] = [
          {'name': 'Subuh', 'done': false},
          {'name': 'Dzuhur', 'done': false},
          {'name': 'Ashar', 'done': false},
          {'name': 'Maghrib', 'done': false},
          {'name': 'Isya', 'done': false},
        ];

        changed = true;
      }

      final sunnah = data['sholatSunnah'];

      if (sunnah is List && sunnah.isEmpty) {
        data['sholatSunnah'] = [
          {'name': 'Dhuha', 'done': false},
          {'name': 'Tahajud', 'done': false},
          {'name': 'Rawatib', 'done': false},
          {'name': 'Witir', 'done': false},
        ];

        changed = true;
      }

      if (changed) {
        _storage.write(key.toString(), data);
      }
    }
  }

  String get _dateKey =>
      '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}';

  String get _storageKey => 'ibadah_$_dateKey';

  String get _formattedDate {
    const bulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    const hari = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];

    return '${hari[_selectedDate.weekday - 1]}, '
        '${_selectedDate.day} ${bulan[_selectedDate.month - 1]} '
        '${_selectedDate.year}';
  }

  void _saveData() {
    _storage.write(_storageKey, {
      'sholatWajib': _sholatWajib.isEmpty
          ? const [
              {'name': 'Subuh', 'done': false},
              {'name': 'Dzuhur', 'done': false},
              {'name': 'Ashar', 'done': false},
              {'name': 'Maghrib', 'done': false},
              {'name': 'Isya', 'done': false},
            ]
          : [for (final s in _sholatWajib) Map<String, dynamic>.from(s)],

      'sholatSunnah': _sholatSunnah.isEmpty
          ? const [
              {'name': 'Dhuha', 'done': false},
              {'name': 'Tahajud', 'done': false},
              {'name': 'Rawatib', 'done': false},
              {'name': 'Witir', 'done': false},
            ]
          : [for (final s in _sholatSunnah) Map<String, dynamic>.from(s)],

      'dzikir': [
        for (final d in _dzikirList) {'name': d['name'], 'done': d['done']},
      ],

      'puasa': [
        for (final p in _puasaList) {'name': p['name'], 'done': p['done']},
      ],

      'tilawah': [for (final t in _tilawahList) Map<String, String>.from(t)],

      'sedekah': List<int>.of(_sedekahList),
    });
  }

  void _loadData({bool notify = false}) {
    final data = _storage.read(_storageKey);

    final wajib = data is Map ? data['sholatWajib'] as List? : null;

    final sunnah = data is Map ? data['sholatSunnah'] as List? : null;

    final dzikir = data is Map ? (data['dzikir'] as List?) ?? [] : [];

    final puasa = data is Map ? (data['puasa'] as List?) ?? [] : [];

    final tilawah = data is Map ? data['tilawah'] as List? ?? [] : [];

    final sedekah = data is Map ? (data['sedekah'] as List?) ?? [] : [];

    void load() {
      _sholatWajib = (wajib != null && wajib.isNotEmpty)
          ? [for (final e in wajib) Map<String, dynamic>.from(e as Map)]
          : [
              {'name': 'Subuh', 'done': false},
              {'name': 'Dzuhur', 'done': false},
              {'name': 'Ashar', 'done': false},
              {'name': 'Maghrib', 'done': false},
              {'name': 'Isya', 'done': false},
            ];

      _sholatSunnah = (sunnah != null && sunnah.isNotEmpty)
          ? [for (final e in sunnah) Map<String, dynamic>.from(e as Map)]
          : [
              {'name': 'Dhuha', 'done': false},
              {'name': 'Tahajud', 'done': false},
              {'name': 'Rawatib', 'done': false},
              {'name': 'Witir', 'done': false},
            ];

      _dzikirList = [
        {'name': 'Dzikir Pagi', 'done': false, 'icon': Iconsax.sun_1},
        {'name': 'Dzikir Petang', 'done': false, 'icon': Iconsax.moon},
      ];

      for (var i = 0; i < _dzikirList.length && i < dzikir.length; i++) {
        final done = (dzikir[i] as Map)['done'];

        if (done is bool) {
          _dzikirList[i]['done'] = done;
        }
      }

      _puasaList = [
        {
          'name': 'Senin-Kamis',
          'done': false,
          'icon': Iconsax.calendar_tick,
          'question': "Apakah kamu sudah berpuasa Senin-Kamis hari ini?",
        },
        {
          'name': 'Ayyamul-Bidh',
          'done': false,
          'icon': Iconsax.moon,
          'question': "Apakah kamu sudah berpuasa Ayyamul-Bidh hari ini?",
        },
        {
          'name': 'Daud',
          'done': false,
          'icon': Iconsax.medal,
          'question': "Apakah kamu sudah berpuasa Daud hari ini?",
        },
      ];

      for (var i = 0; i < _puasaList.length && i < puasa.length; i++) {
        final done = (puasa[i] as Map)['done'];

        if (done is bool) {
          _puasaList[i]['done'] = done;
        }
      }

      _tilawahList = [
        for (final t in tilawah)
          if (t is Map)
            {
              'surah': t['surah']?.toString() ?? '',
              'halaman': t['halaman']?.toString() ?? '',
            },
      ];

      _sedekahList = sedekah.whereType<int>().toList();
    }

    if (notify) {
      setState(() {
        load();
      });
    } else {
      load();
    }
  }

  Future<void> _showCalendarModal() async {
    final picked = await showDialog<DateTime>(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: CalendarPickerModal(initialDate: _selectedDate),
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });

      _loadData(notify: true);
    }
  }

  String formatRupiah(int nominal) {
    final s = nominal.toString();

    final buffer = StringBuffer();

    for (var i = 0; i < s.length; i++) {
      buffer.write(s[i]);

      final remaining = s.length - i - 1;

      if (remaining > 0 && remaining % 3 == 0) {
        buffer.write('.');
      }
    }

    return 'Rp $buffer';
  }

  Future<void> _showSedekahModal() async {
    final result = await showModalBottomSheet<int>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const _CatatSedekahModal(),
    );

    if (result != null) {
      setState(() {
        _sedekahList.add(result);
      });

      _saveData();
    }
  }

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

      _saveData();
    }
  }

  void _showSholatModal(
    String name,
    VoidCallback? onConfirm, {
    VoidCallback? onUndo,
    void Function(String mode)? onConfirmMode,
    String? currentMode,
    String? title,
    String? question,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
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
                title ?? "Shalat $name",
                style: TextStyle(
                  fontSize: 18,
                  color: HexColor.fromHex("#5a7b8a"),
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                question ?? "Apakah kamu sudah melaksanakan shalat $name?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: HexColor.fromHex("#5a7b8a"),
                ),
              ),

              const SizedBox(height: 20),

              if (onConfirmMode != null) ...[
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 42,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            onConfirmMode('berjamaah');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: currentMode == 'berjamaah'
                                ? HexColor.fromHex("#D39D52")
                                : Colors.white,
                            foregroundColor: currentMode == 'berjamaah'
                                ? Colors.white
                                : HexColor.fromHex("#256980"),
                            elevation: 0,
                            side: currentMode == 'berjamaah'
                                ? null
                                : BorderSide(
                                    color: HexColor.fromHex("#256980"),
                                  ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text("Berjamaah"),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: SizedBox(
                        height: 42,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            onConfirmMode('sendiri');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: currentMode == 'sendiri'
                                ? HexColor.fromHex("#D39D52")
                                : Colors.white,
                            foregroundColor: currentMode == 'sendiri'
                                ? Colors.white
                                : HexColor.fromHex("#256980"),
                            elevation: 0,
                            side: currentMode == 'sendiri'
                                ? null
                                : BorderSide(
                                    color: HexColor.fromHex("#256980"),
                                  ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text("Sendiri"),
                        ),
                      ),
                    ),
                  ],
                ),

                if (onUndo != null) ...[
                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onUndo();
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: HexColor.fromHex("#256980"),
                        side: BorderSide(color: HexColor.fromHex("#256980")),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text("Batalkan"),
                    ),
                  ),
                ],
              ] else ...[
                Row(
                  children: [
                    if (onUndo != null) ...[
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            onUndo();
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: HexColor.fromHex("#256980"),
                            side: BorderSide(
                              color: HexColor.fromHex("#256980"),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text("Batalkan"),
                        ),
                      ),

                      const SizedBox(width: 12),
                    ],

                    Expanded(
                      child: SizedBox(
                        height: 42,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            onConfirm?.call();
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
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildSunnahItem(String name, bool done) {
    final color = HexColor.fromHex("#256980");

    return GestureDetector(
      onTap: () {
        _showSholatModal(
          name,
          () {
            setState(() {
              final index = _sholatSunnah.indexWhere((e) => e['name'] == name);

              if (index != -1) {
                _sholatSunnah[index]['done'] = true;
              }
            });

            _saveData();
          },
          onUndo: done
              ? () {
                  setState(() {
                    final index = _sholatSunnah.indexWhere(
                      (e) => e['name'] == name,
                    );

                    if (index != -1) {
                      _sholatSunnah[index]['done'] = false;
                    }
                  });

                  _saveData();
                }
              : null,
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: done ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color, width: 1.5),
        ),
        child: Column(
          children: [
            Icon(Iconsax.sun_1, size: 24, color: done ? Colors.white : color),

            SizedBox(height: 6),

            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: done ? Colors.white : color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDzikirItem(
    List<Map<String, dynamic>> list,
    String name,
    bool done,
    IconData icon,
  ) {
    final color = HexColor.fromHex("#256980");

    final index = list.indexWhere((e) => e['name'] == name);

    final question = index != -1
        ? (list[index]['question'] as String? ??
              "Apakah kamu sudah mengerjakan $name?")
        : "Apakah kamu sudah mengerjakan $name?";

    return GestureDetector(
      onTap: () {
        _showSholatModal(
          name,
          () {
            setState(() {
              if (index != -1) {
                list[index]['done'] = true;
              }
            });

            _saveData();
          },
          onUndo: done
              ? () {
                  setState(() {
                    if (index != -1) {
                      list[index]['done'] = false;
                    }
                  });

                  _saveData();
                }
              : null,
          title: name,
          question: question,
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: done ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color, width: 1.5),
        ),
        child: Column(
          children: [
            Icon(icon, size: 24, color: done ? Colors.white : color),

            SizedBox(height: 6),

            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: done ? Colors.white : color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSholatItem(String name, bool done, String? mode) {
    return GestureDetector(
      onTap: () {
        _showSholatModal(
          name,
          null,
          onUndo: done
              ? () {
                  setState(() {
                    final index = _sholatWajib.indexWhere(
                      (e) => e['name'] == name,
                    );

                    if (index != -1) {
                      _sholatWajib[index]['done'] = false;
                      _sholatWajib[index]['mode'] = null;
                    }
                  });

                  _saveData();
                }
              : null,
          currentMode: mode,
          onConfirmMode: (mode) {
            setState(() {
              final index = _sholatWajib.indexWhere((e) => e['name'] == name);

              if (index != -1) {
                _sholatWajib[index]['done'] = true;
                _sholatWajib[index]['mode'] = mode;
              }
            });

            _saveData();
          },
        );
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

          if (done && mode != null) ...[
            const SizedBox(height: 2),

            Text(
              mode == 'berjamaah' ? 'Berjamaah' : 'Sendiri',
              style: TextStyle(
                fontSize: 10,
                color: HexColor.fromHex("#D39D52"),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#F9F5EF"),

      appBar: AppBar(
           leading: GestureDetector(
          onTap: () => Get.back(),
          
          child: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: Text(
          "Ibadah",
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: Colors.black),
        ),
        // toolbarHeight: 0,
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
                            GestureDetector(
                              onTap: _showCalendarModal,
                              child: Icon(
                                Iconsax.calendar_1,
                                color: HexColor.fromHex("#256980"),
                                size: 30,
                              ),
                            ),

                            SizedBox(width: 10),

                            GestureDetector(
                              onTap: () => Get.to(() => StatistikIbadah()),
                              child: Icon(
                                Iconsax.chart_21,
                                color: HexColor.fromHex("#256980"),
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    Text(
                      _formattedDate,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: HexColor.fromHex("#256980"),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      "Selesaikan checklist ibadah hari ini.",
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    SizedBox(height: 6),

                    Text(
                      "$_totalDone dari $_totalAll Selesai",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: HexColor.fromHex("#256980"),
                        fontSize: 12,
                      ),
                    ),

                    SizedBox(height: 6),

                    StepProgressIndicator(
                      totalSteps: _totalAll * 2 + 10,
                      currentStep: _totalDone > 0 ? _totalDone * 2 + 10 : 0 ,
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
                          _quotes[_quoteIndex],
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
                          _buildSholatItem(
                            sholat['name'],
                            sholat['done'],
                            sholat['mode'],
                          ),
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
                    Text(
                      "Sholat Sunnah",
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
                        for (final sunnah in _sholatSunnah)
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: _buildSunnahItem(
                                sunnah['name'],
                                sunnah['done'],
                              ),
                            ),
                          ),
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
                    Text(
                      "Ibadah Lainnya",
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
                        for (final dzikir in _dzikirList)
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: _buildDzikirItem(
                                _dzikirList,
                                dzikir['name'],
                                dzikir['done'],
                                dzikir['icon'],
                              ),
                            ),
                          ),
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
                    Text(
                      "Puasa Sunnah",
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
                        for (final puasa in _puasaList)
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: _buildDzikirItem(
                                _puasaList,
                                puasa['name'],
                                puasa['done'],
                                puasa['icon'],
                              ),
                            ),
                          ),
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

                                  _saveData();
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
                              Iconsax.card_coin,
                              color: HexColor.fromHex("#256980"),
                              size: 20,
                            ),

                            SizedBox(width: 8),

                            Text(
                              "Sedekah Hari Ini",
                              style: TextStyle(
                                color: HexColor.fromHex("#256980"),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        ElevatedButton(
                          onPressed: _showSedekahModal,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: HexColor.fromHex("#256980"),
                            foregroundColor: Colors.white,
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

                    if (_sedekahList.isEmpty)
                      Text(
                        "Belum ada catatan sedekah hari ini.",
                        style: TextStyle(
                          fontSize: 13,
                          color: HexColor.fromHex("#5a7b8a"),
                        ),
                      )
                    else
                      for (var i = 0; i < _sedekahList.length; i++) ...[
                        if (i > 0) const SizedBox(height: 12),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatRupiah(_sedekahList[i]),
                              style: TextStyle(
                                fontSize: 14,
                                color: HexColor.fromHex("#D39D52"),
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _sedekahList.removeAt(i);
                                });

                                _saveData();
                              },
                              child: Icon(
                                Iconsax.close_circle,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],

                    SizedBox(height: 16),

                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: HexColor.fromHex("#256980"),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Sedekah Hari Ini",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          Text(
                            formatRupiah(_totalSedekah),
                            style: TextStyle(
                              fontSize: 16,
                              color: HexColor.fromHex("#D39D52"),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
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
            style: TextStyle(color: HexColor.fromHex("#256980")),
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
            style: TextStyle(color: HexColor.fromHex("#256980")),
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

class _CatatSedekahModal extends StatefulWidget {
  const _CatatSedekahModal();

  @override
  State<_CatatSedekahModal> createState() => _CatatSedekahModalState();
}

class _CatatSedekahModalState extends State<_CatatSedekahModal> {
  final _nominalController = TextEditingController();

  @override
  void dispose() {
    _nominalController.dispose();
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
              "Catat Sedekah",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: _nominalController,
            keyboardType: TextInputType.number,
            style: TextStyle(color: HexColor.fromHex("#256980")),
            inputFormatters: [_RupiahInputFormatter()],
            decoration: InputDecoration(
              hintText: "Nominal (Rp)",
              hintStyle: TextStyle(color: HexColor.fromHex("#5a7b8a")),
              prefixText: "Rp ",
              prefixStyle: TextStyle(
                color: HexColor.fromHex("#256980"),
                fontWeight: FontWeight.w600,
              ),
              filled: true,
              fillColor: HexColor.fromHex("#F9F5EF"),
              prefixIcon: Icon(
                Iconsax.card_coin,
                color: HexColor.fromHex("#256980"),
                size: 20,
              ),
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
                    final nominal = int.tryParse(
                      _nominalController.text.replaceAll('.', ''),
                    );

                    if (nominal == null || nominal <= 0) {
                      return;
                    }

                    Navigator.pop(context, nominal);
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

class _RupiahInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (digits.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    final buffer = StringBuffer();

    for (var i = 0; i < digits.length; i++) {
      buffer.write(digits[i]);

      final remaining = digits.length - i - 1;

      if (remaining > 0 && remaining % 3 == 0) {
        buffer.write('.');
      }
    }

    final formatted = buffer.toString();

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
