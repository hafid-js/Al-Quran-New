import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:percent_indicator/percent_indicator.dart';

class StatistikIbadah extends StatefulWidget {
  const StatistikIbadah({super.key});

  @override
  State<StatistikIbadah> createState() => _StatistikIbadahState();
}

class _StatistikIbadahState extends State<StatistikIbadah> {
  int _selectedPeriod = 0;

  final List<Map<String, dynamic>> _harianCategories = [
    {'name': 'Sholat Wajib', 'done': 4, 'total': 5, 'icon': Iconsax.clock_1},
    {'name': 'Sholat Sunnah', 'done': 1, 'total': 4, 'icon': Iconsax.sun_1},
    {'name': 'Dzikir', 'done': 1, 'total': 2, 'icon': Iconsax.moon},
    {
      'name': 'Puasa Sunnah',
      'done': 0,
      'total': 3,
      'icon': Iconsax.calendar_tick,
    },
    {'name': 'Tilawah', 'done': 1, 'total': 5, 'icon': Iconsax.book_1},
    {'name': 'Sedekah', 'done': 1, 'total': 5, 'icon': Iconsax.card_coin},
  ];

  final List<List<int>> _mingguan = [
    [4, 3],
    [6, 5],
    [5, 4],
    [7, 6],
    [3, 2],
    [8, 7],
    [6, 5],
  ];

  final List<int> _tilawahMingguan = [3, 1, 4, 2, 5, 0, 3];

  final List<int> _bulanan = [
    4,
    6,
    5,
    7,
    3,
    8,
    6,
    5,
    7,
    4,
    6,
    8,
    5,
    3,
    7,
    6,
    4,
    5,
    8,
    6,
    3,
    5,
    7,
    4,
    6,
    5,
    8,
    6,
    4,
    7,
  ];

  int get _totalDone {
    switch (_selectedPeriod) {
      case 1:
        return _mingguan.fold(0, (a, b) => a + b[0] + b[1]);
      case 2:
        return _bulanan.fold(0, (a, b) => a + b);
      default:
        return _harianCategories.fold(0, (a, c) => a + (c['done'] as int));
    }
  }

  int get _totalAll {
    switch (_selectedPeriod) {
      case 1:
        return _mingguan.length * 8;
      case 2:
        return _bulanan.length * 8;
      default:
        return _harianCategories.fold(0, (a, c) => a + (c['total'] as int));
    }
  }

  String get _summaryLabel {
    switch (_selectedPeriod) {
      case 1:
        return "amalan minggu ini";
      case 2:
        return "amalan bulan ini";
      default:
        return "amalan hari ini";
    }
  }

  double get _maxY {
    var maxVal = 0.0;
    for (final pair in _mingguan) {
      if (pair[0].toDouble() > maxVal) maxVal = pair[0].toDouble();
      if (pair[1].toDouble() > maxVal) maxVal = pair[1].toDouble();
    }
    if (maxVal <= 0) return 8;
    return 8;
  }

  double get _interval {
    final step = (_maxY / 4).roundToDouble();
    return step > 0 ? step : 1;
  }

  final List<int> _sedekahList = [];
  int get _totalSedekah => _sedekahList.fold(0, (a, b) => a + b);

