import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/core/services/ukuran_controller.dart';
import 'package:alquran_new/features/pengaturan/controllers/settings_controller.dart';
import 'package:alquran_new/development/tasbih/widgets/tasbih_bead_counter.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
    subhanallah = box.read('subhanallah') ?? 0;
    alhamdulillah = box.read('alhamdulillah') ?? 0;
    allahuakbar = box.read('allahuakbar') ?? 0;
    laillahailallah = box.read('laillahailallah ') ?? 0;
    astaghfirullah = box.read('astaghfirullah') ?? 0;
    allahumasholialamuhammad = box.read('allahumasholialamuhammad') ?? 0;

    freeTasbih = box.read('freeTasbih') ?? 0;
    endTasbih = box.read('endTasbih') ?? 0;
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
        box.write('subhanallah', subhanallah);
      });
    }
  }

  void alhamdulillahCounter() {
    if (alhamdulillah < target) {
      setState(() {
        alhamdulillah++;
        box.write('alhamdulillah', alhamdulillah);
      });
    }
  }

  void allahuakbarCounter() {
    if (allahuakbar < target) {
      setState(() {
        allahuakbar++;
        box.write('allahuakbar', allahuakbar);
      });
    }
  }

  void laillahailallahCounter() {
    if (laillahailallah < target) {
      setState(() {
        laillahailallah++;
        box.write('laillahailallah', laillahailallah);
      });
    }
  }

  void astaghfirullahCounter() {
    if (astaghfirullah < target) {
      setState(() {
        astaghfirullah++;
        box.write('astaghfirullah', astaghfirullah);
      });
    }
  }

  void allahumaCounter() {
    if (allahumasholialamuhammad < target) {
      setState(() {
        allahumasholialamuhammad++;
        box.write('allahumasholialamuhammad', allahumasholialamuhammad);
      });
    }
  }

  void resetCounter() {
    setState(() {
      subhanallah = 0;
      alhamdulillah = 0;
      allahuakbar = 0;
      laillahailallah = 0;
      astaghfirullah = 0;
      allahumasholialamuhammad = 0;
      box.write('subhanallah', 0);
      box.write('alhamdulillah', 0);
      box.write('allahuakbar', 0);
      box.write('laillahailallah', 0);
      box.write('astaghfirullah', 0);
      box.write('allahumasholialamuhammad', 0);
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
      box.write('subhanallah', 0);
      box.write('alhamdulillah', 0);
      box.write('allahuakbar', 0);
      box.write('laillahailallah', 0);
      box.write('astaghfirullah', 0);
      box.write('allahumasholialamuhammad', 0);
      box.write('freeTasbih', 0);
      box.write('endTasbih', 0);
    });
  }

  void tasbihCounter() {
    setState(() {
      freeTasbih++;
      box.write('freeTasbih', freeTasbih);
    });
  }

  void endTasbihIncrement() {
    setState(() {
      endTasbih++;
      box.write('endTasbih', endTasbih);
    });
  }

  void endTasbihDecrement() {
    setState(() {
      endTasbih--;
      box.write('endTasbih', endTasbih);
    });
  }

  void resetTasbihCounter() {
    setState(() {
      freeTasbih = 0;
      endTasbih = 0;

      box.write('freeTasbih', 0);
      box.write('endTasbih', 0);
    });
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: _dzikirCard(
              "سُبْحَانَ اللَّهِ",
              "Maha Suci Allah",
              subhanallah,
              subhanallahCounter,
            ),
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("usap ke kiri untuk berdzikir", style: TextStyle(fontSize: 12)),
             SizedBox(height: 10),
          TasbihBeadCounter(
            count: 2,
            enabled: 1 < 33,
            onCount: () {
              _vibrate();
              // increment();
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
                  Icon(
                    Iconsax.refresh5,
                    color: HexColor.fromHex("#D39D52"),
                    size: 30,
                  ),
                  Icon(
                    Icons.save,
                    color: HexColor.fromHex("#D39D52"),
                    size: 30,
                  ),
                  Icon(
                    Icons.history,
                    color: HexColor.fromHex("#D39D52"),
                    size: 35,
                  ),
                  Icon(
                    Iconsax.moon,
                    color: HexColor.fromHex("#D39D52"),
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dzikirCard(
    String arabic,
    String arti,
    int count,
    VoidCallback increment,
  ) {
    return Stack(
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
              "Tasbih Counter",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "033",
              style: TextStyle(
                color: HexColor.fromHex("#D39D52"),
                fontSize: 70,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
