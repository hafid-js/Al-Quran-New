import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/development/ibadah/calendar_picker_modal.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:table_calendar/table_calendar.dart';

class StatistikIbadah extends StatefulWidget {
  const StatistikIbadah({super.key});

  @override
  State<StatistikIbadah> createState() => _StatistikIbadahState();
}

class _StatistikIbadahState extends State<StatistikIbadah> {
  int _selectedPeriod = 0;

  late DateTime _selectedDate;

  late DateTime _selectedWeekStart;

  late DateTime _focusedMonth;

  final GetStorage _storage = GetStorage();

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDate = now;
    _selectedWeekStart = _startOfWeek(now);
    _focusedMonth = DateTime(now.year, now.month, 1);
  }

  String _dayKey(DateTime day) {
    return 'ibadah_${day.year}-${day.month.toString().padLeft(2, '0')}-'
        '${day.day.toString().padLeft(2, '0')}';
  }

  _DailyData _readDay(DateTime day) {
    final data = _storage.read(_dayKey(day));
    if (data is! Map) return const _DailyData.empty();
    int countDone(dynamic list) {
      if (list is! List) return 0;
      return list.where((e) => e is Map && e['done'] == true).length;
    }

    int countMode(dynamic list, String mode) {
      if (list is! List) return 0;
      return list.where((e) => e is Map && e['mode'] == mode).length;
    }

    int tilawahPages = 0;
    final tilawah = data['tilawah'];
    if (tilawah is List) {
      for (final t in tilawah) {
        if (t is Map) {
          tilawahPages += int.tryParse(t['halaman'].toString()) ?? 0;
        }
      }
    }
    final sedekah = data['sedekah'] is List
        ? (data['sedekah'] as List).whereType<int>().toList()
        : <int>[];
    return _DailyData(
      wajibDone: countDone(data['sholatWajib']),
      sunnahDone: countDone(data['sholatSunnah']),
      dzikirDone: countDone(data['dzikir']),
      puasaDone: countDone(data['puasa']),
      tilawahPages: tilawahPages,
      wajibBerjamaah: countMode(data['sholatWajib'], 'berjamaah'),
      sedekah: sedekah,
    );
  }

  List<_DailyData> get _weekData => [
        for (var i = 0; i < 7; i++)
          _readDay(_selectedWeekStart.add(Duration(days: i))),
      ];

  List<_DailyData> get _monthData => [
        for (var day = 1; day <= _daysInMonth(_focusedMonth); day++)
          _readDay(DateTime(_focusedMonth.year, _focusedMonth.month, day)),
      ];

  int _daysInMonth(DateTime d) => DateTime(d.year, d.month + 1, 0).day;

  DateTime _startOfWeek(DateTime date) {
    final monday = date.subtract(Duration(days: date.weekday - 1));
    return DateTime(monday.year, monday.month, monday.day);
  }

  String get _weekRangeLabel {
    final start = _selectedWeekStart;
    final end = start.add(const Duration(days: 6));
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
    final startLabel = '${start.day} ${bulan[start.month - 1]}';
    final endLabel = '${end.day} ${bulan[end.month - 1]} ${end.year}';
    return '$startLabel - $endLabel';
  }

  void _previousWeek() {
    setState(() {
      _selectedWeekStart = _selectedWeekStart.subtract(const Duration(days: 7));
    });
  }

  void _nextWeek() {
    setState(() {
      _selectedWeekStart = _selectedWeekStart.add(const Duration(days: 7));
    });
  }

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
    }
  }

  List<List<int>> get _mingguan =>
      _weekData.map((d) => [d.wajibDone, d.sunnahDone]).toList();

  List<int> get _tilawahMingguan =>
      _weekData.map((d) => d.tilawahPages).toList();

  List<int> get _bulanan =>
      _monthData.map((d) => d.checklistDone + d.tilawahPages + d.sedekah.length).toList();

  int get _weeklyPuasaTotal =>
      _weekData.fold(0, (a, d) => a + d.puasaDone);

  int get _weeklySedekahTotal =>
      _weekData.fold(0, (a, d) => a + d.sedekahTotal);

  List<int> get _harianSedekahList => _readDay(_selectedDate).sedekah;

  int get _harianSedekahTotal => _readDay(_selectedDate).sedekahTotal;

  List<Map<String, String>> get _ringkasanBulanan {
    final m = _monthData;
    final totalWajib = m.fold(0, (a, d) => a + d.wajibDone);
    final totalSunnah = m.fold(0, (a, d) => a + d.sunnahDone);
    final totalTilawah = m.fold(0, (a, d) => a + d.tilawahPages);
    final totalPuasa = m.fold(0, (a, d) => a + d.puasaDone);
    final totalSedekah = m.fold(0, (a, d) => a + d.sedekahTotal);
    final days = _daysInMonth(_focusedMonth);
    final maxWajib = days * 5;
    final maxSunnah = days * 4;
    final maxPuasa = days * 3;
    final maxTilawah = days * 5;
    String pct(int done, int max) =>
        max <= 0 ? '0%' : '${((done / max) * 100).round()}%';
    return [
      {
        'value': '$totalWajib Kali',
        'label': 'Sholat Wajib',
        'percent': pct(totalWajib, maxWajib),
      },
      {
        'value': '$totalSunnah Kali',
        'label': 'Sholat Sunnah',
        'percent': pct(totalSunnah, maxSunnah),
      },
      {
        'value': '$totalTilawah Hal',
        'label': 'Tilawah',
        'percent': pct(totalTilawah, maxTilawah),
      },
      {
        'value': '$totalPuasa Hari',
        'label': 'Puasa Sunnah',
        'percent': pct(totalPuasa, maxPuasa),
      },
      {
        'value': formatRupiah(totalSedekah),
        'label': 'Sedekah',
        'percent': totalSedekah > 0 ? '100%' : '0%',
      },
    ];
  }

  int get _totalDone {
    switch (_selectedPeriod) {
      case 1:
        return _weekData.fold(
          0,
          (a, d) => a + d.wajibDone + d.sunnahDone + d.dzikirDone +
              d.puasaDone + d.tilawahPages + d.sedekah.length,
        );
      case 2:
        return _bulanan.fold(0, (a, b) => a + b);
      default:
        final d = _readDay(_selectedDate);
        return d.checklistDone + d.tilawahPages + d.sedekah.length;
    }
  }

  int get _totalAll {
    switch (_selectedPeriod) {
      case 1:
        return 7 * 14 + _weekData.fold(
          0,
          (a, d) => a + d.tilawahPages + d.sedekah.length,
        );
      case 2:
        return _daysInMonth(_focusedMonth) * 14 + _monthData.fold(
          0,
          (a, d) => a + d.tilawahPages + d.sedekah.length,
        );
      default:
        final d = _readDay(_selectedDate);
        return 14 + d.tilawahPages + d.sedekah.length;
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
    for (final pair in _mingguan) {
      if (pair[0].toDouble() > 8) return pair[0].toDouble();
      if (pair[1].toDouble() > 8) return pair[1].toDouble();
    }
    return 8;
  }

  double get _interval {
    final step = (_maxY / 4).roundToDouble();
    return step > 0 ? step : 1;
  }

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
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
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

  Widget _buildWeeklyDetail() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 16, left: 16, bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: _previousWeek,
                child: Icon(
                  Iconsax.arrow_circle_left,
                  color: HexColor.fromHex("#256980"),
                ),
              ),
              Text(
                _weekRangeLabel,
                style: TextStyle(
                  color: HexColor.fromHex("#256980"),
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: _nextWeek,
                child: Icon(
                  Iconsax.arrow_circle_right,
                  color: HexColor.fromHex("#256980"),
                ),
              ),
            ],
          ),
        ),
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
                                  'Min',
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
                          color: HexColor.fromHex(
                            "#D39D52",
                          ).withValues(alpha: 0.15),
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
                                  'Min',
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
                            FlSpot(
                              i.toDouble(),
                              _tilawahMingguan[i].toDouble(),
                            ),
                        ],
                        color: HexColor.fromHex("#256980"),
                        barWidth: 3,
                        isCurved: true,
                        curveSmoothness: 0.3,
                        dotData: const FlDotData(show: true),
                        belowBarData: BarAreaData(
                          show: true,
                          color: HexColor.fromHex(
                            "#256980",
                          ).withValues(alpha: 0.15),
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
                "$_weeklyPuasaTotal",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
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
                "Total Sedekah Mingguan",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                formatRupiah(_weeklySedekahTotal),
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
                                        "${_readDay(_selectedDate).wajibDone}",
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
                                            "${_readDay(_selectedDate).wajibBerjamaah} Berjamaah",
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
                                        "${_readDay(_selectedDate).sunnahDone}",
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
                                        "${_readDay(_selectedDate).puasaDone}",
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
                                        "${_readDay(_selectedDate).tilawahPages}",
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
              // const SizedBox(height: 12),
              // for (var i = 0; i < _harianSedekahList.length; i++) ...[
              //   if (i > 0) const SizedBox(height: 12),
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         formatRupiah(_harianSedekahList[i]),
              //         style: TextStyle(
              //           fontSize: 14,
              //           color: HexColor.fromHex("#D39D52"),
              //           fontWeight: FontWeight.w600,
              //         ),
              //       ),
              //       GestureDetector(
              //         onTap: () {
              //           setState(() {
              //             _harianSedekahList.removeAt(i);
              //           });
              //         },
              //         child: Icon(Iconsax.close_circle, color: Colors.red),
              //       ),
              //     ],
              //   ),
              // ],
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
                      formatRupiah(_harianSedekahTotal),
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

  Color _consistencyColor(int count) {
    final base = HexColor.fromHex("#256980");
    if (count == 0) return base.withAlpha(15);
    if (count == 1) return base.withAlpha(40);
    if (count == 2) return base.withAlpha(70);
    if (count == 3) return base.withAlpha(100);
    if (count == 4) return base.withAlpha(130);
    if (count == 5) return base.withAlpha(160);
    if (count == 6) return base.withAlpha(190);
    if (count == 7) return base.withAlpha(210);
    if (count == 8) return base.withAlpha(225);
    if (count == 9) return base.withAlpha(240);
    return base;
  }

  Widget _consistencyCell(
    BuildContext context,
    DateTime day,
    DateTime focusedDay,
  ) {
    final d = _readDay(day);
    final count = d.checklistDone + d.tilawahPages + d.sedekah.length;
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: _consistencyColor(count),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildMonthlyDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Konsistensi Ibadah (Bulan Ini)",
            style: TextStyle(
              color: HexColor.fromHex("#256980"),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                TableCalendar(
                  rowHeight: 38,

                  daysOfWeekVisible: false,
                  firstDay: DateTime(2020, 1, 1),
                  lastDay: DateTime(2100, 12, 31),
                  focusedDay: _focusedMonth,
                  onPageChanged: (focusedDay) {
                    setState(() {
                      _focusedMonth = DateTime(
                        focusedDay.year,
                        focusedDay.month,
                        1,
                      );
                    });
                  },
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    leftChevronIcon: Icon(
                      Iconsax.arrow_circle_left,
                      color: HexColor.fromHex("#256980"),
                    ),
                    titleTextStyle: TextStyle(
                      fontSize: 16,
                      color: HexColor.fromHex("#256980"),
                      fontWeight: FontWeight.w600,
                    ),
                    rightChevronIcon: Icon(
                      Iconsax.arrow_circle_right,
                      color: HexColor.fromHex("#256980"),
                    ),
                  ),
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: _consistencyCell,
                  ),
                  calendarStyle: CalendarStyle(
                    cellMargin: const EdgeInsets.all(4),
                    todayDecoration: BoxDecoration(
                      color: HexColor.fromHex("#256980"),
                      // shape: BoxShape.circle,
                    ),
                    isTodayHighlighted: false,
                    outsideDaysVisible: false,
                    defaultTextStyle: TextStyle(fontSize: 0),
                    weekendTextStyle: TextStyle(fontSize: 0),
                    defaultDecoration: BoxDecoration(
                      color: HexColor.fromHex("#256980"),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    weekendDecoration: BoxDecoration(
                      color: HexColor.fromHex("#256980"),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 4),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Sen",
                      style: TextStyle(
                        fontSize: 12,
                        color: HexColor.fromHex("#256980"),
                      ),
                    ),
                    Text(
                      "Sel",
                      style: TextStyle(
                        fontSize: 12,
                        color: HexColor.fromHex("#256980"),
                      ),
                    ),
                    Text(
                      "Rab",
                      style: TextStyle(
                        fontSize: 12,
                        color: HexColor.fromHex("#256980"),
                      ),
                    ),
                    Text(
                      "Kam",
                      style: TextStyle(
                        fontSize: 12,
                        color: HexColor.fromHex("#256980"),
                      ),
                    ),
                    Text(
                      "Jum",
                      style: TextStyle(
                        fontSize: 12,
                        color: HexColor.fromHex("#256980"),
                      ),
                    ),
                    Text(
                      "Sab",
                      style: TextStyle(
                        fontSize: 12,
                        color: HexColor.fromHex("#256980"),
                      ),
                    ),
                    Text(
                      "Min",
                      style: TextStyle(
                        fontSize: 12,
                        color: HexColor.fromHex("#256980"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 90, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sedikit",
                  style: TextStyle(
                    fontSize: 12,
                    color: HexColor.fromHex("#256980"),
                  ),
                ),
                Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                    color: HexColor.fromHex("#256980").withAlpha(60),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                    color: HexColor.fromHex("#256980").withAlpha(160),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                    color: HexColor.fromHex("#256980").withAlpha(220),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                    color: HexColor.fromHex("#256980"),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Text(
                  "Banyak",
                  style: TextStyle(
                    fontSize: 12,
                    color: HexColor.fromHex("#256980"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    SizedBox(height: 16),
    // Container(
    //   padding: EdgeInsets.all(12),
    //   decoration: BoxDecoration(
    //       color: HexColor.fromHex("#256980"),
    //     borderRadius: BorderRadius.circular(16),
    //   ),
    //   child: 
    // )
    Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ringkasan Bulan Ini",
            style: TextStyle(
              color: HexColor.fromHex("#256980"),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16),
        GridView.builder(
          padding: EdgeInsets.zero,
           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 16,
    mainAxisSpacing: 12,
    childAspectRatio: 1.4,
  ),
  itemCount: _ringkasanBulanan.length,
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemBuilder: (context, index) {
    final item = _ringkasanBulanan[index];
    return Container(
      padding: item['label'] == 'Sholat Wajib' ? const EdgeInsets.only(top: 18, right: 18, left: 16, bottom: 0) : const EdgeInsets.all(18),
      decoration: BoxDecoration(
        border: BoxBorder.all(
          width: 1.5,
          color: HexColor.fromHex("#256980"),
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
         Align(
  alignment: Alignment.topRight,
  child: Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 6,
      vertical: 2
    ),
    decoration: BoxDecoration(
      color: HexColor.fromHex("#D39D52"),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Iconsax.arrow_up_3,
          color: Colors.white,
          size: 12,
        ),
        const SizedBox(width: 3),
        Text(
          item['percent'] as String,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12
          ),
        ),
      ],
    ),
  ),
),

          const SizedBox(height: 5),

          Text(
            item['value'] as String,
            style: TextStyle(
              fontSize: 18,
              color: HexColor.fromHex("#256980"),
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            item['label'] as String,
            style: TextStyle(
              fontSize: 12,
              color: HexColor.fromHex("#256980"),
              fontWeight: FontWeight.w500
            ),
          ),
          if(index == 0) 
          Text(
            "${_monthData.fold(0, (a, d) => a + d.wajibBerjamaah)} Berjamaah",
            style: TextStyle(
              fontSize: 10,
              color: HexColor.fromHex("#D39D52"),
              fontWeight: FontWeight.w500
            ),
          ),
        ],
      ),
    );
  },
)
        ],
      ),
    )
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: GestureDetector(
                    onTap: _showCalendarModal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formattedDate,
                          style: TextStyle(
                            color: HexColor.fromHex("#256980"),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(
                          Iconsax.calendar_1,
                          color: HexColor.fromHex("#256980"),
                          size: 28,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildSummaryCard(),
                const SizedBox(height: 16),
                _buildDailyDetail(),
              ],
              if (_selectedPeriod == 1) ...[_buildWeeklyDetail()],
              if (_selectedPeriod == 2) ...[_buildMonthlyDetail()],
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

class _DailyData {
  final int wajibDone;
  final int sunnahDone;
  final int dzikirDone;
  final int puasaDone;
  final int tilawahPages;
  final int wajibBerjamaah;
  final List<int> sedekah;

  const _DailyData({
    required this.wajibDone,
    required this.sunnahDone,
    required this.dzikirDone,
    required this.puasaDone,
    required this.tilawahPages,
    required this.wajibBerjamaah,
    required this.sedekah,
  });

  const _DailyData.empty()
      : wajibDone = 0,
        sunnahDone = 0,
        dzikirDone = 0,
        puasaDone = 0,
        tilawahPages = 0,
        wajibBerjamaah = 0,
        sedekah = const [];

  int get checklistDone => wajibDone + sunnahDone + dzikirDone + puasaDone;

  int get sedekahTotal => sedekah.fold(0, (a, b) => a + b);
}
