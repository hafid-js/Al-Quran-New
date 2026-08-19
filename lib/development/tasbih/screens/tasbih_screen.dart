import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/core/services/ukuran_controller.dart';
import 'package:alquran_new/development/tasbih/screens/tasbih_chart_screen.dart';
import 'package:alquran_new/development/tasbih/screens/tasbih_history_screen.dart';
import 'package:alquran_new/development/pengaturan/controllers/settings_controller.dart';
import 'package:alquran_new/development/tasbih/widgets/tasbih_bead_counter.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vibration/vibration.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({super.key});

  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> {
  final SettingsController setting = Get.find<SettingsController>();
  final UkuranController _ukuran = Get.find<UkuranController>();
  final box = GetStorage();
  final int target = 33;
  int freeTasbih = 0;
  int endTasbih = 0;
  int subhanallah = 0;
  int alhamdulillah = 0;
  int allahuakbar = 0;
  int laillahailallah = 0;
  int astaghfirullah = 0;
  int allahumasholialamuhammad = 0;
  int selectedDzikir = 0;
  late List<int> todayCounts;

  final List<String> dzikirNames = [
    "Subhanallah",
    "Alhamdulillah",
    "Allahuakbar",
    "La ilaha illallah",
    "Astaghfirullahal adzim",
    "Allahuma sholli ala Muhammad",
  ];

  final List<String> dzikirArabics = [
    "سُبْحَانَ اللَّهِ",
    "الْحَمْدُ لِلَّهِ",
    "اللَّهُ أَكْبَرُ",
    "لَا إِلٰهَ إِلَّا اللَّهُ",
    "أَسْتَغْفِرُ اللَّهَ",
    "اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ",
  ];

  final List<String> dzikirArtis = [
    "Maha Suci Allah",
    "Segala puji bagi Allah",
    "Allah Maha Besar",
    "Tiada Tuhan selain Allah",
    "Aku memohon ampun kepada Allah",
    "Ya Allah, limpahkan sholawat kepada Nabi Muhammad",
  ];

  int dzikirCount(int index) {
    switch (index) {
      case 0:
        return subhanallah;
      case 1:
        return alhamdulillah;
      case 2:
        return allahuakbar;
      case 3:
        return laillahailallah;
      case 4:
        return astaghfirullah;
      default:
        return allahumasholialamuhammad;
    }
  }

  VoidCallback dzikirCounter(int index) {
    switch (index) {
      case 0:
        return subhanallahCounter;
      case 1:
        return alhamdulillahCounter;
      case 2:
        return allahuakbarCounter;
      case 3:
        return laillahailallahCounter;
      case 4:
        return astaghfirullahCounter;
      default:
        return allahumaCounter;
    }
  }

  int dzikirSelesai() {
    int total = 0;

    if (subhanallah >= target) total++;
    if (alhamdulillah >= target) total++;
    if (allahuakbar >= target) total++;
    if (laillahailallah >= target) total++;
    if (astaghfirullah >= target) total++;
    if (allahumasholialamuhammad >= target) total++;

    return total;
  }

  int totalSemuaDzikir() {
    return subhanallah +
        alhamdulillah +
        allahuakbar +
        laillahailallah +
        astaghfirullah +
        allahumasholialamuhammad;
  }

  @override
  void initState() {
    super.initState();
    _cleanupOldMonths();
    _loadTodayData();
  }

  void _cleanupOldMonths() {
    final now = DateTime.now();
    final currentMonth = '${now.year}-${now.month.toString().padLeft(2, '0')}';

    final raw = box.read('tasbihHarian');
    if (raw is Map) {
      final dailyMap = Map<String, dynamic>.from(raw);
      final keysToRemove = <String>[];
      for (final key in dailyMap.keys) {
        final parts = key.split('-');
        if (parts.length == 3) {
          final keyMonth = '${parts[0]}-${parts[1]}';
          if (keyMonth != currentMonth) {
            keysToRemove.add(key);
          }
        }
      }
      for (final key in keysToRemove) {
        dailyMap.remove(key);
        box.remove('tasbihFree_$key');
        box.remove('tasbihEnd_$key');
      }
      if (keysToRemove.isNotEmpty) {
        box.write('tasbihHarian', dailyMap);
      }
    }
  }

  void _loadTodayData() {
    todayCounts = List.filled(6, 0);
    final raw = box.read('tasbihHarian');
    if (raw is Map) {
      final entry = raw[_fmtDate(DateTime.now())];
      if (entry is List) {
        todayCounts = entry.map((e) => (e as num).toInt()).toList();
        while (todayCounts.length < 6) {
          todayCounts.add(0);
        }
      }
    }
    subhanallah = todayCounts[0];
    alhamdulillah = todayCounts[1];
    allahuakbar = todayCounts[2];
    laillahailallah = todayCounts[3];
    astaghfirullah = todayCounts[4];
    allahumasholialamuhammad = todayCounts[5];

    final freeRaw = box.read('tasbihFree_${_fmtDate(DateTime.now())}');
    freeTasbih = (freeRaw is num) ? freeRaw.toInt() : 0;
    final endRaw = box.read('tasbihEnd_${_fmtDate(DateTime.now())}');
    endTasbih = (endRaw is num) ? endRaw.toInt() : 0;
  }

  Future<void> _vibrate() async {
    if (_ukuran.getar.value && (await Vibration.hasVibrator() == true)) {
      Vibration.vibrate(duration: 100);
    }
  }

  void subhanallahCounter() {
    if (subhanallah < target) {
      setState(() {
        subhanallah++;
        todayCounts[0]++;
      });
    }
  }

  void alhamdulillahCounter() {
    if (alhamdulillah < target) {
      setState(() {
        alhamdulillah++;
        todayCounts[1]++;
      });
    }
  }

  void allahuakbarCounter() {
    if (allahuakbar < target) {
      setState(() {
        allahuakbar++;
        todayCounts[2]++;
      });
    }
  }

  void laillahailallahCounter() {
    if (laillahailallah < target) {
      setState(() {
        laillahailallah++;
        todayCounts[3]++;
      });
    }
  }

  void astaghfirullahCounter() {
    if (astaghfirullah < target) {
      setState(() {
        astaghfirullah++;
        todayCounts[4]++;
      });
    }
  }

  void allahumaCounter() {
    if (allahumasholialamuhammad < target) {
      setState(() {
        allahumasholialamuhammad++;
        todayCounts[5]++;
      });
    }
  }

  void _countDzikir(int index) {
    dzikirCounter(index)();
    if (dzikirCount(index) >= target) {
      setState(() {
        selectedDzikir = (index + 1) % dzikirNames.length;
      });
    }
  }

  void resetSelectedDzikir() {
    setState(() {
      switch (selectedDzikir) {
        case 0:
          subhanallah = 0;
          todayCounts[0] = 0;
        case 1:
          alhamdulillah = 0;
          todayCounts[1] = 0;
        case 2:
          allahuakbar = 0;
          todayCounts[2] = 0;
        case 3:
          laillahailallah = 0;
          todayCounts[3] = 0;
        case 4:
          astaghfirullah = 0;
          todayCounts[4] = 0;
        default:
          allahumasholialamuhammad = 0;
          todayCounts[5] = 0;
      }
    });
  }

  void resetCounter() {
    setState(() {
      subhanallah = 0;
      alhamdulillah = 0;
      allahuakbar = 0;
      laillahailallah = 0;
      astaghfirullah = 0;
      allahumasholialamuhammad = 0;
      todayCounts = List.filled(6, 0);
      selectedDzikir = 0;
    });
  }

  void resetAllCounter() {
    setState(() {
      subhanallah = 0;
      alhamdulillah = 0;
      allahuakbar = 0;
      laillahailallah = 0;
      astaghfirullah = 0;
      allahumasholialamuhammad = 0;
      freeTasbih = 0;
      endTasbih = 0;
      todayCounts = List.filled(6, 0);
      selectedDzikir = 0;
    });
  }

  void tasbihCounter() {
    setState(() {
      freeTasbih++;
    });
  }

  void endTasbihIncrement() {
    setState(() {
      endTasbih++;
    });
  }

  void endTasbihDecrement() {
    setState(() {
      endTasbih--;
    });
  }

  void resetTasbihCounter() {
    setState(() {
      freeTasbih = 0;
      endTasbih = 0;
    });
  }

  String _fmtDate(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  void _saveDaily() {
    final today = _fmtDate(DateTime.now());
    final dailyMap = Map<String, dynamic>.from(box.read('tasbihHarian') ?? {});
    dailyMap[today] = List<int>.from(todayCounts);
    box.write('tasbihHarian', dailyMap);
    box.write('tasbihFree_$today', freeTasbih);
    box.write('tasbihEnd_$today', endTasbih);
  }

  void _save() {
    _saveDaily();
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          padding: EdgeInsets.zero,
          content: Center(
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white24),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Data Tasbih Disimpan",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.check_circle_rounded,
                    size: 16,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#256980"),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 70,
        leadingWidth: 65,
        centerTitle: false,

        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        titleSpacing: 0,
        title: Text(
          "Tasbih",
          style: TextStyle(
            color: Theme.of(context).textTheme.titleMedium?.color,
            fontWeight: FontWeight.w600,
          ),
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
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _dzikirSelector(),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: _dzikirCard(
                      dzikirArabics[selectedDzikir],
                      dzikirArtis[selectedDzikir],
                      dzikirCount(selectedDzikir),
                      () => _countDzikir(selectedDzikir),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("usap ke kiri untuk berdzikir", style: TextStyle(fontSize: 12)),
             SizedBox(height: 10),
          TasbihBeadCounter(
            count: dzikirCount(selectedDzikir),
            enabled: dzikirCount(selectedDzikir) < target,
            onCount: () {
              _vibrate();
              _countDzikir(selectedDzikir);
            },
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.only(right: 40, left: 40, bottom: 50),
            child: Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: resetSelectedDzikir,
                    child: Icon(
                      Iconsax.refresh5,
                      color: HexColor.fromHex("#D39D52"),
                      size: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: _save,
                    child: Icon(
                      Icons.save,
                      color: HexColor.fromHex("#D39D52"),
                      size: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() => TasbihHistoryScreen())?.then((_) => setState(() => _loadTodayData())),
                    child: Icon(
                      Icons.history,
                      color: HexColor.fromHex("#D39D52"),
                      size: 35,
                    ),
                  ),
                 GestureDetector(
                  onTap: () => Get.to(() => TasbihChartScreen())?.then((_) => setState(() => _loadTodayData())),
                  child:  Icon(
                    Icons.bar_chart_rounded,
                    color: HexColor.fromHex("#D39D52"),
                    size: 30,
                  ),
                 )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dzikirSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
 padding: EdgeInsets.only(right: 12, left: 12, bottom: 12),
      child: Row(
        children: [
          for (int i = 0; i < dzikirNames.length; i++)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _dzikirButton(i),
            ),
        ],
      ),
    );
  }

  Widget _dzikirButton(int index) {
    final isActive = selectedDzikir == index;
    final isComplete = dzikirCount(index) >= target;
    final unlocked = _isUnlocked(index);

    return GestureDetector(
      onTap: unlocked
          ? () {
              setState(() {
                selectedDzikir = index;
              });
            }
          : null,
      child: Opacity(
        opacity: unlocked ? 1 : 0.45,
        child: Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: isActive
                ? HexColor.fromHex("#D39D52")
                : Colors.white.withAlpha(35),
            borderRadius: BorderRadius.circular(30),
            border: isActive ? null : Border.all(color: Colors.white24),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isComplete) ...[
                const Icon(
                  Icons.check_circle_rounded,
                  size: 16,
                  color: Colors.white,
                ),
                const SizedBox(width: 5),
              ],
              if (!unlocked) ...[
                const Icon(
                  Icons.lock_rounded,
                  size: 14,
                  color: Colors.white70,
                ),
                const SizedBox(width: 5),
              ],
              Text(
                dzikirNames[index],
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                "${dzikirCount(index)}/33",
                style: TextStyle(
                  fontSize: 12,
                  color: isActive
                      ? Colors.white.withAlpha(220)
                      : HexColor.fromHex("#D39D52"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isUnlocked(int index) {
    for (int i = 0; i < index; i++) {
      if (dzikirCount(i) < target) return false;
    }
    return true;
  }

  Widget _dzikirCard(
    String arabic,
    String arti,
    int count,
    VoidCallback increment,
  ) {
    final isComplete = count >= target;

    return GestureDetector(
      onTap: isComplete
          ? null
          : () {
              _vibrate();
              increment();
            },
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                arabic,
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontFamily: "Tajawal",
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              Text(
                arti,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                count.toString().padLeft(3, '0'),
                style: TextStyle(
                  color: HexColor.fromHex("#D39D52"),
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
