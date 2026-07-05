import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/features/dzikir/controllers/dzikir_controller.dart';
import 'package:alquran_new/features/dzikir/models/dzikir_item.dart';
import 'package:alquran_new/features/pengaturan/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class DzikirListScreen extends StatefulWidget {
  final String category;

  const DzikirListScreen({super.key, required this.category});

  @override
  State<DzikirListScreen> createState() => _DzikirListScreenState();
}

class _DzikirListScreenState extends State<DzikirListScreen> {
  final SettingsController setting = Get.find<SettingsController>();
  final DzikirController dzikirController = Get.find<DzikirController>();

  List<DzikirItem> get items =>
      dzikirController.dzikirList.where((e) => e.kategori == widget.category).toList();

  void _showDetail(int index) {
    final list = items;

    WoltModalSheet.show(
      context: context,
      pageListBuilder: (bottomSheetContext) {
        return _buildPages(bottomSheetContext, list, index);
      },
    );
  }

  List<SliverWoltModalSheetPage> _buildPages(
    BuildContext context,
    List<DzikirItem> list,
    int initialIndex,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return [
      SliverWoltModalSheetPage(
        backgroundColor: Theme.of(context).cardColor,
        hasTopBarLayer: false,
        mainContentSliversBuilder: (context) => [
          SliverToBoxAdapter(
            child: _DetailContent(
              list: list,
              initialIndex: initialIndex,
              isDark: isDark,
              setting: setting,
              onClose: () {
                Navigator.of(context).maybePop();
              },
            ),
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final list = items;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_circle_left_rounded),
          color: Theme.of(context).iconTheme.color,
        ),
        titleSpacing: 5,
        title: Row(
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Icon(
                Icons.mosque_rounded,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.category,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  "${list.length} Dzikir",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            final dzikir = list[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: () => _showDetail(index),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          contentPadding: const EdgeInsets.only(left: 10),
                          leading: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Theme.of(context).colorScheme.surface,
                            ),
                            child: Center(
                              child: Text(
                                dzikir.id.toString(),
                                style: TextStyle(
                                  fontSize: Theme.of(
                                    context,
                                  ).textTheme.labelMedium?.fontSize,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            dzikir.judul,
                            style: TextStyle(
                              fontSize: Theme.of(
                                context,
                              ).textTheme.labelMedium?.fontSize,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(
                                context,
                              ).textTheme.titleLarge?.color,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          subtitle: Text(
                            "${dzikir.kategori}",
                            style: TextStyle(
                              fontSize: Theme.of(
                                context,
                              ).textTheme.labelSmall?.fontSize,
                              color: Theme.of(
                                context,
                              ).textTheme.labelSmall?.color,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DetailContent extends StatefulWidget {
  final List<DzikirItem> list;
  final int initialIndex;
  final bool isDark;
  final SettingsController setting;
  final VoidCallback onClose;

  const _DetailContent({
    required this.list,
    required this.initialIndex,
    required this.isDark,
    required this.setting,
    required this.onClose,
  });

  @override
  State<_DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<_DetailContent> {
  late int _currentIndex;
  late int _counter;
  double _left = 16;
  double _top = 120;

  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _loadCounter();
  }

  DzikirItem get _item => widget.list[_currentIndex];

  bool get _hasPrev => _currentIndex > 0;
  bool get _hasNext => _currentIndex < widget.list.length - 1;

  void _loadCounter() {
    _counter = box.read('dzikir_count_${_item.id}') ?? 0;
  }

  void _incrementCounter() {
    if (_counter < _item.jumlah) {
      setState(() {
        _counter++;
        box.write('dzikir_count_${_item.id}', _counter);
      });
    }
  }

  void _prev() {
    if (_hasPrev) {
      setState(() {
        _currentIndex--;
        _loadCounter();
      });
    }
  }

  void _next() {
    if (_hasNext) {
      setState(() {
        _currentIndex++;
        _loadCounter();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dzikir = _item;
    final selectedIndex = widget.setting.fontSelected.value;
    final fontFamily = fontArabs[selectedIndex]["title"];

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, top: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      dzikir.judul,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Row(
                    children: [
                      Text("Dibaca:"),
                      SizedBox(width: 5),
                      Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withAlpha(30),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "${dzikir.jumlah}x",
                      style: TextStyle(
                        fontSize: Theme.of(context).textTheme.labelSmall?.fontSize,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                    ],
                  )
                ],
              ),

              const SizedBox(height: 5),

              Text(dzikir.kategori, style: Theme.of(context).textTheme.labelSmall),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: widget.isDark
                      ? HexColor.fromHex("#0b1d26")
                      : Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    dzikir.arab,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 27,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                      height: 2,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                dzikir.latin,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: const Border(
                    left: BorderSide(width: 3, color: Colors.amber),
                  ),
                  color: Colors.amber.withAlpha(10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    dzikir.arti,
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),

              // const SizedBox(height: 20),
              // if (dzikir.penjelasan != null)
              //  Column(
              //   children: [
              //      Text(
              //     dzikir.penjelasan ?? "",
              //     style: Theme.of(context).textTheme.labelMedium,
              //   ),
              // const SizedBox(height: 20),
              //   ],
              //  ),

              // Text("Sumber: ${dzikir.sumber}", style: Theme.of(context).textTheme.labelMedium),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _hasPrev ? _prev : null,
                      icon: const Icon(Icons.arrow_back_rounded, size: 18),
                      label: Text(
                        "Sebelumnya",
                        style: TextStyle(
                          fontSize: Theme.of(
                            context,
                          ).textTheme.labelSmall?.fontSize,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _hasPrev
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).disabledColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Text(
                    "${_currentIndex + 1}/${widget.list.length}",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _hasNext ? _next : null,
                      icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                      label: Text(
                        "Selanjutnya",
                        style: TextStyle(
                          fontSize: Theme.of(
                            context,
                          ).textTheme.labelSmall?.fontSize,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _hasNext
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).disabledColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
        Positioned(
          left: _left,
          top: _top,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _left += details.delta.dx;
                _top += details.delta.dy;
              });
            },
            child: Container(
              width: 85,
              height: 85,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).cardColor,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: CircularPercentIndicator(
                radius: 42.5,
                lineWidth: 4,
                percent: (_counter / _item.jumlah).clamp(0.0, 1.0),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).disabledColor.withAlpha(40),
                center: Material(
                  color: Colors.transparent,
                  shape: const CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: _counter < _item.jumlah ? _incrementCounter : null,
                    splashColor: Theme.of(context).colorScheme.primary.withAlpha(30),
                    highlightColor: Theme.of(context).colorScheme.primary.withAlpha(80),
                    child: Ink(
                      width: 77,
                      height: 77,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "$_counter",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).textTheme.titleLarge?.color,
                            ),
                          ),
                          Text(
                            "/${_item.jumlah}",
                            style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context).textTheme.labelSmall?.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
