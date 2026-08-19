import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TasbihChartScreen extends StatefulWidget {
  const TasbihChartScreen({super.key});

  @override
  State<TasbihChartScreen> createState() => _TasbihChartScreenState();
}

class _TasbihChartScreenState extends State<TasbihChartScreen> {
  final box = GetStorage();
  late final List<String> dzikirNames;
  late final List<int> dzikirCounts;
  late final Map<String, List<int>> dailyMap;

  @override
  void initState() {
    super.initState();
    dzikirNames = [
      "Subhanallah",
      "Alhamdulillah",
      "Allahu Akbar",
      "La ilaha illallah",
      "Astaghfirullahal adzim",
      "Allahuma sholli ala Muhammad",
    ];

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
    dailyMap = map;

    dzikirCounts = List.filled(6, 0);
    for (final entry in dailyMap.values) {
      for (int i = 0; i < 6; i++) {
        dzikirCounts[i] += entry[i];
      }
    }
  }

  String _fmtDate(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  List<int> _dailyFor(DateTime day) {
    final entry = dailyMap[_fmtDate(day)];
    if (entry == null) return List.filled(6, 0);
    final padded = List<int>.from(entry);
    while (padded.length < 6) {
      padded.add(0);
    }
    return padded;
  }

  int _dayTotal(DateTime day) => _dailyFor(day).fold(0, (a, b) => a + b);

  DateTime get _today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  int get tasbihHarian => _dayTotal(_today);

  int get tasbihBulanan {
    var total = 0;
    for (int i = 0; i < 30; i++) {
      total += _dayTotal(_today.subtract(Duration(days: i)));
    }
    return total;
  }

  int _selectedPeriod = 0;

  List<double> _currentValues() {
    switch (_selectedPeriod) {
      case 1:
        return List.generate(
          7,
          (i) => _dayTotal(_today.subtract(Duration(days: 6 - i))).toDouble(),
        );
      case 2:
        return List.generate(
          30,
          (i) => _dayTotal(_today.subtract(Duration(days: 29 - i))).toDouble(),
        );
      default:
        return _dailyFor(_today).map((e) => e.toDouble()).toList();
    }
  }

  double get _maxY {
    final values = _currentValues();
    if (values.isEmpty) return 200;
    final maxVal = values.reduce((a, b) => a > b ? a : b);
    if (maxVal <= 0) return 200;
    return (maxVal / 200).ceilToDouble() * 200;
  }

  double get _interval {
    final step = (_maxY / 4).roundToDouble();
    return step > 0 ? step : 50;
  }

  List<BarChartGroupData> get _barGroups {
    final values = _currentValues();
    final width = _selectedPeriod == 2 ? 8.0 : (_selectedPeriod == 1 ? 20.0 : 25.0);
    return List.generate(values.length, (i) {
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            color: Colors.white,
            toY: values[i],
            width: width,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
        ],
      );
    });
  }

  Widget _periodButton(String label, int index) {
    final active = _selectedPeriod == index;
    return TextButton(
      onPressed: () => setState(() => _selectedPeriod = index),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: active ? HexColor.fromHex("#D39D52") : Colors.white,
        foregroundColor: active ? Colors.white : HexColor.fromHex("#256980"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      child: Text(label, style: const TextStyle(fontSize: 14)),
    );
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
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        titleSpacing: 0,
        title: Text(
          "Ringkasan Tasbih",
          style: TextStyle(
            color: Theme.of(context).textTheme.titleMedium?.color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(right: 12, left: 12, bottom: 12),
        child: Column(
          children: [
            Container(
              height: 400,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: HexColor.fromHex("#256980"),
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                    HexColor.fromHex("#256980").withAlpha(210),
                    BlendMode.srcATop,
                  ),
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/image.png"),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _periodButton("Harian", 0),
                      const SizedBox(width: 10),
                      _periodButton("Mingguan", 1),
                      const SizedBox(width: 10),
                      _periodButton("Bulanan", 2),
                    ],
                  ),

                  const SizedBox(height: 30),

                  Expanded(
                    child: BarChart(
                      BarChartData(
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                        minY: 0,
                        maxY: _maxY,
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: _interval,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  value.toInt().toString(),
                                  style: const TextStyle(fontSize: 11),
                                );
                              },
                            ),
                          ),

                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),

                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),

                          bottomTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),

                        barGroups: _barGroups,
                      ),
                      duration: const Duration(milliseconds: 150),
                      curve: Curves.linear,
                    ),
                  ),
                  SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 50),
                                child: const Text(
                                  "Total Tasbih",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),

                            Positioned(
                              top: 25,
                              right: 10,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Text(
                                    "$tasbihBulanan",
                                    style: TextStyle(
                                      color: HexColor.fromHex("#D39D52"),
                                      height: 1,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                  Positioned(
                                    right: -25,
                                    bottom: -5,
                                    child: const Text(
                                      "kali",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 20),

                      Expanded(
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 50),
                                child: const Text(
                                  "Tasbih Harian",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),

                            Positioned(
                              top: 25,
                              right: 20,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Text(
                                    "$tasbihHarian",
                                    style: TextStyle(
                                      color: HexColor.fromHex("#D39D52"),
                                      height: 1,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                  Positioned(
                                    right: -25,
                                    bottom: -5,
                                    child: const Text(
                                      "kali",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
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
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    for (int i = 0; i < dzikirNames.length; i++)
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: HexColor.fromHex("#256980"),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    Icon(
                                      FlutterIslamicIcons.solidTasbihHand,
                                      size: 30,
                                    ),
                                    SizedBox(width: 20),
                                    Flexible(
                                      child: Text(
                                        dzikirNames[i],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "${dzikirCounts[i]} Total",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
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
          ],
        ),
      ),
    );
  }
}
