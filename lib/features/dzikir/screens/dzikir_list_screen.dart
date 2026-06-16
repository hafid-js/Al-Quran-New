import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/features/dzikir/data/dzikir_data.dart';
import 'package:alquran_new/features/dzikir/models/dzikir_item.dart';
import 'package:alquran_new/features/pengaturan/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class DzikirListScreen extends StatefulWidget {
  final String category;

  const DzikirListScreen({super.key, required this.category});

  @override
  State<DzikirListScreen> createState() => _DzikirListScreenState();
}

class _DzikirListScreenState extends State<DzikirListScreen> {
  final SettingsController setting = Get.find<SettingsController>();

  List<DzikirItem> get items =>
      dzikirList.where((e) => e.kategori == widget.category).toList();

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
      BuildContext context, List<DzikirItem> list, int initialIndex) {
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
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
                          contentPadding:
                              const EdgeInsets.only(left: 16),
                          leading: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(12),
                              color: Theme.of(context)
                                  .colorScheme
                                  .surface,
                            ),
                            child: Center(
                              child: Text(
                                dzikir.id.toString(),
                                style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.fontSize,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary,
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            dzikir.judul,
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.fontSize,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.color,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          subtitle: Text(
                            "${dzikir.jumlah}x | ${dzikir.sumber}",
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.fontSize,
                              color: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.color,
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

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  DzikirItem get _item => widget.list[_currentIndex];

  bool get _hasPrev => _currentIndex > 0;
  bool get _hasNext => _currentIndex < widget.list.length - 1;

  void _prev() {
    if (_hasPrev) {
      setState(() => _currentIndex--);
    }
  }

  void _next() {
    if (_hasNext) {
      setState(() => _currentIndex++);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dzikir = _item;
    final selectedIndex = widget.setting.fontSelected.value;
    final fontFamily = fontArabs[selectedIndex]["title"];

    return Padding(
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
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withAlpha(30),
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
          ),

          const SizedBox(height: 5),

          Text(
            dzikir.kategori,
            style: Theme.of(context).textTheme.labelSmall,
          ),

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
                  color:
                      Theme.of(context).textTheme.titleLarge?.color,
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
              fontStyle: FontStyle.italic,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            dzikir.arti,
            style: Theme.of(context).textTheme.labelMedium,
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
                dzikir.sumber,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.start,
              ),
            ),
          ),

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
                      fontSize: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.fontSize,
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
                      fontSize: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.fontSize,
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

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
