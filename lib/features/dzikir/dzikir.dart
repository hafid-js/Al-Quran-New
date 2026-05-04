import 'package:alquran_new/features/dzikir/widgets/category_filter.dart';
import 'package:alquran_new/features/dzikir/widgets/tab_item.dart';
import 'package:alquran_new/utils/constants/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class DzikirScreen extends StatefulWidget {
  const DzikirScreen({super.key});

  @override
  State<DzikirScreen> createState() => _DzikirScreenState();
}

class _DzikirScreenState extends State<DzikirScreen> {
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
 
      appBar: AppBar(
        toolbarHeight: 40,
        leadingWidth: 65,
   
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              decoration: BoxDecoration(
                color: HexColor.fromHex("#132e3a"),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.arrow_circle_left_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
        titleSpacing: 5,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dzikir",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Total Dzikir: 197",
                  style: TextStyle(
                    color: HexColor.fromHex("#7c97a6"),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: HexColor.fromHex("#5a7b8a").withAlpha(30),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.rotate_left_outlined,
                    color: HexColor.fromHex("#7c97a6"),
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: HexColor.fromHex("#132e3a"),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 6,
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: HexColor.fromHex("#2cc4b6"),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: HexColor.fromHex("#7c97a6"),
                    tabs: const [
                      TabItem(title: "Dzikir Ba'da Sholat"),
                      TabItem(title: 'Tasbih Bebas'),
                    ],
                  ),
                ),
              ),
            ),

            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _dzikirButton("Subhanallah", subhanallah, 0),
                              const SizedBox(width: 6),
                              _dzikirButton("Alhamdulillah", alhamdulillah, 1),
                              const SizedBox(width: 6),
                              _dzikirButton("Allahuakbar", allahuakbar, 2),
                              const SizedBox(width: 6),
                              _dzikirButton(
                                "La ilaha illallah",
                                laillahailallah,
                                3,
                              ),
                              const SizedBox(width: 6),
                              _dzikirButton(
                                "Astaghfirullahal adzim",
                                astaghfirullah,
                                4,
                              ),
                              const SizedBox(width: 6),
                              _dzikirButton(
                                "Allahuma sholli ala Muhammad",
                                allahumasholialamuhammad,
                                5,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 14),

                        Expanded(child: _dzikirContent()),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Target:",
                            style: TextStyle(
                              color: HexColor.fromHex("#7c97a6"),
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 15),
                          GestureDetector(
                            onTap: endTasbih <= freeTasbih
                                ? null
                                : () {
                                    setState(() {
                                      endTasbihDecrement();
                                    });
                                  },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: HexColor.fromHex(
                                  "#5a7b8a",
                                ).withAlpha(30),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.indeterminate_check_box_rounded,
                                color: HexColor.fromHex("#7c97a6"),
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Container(
                            height: 45,
                            width: 70,
                            decoration: BoxDecoration(
                              color: HexColor.fromHex("#5a7b8a").withAlpha(30),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                "$endTasbih",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                endTasbihIncrement();
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: HexColor.fromHex(
                                  "#5a7b8a",
                                ).withAlpha(30),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.add_box_rounded,
                                color: HexColor.fromHex("#7c97a6"),
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: CircularPercentIndicator(
                          backgroundColor: HexColor.fromHex(
                            "#132e3a",
                          ).withAlpha(100),
                          backgroundWidth: 9,
                          radius: 130.0,
                          lineWidth: 8.0,
                          percent: freeTasbih == 0
                              ? 0
                              : (freeTasbih / endTasbih).clamp(0.0, 1.0),
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: HexColor.fromHex("#2cc4b6"),
                          center: Material(
                            color: Colors.transparent,
                            shape: const CircleBorder(),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: freeTasbih >= endTasbih
                                  ? null
                                  : () {
                                      setState(() {
                                        tasbihCounter();
                                      });
                                    },
                              splashColor: Colors.white.withAlpha(30),
                              highlightColor: Colors.white.withAlpha(80),
                              child: Ink(
                                width: 230,
                                height: 230,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: HexColor.fromHex("#132e3a"),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "$freeTasbih",
                                      style: const TextStyle(
                                        fontSize: 60,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "/ $endTasbih",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: HexColor.fromHex("#7c97a6"),
                                      ),
                                    ),
                                    Text(
                                      "Tap untuk menghitung",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: HexColor.fromHex("#7c97a6"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 40,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                resetTasbihCounter();
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: HexColor.fromHex("#1a3a4a"),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.cached_rounded,
                                    color: HexColor.fromHex("#7c97a6"),
                                    size: 18,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    "Reset",
                                    style: TextStyle(
                                      color: HexColor.fromHex("#7c97a6"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dzikirButton(String title, int counter, int index) {
    final isActive = selectedDzikir == index;

    final count = counter;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDzikir = index;
        });
      },
      child: Container(
        height: 50,

        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),

        decoration: count >= 33
            ? BoxDecoration(
                color: HexColor.fromHex("#2cc4b6").withAlpha(40),
                borderRadius: BorderRadius.circular(10),
                border: BoxBorder.all(
                  color: HexColor.fromHex("#2cc4b6"),
                  width: 0.5,
                ),
              )
            : BoxDecoration(
                color: isActive
                    ? HexColor.fromHex("#2cc4b6")
                    : HexColor.fromHex("#132e3a"),
                borderRadius: BorderRadius.circular(10),
              ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                count >= 33
                    ? Icon(
                        Icons.check_circle_rounded,
                        size: 16,
                        color: HexColor.fromHex("#2cc4b6"),
                      )
                    : SizedBox.shrink(),
                count >= 33 ? SizedBox(width: 5) : SizedBox.shrink(),
                Text(
                  title,
                  style: count >= 33
                      ? TextStyle(
                          fontSize: 12,
                          color: HexColor.fromHex("#2cc4b6"),
                          fontWeight: FontWeight.w500,
                        )
                      : TextStyle(
                          fontSize: 12,
                          color: isActive
                              ? Colors.white
                              : HexColor.fromHex("#7c97a6"),
                          fontWeight: FontWeight.w500,
                        ),
                ),
              ],
            ),
            SizedBox(width: 5),
            Text(
              "${counter.toString()}/33",
              style: TextStyle(
                fontSize: 11,
                color: count >= 33
                    ? HexColor.fromHex("#7c97a6")
                    : isActive
                    ? Colors.white
                    : HexColor.fromHex("#7c97a6"),
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dzikirContent() {
    if (selectedDzikir == 0) {
      return _dzikirCard(
        "سُبْحَانَ اللَّهِ",
        "Maha Suci Allah",
        subhanallah,
        subhanallahCounter,
      );
    } else if (selectedDzikir == 1) {
      return _dzikirCard(
        "الْحَمْدُ لِلَّهِ",
        "Segala puji bagi Allah",
        alhamdulillah,
        alhamdulillahCounter,
      );
    } else if (selectedDzikir == 2) {
      return _dzikirCard(
        "اللَّهُ أَكْبَرُ",
        "Allah Maha Besar",
        allahuakbar,
        allahuakbarCounter,
      );
    } else if (selectedDzikir == 3) {
      return _dzikirCard(
        "لَا إِلٰهَ إِلَّا اللَّهُ",
        "Tiada Tuhan selain Allah",
        laillahailallah,
        laillahailallahCounter,
      );
    } else if (selectedDzikir == 4) {
      return _dzikirCard(
        "أَسْتَغْفِرُ اللَّهَ",
        "Aku memohon ampun kepada Allah",
        astaghfirullah,
        astaghfirullahCounter,
      );
    } else {
      return _dzikirCard(
        "اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ",
        "Ya Allah, limpahkan sholawat kepada Nabi Muhammad",
        allahumasholialamuhammad,
        allahumaCounter,
      );
    }
  }

  Widget _dzikirCard(
    String arabic,
    String arti,
    int count,
    VoidCallback increment,
  ) {
    return Stack(
      children: [
        Container(
          height: 130,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: HexColor.fromHex("#132e3a"),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                arabic,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 30),
              ),
              const SizedBox(height: 10),
              Text(arti, style: TextStyle(color: HexColor.fromHex("#7c97a6"))),
            ],
          ),
        ),
        Positioned(
          bottom: 180,
          right: 60,
          child: CircularPercentIndicator(
            backgroundColor: HexColor.fromHex("#132e3a").withAlpha(100),
            backgroundWidth: 9,
            radius: 130.0,
            lineWidth: 8.0,
            percent: (count / 33).clamp(0.0, 1.0),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: HexColor.fromHex("#2cc4b6"),
            center: Material(
              color: Colors.transparent,
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: count >= 33
                    ? null
                    : () {
                        setState(() {
                          increment();
                        });
                      },
                splashColor: Colors.white.withAlpha(30),
                highlightColor: Colors.white.withAlpha(80),
                child: Ink(
                  width: 230,
                  height: 230,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: HexColor.fromHex("#132e3a"),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$count",
                        style: const TextStyle(
                          fontSize: 60,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "/ 33",
                        style: TextStyle(
                          fontSize: 18,
                          color: HexColor.fromHex("#7c97a6"),
                        ),
                      ),
                      Text(
                        "Tap untuk menghitung",
                        style: TextStyle(
                          fontSize: 12,
                          color: HexColor.fromHex("#7c97a6"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: HexColor.fromHex("#132e3a"),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Progress Dzikir",
                              style: TextStyle(
                                fontSize: 14,
                                color: HexColor.fromHex("#7c97a6"),
                              ),
                            ),

                            Text(
                              "${dzikirSelesai()}/6",
                              style: TextStyle(
                                color: HexColor.fromHex("#2cc4b6"),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        LinearPercentIndicator(
                          backgroundColor: HexColor.fromHex("#1a3a4a"),
                          padding: EdgeInsets.zero,
                          barRadius: Radius.circular(16),
                          width: MediaQuery.of(context).size.width - 175,
                          animation: true,
                          lineHeight: 6.0,
                          animationDuration: 2000,
                          percent: (dzikirSelesai() / 6).clamp(0.0, 1.0),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: HexColor.fromHex("#2cc4b6"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),

                  InkWell(
                    onTap: () {
                      setState(() {
                        resetCounter();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: HexColor.fromHex("#1a3a4a"),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.cached_rounded,
                            color: HexColor.fromHex("#7c97a6"),
                            size: 18,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Reset",
                            style: TextStyle(
                              color: HexColor.fromHex("#7c97a6"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