  BarChartData _weeklyBarChartData() {
    return BarChartData(
      gridData: const FlGridData(show: false),
      borderData: FlBorderData(show: false),
      minY: 0,
      maxY: _maxY,
      alignment: BarChartAlignment.spaceAround,
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem(
              rod.toY.toInt().toString(),
              TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            );
          },
        ),
      ),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: _interval,
            reservedSize: 32,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toInt().toString(),
                style: TextStyle(
                  fontSize: 10,
                  color: HexColor.fromHex("#5a7b8a"),
                ),
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
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            reservedSize: 24,
            getTitlesWidget: (value, meta) {
              final idx = value.toInt();
              if (idx < 0 || idx > 6) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  const ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'][idx],
                  style: TextStyle(
                    fontSize: 9,
                    color: HexColor.fromHex("#5a7b8a"),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      barGroups: [
        for (var i = 0; i < _mingguan.length; i++)
          BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                color: HexColor.fromHex("#256980"),
                toY: _mingguan[i][0].toDouble(),
                width: 9,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                ),
              ),
              BarChartRodData(
                color: HexColor.fromHex("#D39D52"),
                toY: _mingguan[i][1].toDouble(),
                width: 9,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                ),
              ),
            ],
          ),
      ],
    );
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      child: Text(label, style: const TextStyle(fontSize: 13)),
    );
  }

  Widget _buildSummaryCard() {
    final percent = _totalAll == 0 ? 0.0 : _totalDone / _totalAll;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HexColor.fromHex("#256980"),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ringkasan Ibadah",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 30),

          Center(
            child: CircularPercentIndicator(
              radius: 90,
              lineWidth: 40,
              percent: percent,
              backgroundWidth: 30,
              backgroundColor: Colors.white24,
              progressColor: HexColor.fromHex("#D39D52"),
              animation: true,
              animationDuration: 1200,
              curve: Curves.easeOutCubic,
              animateFromLastPercent: true,
              center: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "$_totalDone/$_totalAll",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${(percent * 100).round()}%",
                    style: TextStyle(
                      color: HexColor.fromHex("#D39D52"),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              "$_totalDone dari $_totalAll $_summaryLabel selesai",
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartCard() {
    return Column(
      children: [
        Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Statistik Sholat Mingguan",
            style: TextStyle(
              color: HexColor.fromHex("#256980"),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: BarChart(
              _weeklyBarChartData(),
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: HexColor.fromHex("#256980"),
                      radius: 8,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Sholat Wajib",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: HexColor.fromHex("#256980"),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: HexColor.fromHex("#D39D52"),
                      radius: 8,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Sholat Sunnah",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: HexColor.fromHex("#256980"),
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
    SizedBox(height: 16),
    Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Statistik Sholat Sunnah Mingguan",
            style: TextStyle(
              color: HexColor.fromHex("#256980"),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 6,
                minY: 0,
                maxY: _maxY,
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (spots) => [
                      for (final spot in spots)
                        LineTooltipItem(
                          spot.y.toInt().toString(),
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: _interval,
                      reservedSize: 32,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: TextStyle(
                            fontSize: 10,
                            color: HexColor.fromHex("#5a7b8a"),
                          ),
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
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      reservedSize: 24,
                      getTitlesWidget: (value, meta) {
                        final idx = value.toInt();
                        if (idx < 0 || idx > 6) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            const [
                              'Sen',
                              'Sel',
                              'Rab',
                              'Kam',
                              'Jum',
                              'Sab',
                              'Min'
                            ][idx],
                            style: TextStyle(
                              fontSize: 9,
                              color: HexColor.fromHex("#5a7b8a"),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      for (var i = 0; i < _mingguan.length; i++)
                        FlSpot(i.toDouble(), _mingguan[i][1].toDouble()),
                    ],
                    color: HexColor.fromHex("#D39D52"),
                    barWidth: 3,
                    isCurved: true,
                    curveSmoothness: 0.3,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      color: HexColor.fromHex("#D39D52").withValues(alpha: 0.15),
                    ),
                  ),
                ],
              ),
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOutCubic,
            ),
          ),
        ],
      ),
    ),
    SizedBox(height: 16),
    Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Statistik Tilawah Mingguan (Halaman)",
            style: TextStyle(
              color: HexColor.fromHex("#256980"),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 6,
                minY: 0,
                maxY: _maxY,
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (spots) => [
                      for (final spot in spots)
                        LineTooltipItem(
                          spot.y.toInt().toString(),
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: _interval,
                      reservedSize: 32,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: TextStyle(
                            fontSize: 10,
                            color: HexColor.fromHex("#5a7b8a"),
                          ),
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
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      reservedSize: 24,
                      getTitlesWidget: (value, meta) {
                        final idx = value.toInt();
                        if (idx < 0 || idx > 6) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            const [
                              'Sen',
                              'Sel',
                              'Rab',
                              'Kam',
                              'Jum',
                              'Sab',
                              'Min'
                            ][idx],
                            style: TextStyle(
                              fontSize: 9,
                              color: HexColor.fromHex("#5a7b8a"),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      for (var i = 0; i < _tilawahMingguan.length; i++)
                        FlSpot(i.toDouble(), _tilawahMingguan[i].toDouble()),
                    ],
                    color: HexColor.fromHex("#256980"),
                    barWidth: 3,
                    isCurved: true,
                    curveSmoothness: 0.3,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      color: HexColor.fromHex("#256980")
                          .withValues(alpha: 0.15),
                    ),
                  ),
                ],
              ),
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOutCubic,
            ),
          ),
        ],
      ),
    ),
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
                      "Total Puasa Mingguan",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "4",
                      style: TextStyle(
                        fontSize: 16,
                        color: HexColor.fromHex("#D39D52"),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
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
                      "Total Sedekah Mingguan)",
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
    );
  }

  Widget _buildDailyDetail() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Rincian Harian",
                style: TextStyle(
                  color: HexColor.fromHex("#256980"),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: HexColor.fromHex("#256980"),
                                  width: 1.5,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Sholat Wajib",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: HexColor.fromHex("#256980"),
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "2",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: HexColor.fromHex("#D39D52"),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const Text(
                                            "Terlaksana",
                                            style: TextStyle(fontSize: 12),
                                          ),

                                          Text(
                                            "0 Berjamaah",
                                            style: TextStyle(
                                              color: HexColor.fromHex(
                                                "#256980",
                                              ),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(width: 8),

                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: HexColor.fromHex("#256980"),
                                  width: 1.5,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Sholat Sunnah",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: HexColor.fromHex("#256980"),
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "1",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: HexColor.fromHex("#D39D52"),
                                        ),
                                      ),
                                      const Text(
                                        "Amal",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
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
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: HexColor.fromHex("#256980"),
                                  width: 1.5,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Puasa Sunnah",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: HexColor.fromHex("#256980"),
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "1",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: HexColor.fromHex("#D39D52"),
                                        ),
                                      ),
                                      const Text(
                                        "Hari Ini",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(width: 8),

                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: HexColor.fromHex("#256980"),
                                  width: 1.5,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Tilawah Hari Ini",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: HexColor.fromHex("#256980"),
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "1",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: HexColor.fromHex("#D39D52"),
                                        ),
                                      ),
                                      const Text(
                                        "Halaman",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
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

              // for (var i = 0; i < _harianCategories.length; i++) ...[
              //   if (i > 0) const SizedBox(height: 14),
              //   _buildCategoryRow(_harianCategories[i]),
              // ],
            ],
          ),
        ),
        SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.all(16),
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
                ],
              ),

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
                      },
                      child: Icon(Iconsax.close_circle, color: Colors.red),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#F9F5EF"),
      appBar: AppBar(
        backgroundColor: HexColor.fromHex("#F9F5EF"),
        surfaceTintColor: Colors.transparent,
        leadingWidth: 65,
        centerTitle: false,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        titleSpacing: 0,
        title: Text(
          "Statistik Ibadah",
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _periodButton("Harian", 0),
                  const SizedBox(width: 8),
                  _periodButton("Mingguan", 1),
                  const SizedBox(width: 8),
                  _periodButton("Bulanan", 2),
                ],
              ),
              SizedBox(height: 16),
              if (_selectedPeriod == 0) ...[
                _buildSummaryCard(),
                const SizedBox(height: 16),
                _buildDailyDetail(),
              ],
              if (_selectedPeriod == 1) ...[
                _buildChartCard(),
              ],
              const SizedBox(height: 16),
              Center(
                child: Text(
                  "Semoga amal ibadahmu diterima oleh Allah SWT.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: HexColor.fromHex("#5a7b8a"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
