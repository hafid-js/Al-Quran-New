import 'package:alquran_new/features/dzikir/widgets/category_filter.dart';
import 'package:alquran_new/features/dzikir/widgets/tab_item.dart';
import 'package:alquran_new/utils/constants/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
import 'package:input_quantity/input_quantity.dart';

class DzikirScreen extends StatefulWidget {
  const DzikirScreen({super.key});

  @override
  State<DzikirScreen> createState() => _DzikirScreenState();
}

class _DzikirScreenState extends State<DzikirScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#0c1d27"),
      appBar: AppBar(
        toolbarHeight: 40,
        leadingWidth: 65,
        backgroundColor: HexColor.fromHex("#0c1d27"),
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
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            CategoryFilter(),
                            const SizedBox(height: 14),

                            Container(
                              height: 110,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: HexColor.fromHex("#132e3a"),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "سُبْحَانَ اللّهُ",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Maha Suci Allah",
                                    style: TextStyle(
                                      color: HexColor.fromHex("#7c97a6"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Positioned(
                        bottom: 180,
                        right: 60,
                        child: CircularPercentIndicator(
                          backgroundColor: HexColor.fromHex(
                            "#132e3a",
                          ).withAlpha(100),
                          backgroundWidth: 9,
                          radius: 130.0,
                          lineWidth: 8.0,
                          percent: 0.1,
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: HexColor.fromHex("#2cc4b6"),
                          center: Container(
                            width: 230,
                            height: 230,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: HexColor.fromHex("#132e3a"),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "3",
                                  style: TextStyle(
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

                      Positioned(
                        bottom: 40,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Progress Dzikir",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: HexColor.fromHex(
                                                  "#7c97a6",
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "0/6",
                                              style: TextStyle(
                                                color: HexColor.fromHex(
                                                  "#2cc4b6",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        LinearPercentIndicator(
                                          backgroundColor: HexColor.fromHex(
                                            "#1a3a4a",
                                          ),
                                          padding: EdgeInsets.zero,
                                          barRadius: Radius.circular(16),
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width -
                                              175,
                                          animation: true,
                                          lineHeight: 6.0,
                                          animationDuration: 2000,
                                          percent: 0.2,
                                          linearStrokeCap:
                                              LinearStrokeCap.roundAll,
                                          progressColor: HexColor.fromHex(
                                            "#2cc4b6",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 20),

                                  Container(
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
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Stack(
                    children: [
                      SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Target:",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(width: 15),
                          InputQty(
                            qtyFormProps: QtyFormProps(
                              enableTyping: true,
                              style: TextStyle(
                                backgroundColor: HexColor.fromHex(
                                  "#5a7b8a",
                                ).withAlpha(30),
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            decoration: QtyDecorationProps(
                              minusBtn: Container(
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

                              plusBtn: Container(
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
                              btnColor: Colors.transparent,
                              isBordered: false,
                              borderShape: BorderShapeBtn.circle,
                              width: 12,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 240,
                        right: 80,
                        child: CircularPercentIndicator(
                          backgroundColor: HexColor.fromHex(
                            "#132e3a",
                          ).withAlpha(100),
                          backgroundWidth: 9,
                          radius: 130.0,
                          lineWidth: 8.0,
                          percent: 0.1,
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: HexColor.fromHex("#2cc4b6"),
                          center: Container(
                            width: 230,
                            height: 230,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: HexColor.fromHex("#132e3a"),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "3",
                                  style: TextStyle(
                                    fontSize: 60,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "/ 48",
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

                      Positioned(
                        bottom: 40,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: HexColor.fromHex("#1a3a4a"),
                              borderRadius: BorderRadius.circular(12),
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
}
