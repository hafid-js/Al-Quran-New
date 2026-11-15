import 'package:alquran_new/core/constants/app_colors.dart';
import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/core/services/injection_container.dart';
import 'package:alquran_new/core/widgets/settings_slider.dart';
import 'package:alquran_new/core/widgets/settings_switch.dart';
import 'package:alquran_new/development/dev_alquran/domain/entities/ayat.dart';
import 'package:alquran_new/development/dev_alquran/domain/entities/tempat_turun.dart';
import 'package:alquran_new/development/dev_alquran/presentation/bloc/detail_surah_bloc.dart';
import 'package:alquran_new/development/dev_alquran/presentation/bloc/detail_surah_event.dart';
import 'package:alquran_new/development/dev_alquran/presentation/bloc/detail_surah_state.dart';
import 'package:alquran_new/development/dev_alquran/domain/entities/surah_detail.dart';
import 'package:alquran_new/development/pengaturan/controllers/settings_controller.dart';
import 'package:alquran_new/development/bookmark/controllers/bookmark_controller.dart';
import 'package:alquran_new/development/shared/widgets/common_empty_widget.dart';
import 'package:alquran_new/development/shared/widgets/shimmer_detail_surah.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class DetailSurahPage extends StatelessWidget {
  const DetailSurahPage({super.key, required this.nomor, this.targetAyat = 0});

  final int nomor;
  final int targetAyat;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<DetailSurahBloc>()..add(DetailSurahEvent.fetch(nomor: nomor)),
      child: _DetailSurahView(nomor: nomor, targetAyat: targetAyat),
    );
  }
}

class _DetailSurahView extends StatefulWidget {
  const _DetailSurahView({required this.nomor, required this.targetAyat});

  final int nomor;
  final int targetAyat;

  @override
  State<_DetailSurahView> createState() => _DetailSurahViewState();
}

class _DetailSurahViewState extends State<_DetailSurahView>
    with SingleTickerProviderStateMixin {
  final bookmarkC = Get.find<BookmarkController>();
  final SettingsController setting = Get.find<SettingsController>();
  final ItemScrollController itemScrollController = ItemScrollController();

  late AnimationController _animationController;
  late Animation<double> _rotation;
  late Animation<double> _scale;

  bool _isRotated = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _rotation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _scale = Tween<double>(begin: 1, end: 1.25).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isRotated = !_isRotated;
    });

    if (_isRotated) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  Future<void> _refresh() async {
    final bloc = context.read<DetailSurahBloc>();
    bloc.add(DetailSurahEvent.fetch(nomor: widget.nomor));

    try {
      await bloc.stream
          .firstWhere(
            (state) =>
                state is DetailSurahLoaded || state is DetailSurahFailure,
          )
          .timeout(const Duration(seconds: 20));
    } catch (_) {
      // Biarinn RefreshIndicator selesai walau state tidak terdeteksi.
    }
  }

  void _scrollToTarget() {
    if (widget.targetAyat <= 0) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (!mounted) return;

        itemScrollController.scrollTo(
          index: widget.targetAyat + 1,
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOutCubic,
          alignment: 0.2,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = setting.fontSelected.value;
    final fontFamily = fontArabs[selectedIndex]["title"];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocListener<DetailSurahBloc, DetailSurahState>(
      listenWhen: (previous, current) =>
          previous is! DetailSurahLoaded && current is DetailSurahLoaded,
      listener: (context, state) => _scrollToTarget(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).textTheme.titleMedium!.color,
            ),
          ),
          surfaceTintColor: isDark
              ? Theme.of(context).scaffoldBackgroundColor
              : Colors.white,
          backgroundColor: isDark
              ? Theme.of(context).scaffoldBackgroundColor
              : Colors.white,

          title: BlocBuilder<DetailSurahBloc, DetailSurahState>(
            builder: (context, state) {
              final title = state is DetailSurahLoaded
                  ? state.detail.surah.namaLatin
                  : "Quran";

              return Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              );
            },
          ),
          centerTitle: true,
          actions: [
            Icon(
              Iconsax.book_1,
              color: Theme.of(context).textTheme.titleMedium!.color,
            ),
            const SizedBox(width: 15),
            GestureDetector(
              onTap: () async {
                _toggle();

                await WoltModalSheet.show(
                  context: context,
                  pageListBuilder: (context) => [
                    SliverWoltModalSheetPage(
                      backgroundColor: isDark
                          ? Theme.of(context).cardColor
                          : Colors.white,
                      surfaceTintColor: isDark
                          ? Theme.of(context).cardColor
                          : Colors.white,
                      hasTopBarLayer: false,
                      mainContentSliversBuilder: (context) => [
                        SliverToBoxAdapter(
                          child: StatefulBuilder(
                            builder: (context, modalSetState) {
                              return Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        "Pengaturan",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: isDark
                                                  ? AppColors.textPrimaryDark
                                                  : AppColors.primary,
                                            ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    SettingsSwitchTile(
                                      title: "Terjemah",
                                      value: setting.terjemah.value,
                                      onChanged: (v) {
                                        modalSetState(() {
                                          setting.terjemah.value = v;
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 5),
                                    SettingsSwitchTile(
                                      title: "Latin",
                                      value: setting.latin.value,
                                      onChanged: (v) {
                                        modalSetState(() {
                                          setting.latin.value = v;
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 5),
                                    SettingsSwitchTile(
                                      title: "Font Arab Tebal",
                                      value: setting.arabBold.value,
                                      onChanged: (v) {
                                        modalSetState(() {
                                          setting.arabBold.value = v;
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 18),
                                    SettingsSlider(
                                      label: "Ukuran Teks Arab",
                                      value: setting.ukuranTeksArab.value,
                                      onChanged: (v) {
                                        modalSetState(() {
                                          setting.ukuranTeksArab.value = v;
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 14),
                                    SettingsSlider(
                                      label: "Ukuran Teks latin & Terjemah",
                                      value: setting.ukuranLatinTerjemah.value,
                                      onChanged: (v) {
                                        modalSetState(() {
                                          setting.ukuranLatinTerjemah.value = v;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                );

                if (mounted) {
                  _toggle();
                }
              },
              child: RotationTransition(
                turns: _rotation,
                child: ScaleTransition(
                  scale: _scale,
                  child: Icon(
                    _isRotated ? Iconsax.setting_45 : Iconsax.setting_4,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                  ),
                ),
              ),
            ),
          ],
          actionsPadding: const EdgeInsets.all(16),
        ),
        body: BlocBuilder<DetailSurahBloc, DetailSurahState>(
          builder: (context, state) {
            return switch (state) {
              DetailSurahInitial() => CommonEmptyWidget(refresh: _refresh),
              DetailSurahLoading() => const ShimmerDetailSurah(),
              DetailSurahFailure(:final message) => CommonEmptyWidget(
                refresh: _refresh,
                message: message,
              ),
              DetailSurahLoaded(:final detail) => _buildContext(
                context,
                detail,
                isDark,
                fontFamily,
              ),
            };
          },
        ),
      ),
    );
  }

  Widget _buildContext(
    BuildContext context,
    SurahDetail detail,
    bool isDark,
    String fontFamily,
  ) {
    final surah = detail.surah;

    return RefreshIndicator(
      backgroundColor: isDark ? Theme.of(context).cardColor : AppColors.primary,
      color: AppColors.secondary,
      onRefresh: _refresh,
      child: detail.ayat.isEmpty
          ? CommonEmptyWidget(
              message:
                  "Ayat belum terunduh. Periksa koneksi lalu klik tombol Refresh.",
              refresh: _refresh,
            )
          : ScrollablePositionedList.builder(
              itemScrollController: itemScrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: detail.ayat.length + 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildHeader(context, detail, isDark);
                }

                if (index == 1) {
                  if (surah.namaLatin == "Al-Fatihah") {
                    return const SizedBox.shrink();
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Stack(
                      children: [
                        Container(
                          height: 55,
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        Positioned(
                          top: -30,
                          right: 90,
                          child: Image.asset(
                            "assets/images/bismillah.png",
                            height: 90,
                            color: isDark
                                ? AppColors.textPrimaryDark
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return _buildAyatItem(
                  context,
                  detail,
                  detail.ayat[index - 2],
                  isDark,
                  fontFamily,
                );
              },
            ),
    );
  }

  Widget _buildHeader(BuildContext context, SurahDetail detail, bool isDark) {
    final surah = detail.surah;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? Theme.of(context).cardColor : AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headerRow("Surah:", surah.namaLatin),
                _headerRow("Arti:", surah.arti),
                _headerRow("Jumlah Ayat:", surah.jumlahAyat.toString()),
                _headerRow("Tempat Turun:", surah.tempatTurun.label),
              ],
            ),
          ),
          Positioned(
            top: -15,
            right: -5,
            child: SvgPicture.asset(
              width: 140,
              height: 140,
              "assets/svg_arab_kaligrafi/Surah_${surah.nomor}_of_114.svg",
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerRow(String label, String value) {
    return Row(
      children: [
        Text.rich(
          TextSpan(
            text: label,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(width: 5),
        Text.rich(
          TextSpan(
            text: value,
            style: TextStyle(color: AppColors.secondary),
          ),
        ),
      ],
    );
  }

  Widget _buildAyatItem(
    BuildContext context,
    SurahDetail detail,
    Ayat ayat,
    bool isDark,
    String fontFamily,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Container(
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${ayat.nomorAyat}",
              style: TextStyle(
                color: AppColors.secondary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                ayat.teksArab,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                  fontSize: setting.ukuranTeksArab.value,
                  fontFamily: fontFamily,
                  fontWeight: setting.arabBold.value ? FontWeight.w600 : null,
                  height: 2.5,
                ),
              ),
            ),
            if (setting.latin.value || setting.terjemah.value)
              const SizedBox(height: 30),
            if (setting.latin.value)
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  ayat.teksLatin,
                  style: TextStyle(
                    color: isDark ? AppColors.secondary : Colors.black,
                    fontSize: setting.ukuranLatinTerjemah.value,
                  ),
                ),
              ),
            const SizedBox(height: 10),
            if (setting.terjemah.value)
              Text(
                ayat.teksIndonesia,
                style: TextStyle(
                  color: isDark ? AppColors.textPrimaryDark : Colors.black,
                  fontSize: setting.ukuranLatinTerjemah.value,
                ),
              ),
            const Divider(
              thickness: 1,
              color: Color.fromARGB(81, 158, 158, 158),
            ),
            Row(
              children: [
                Expanded(
                  child: _actionButton(
                    icon: Iconsax.copy,
                    isDark: isDark,
                    onTap: () => _copyAyat(context, ayat),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      bookmarkC.toggle(
                        detail.surah.nomor,
                        detail.surah.nama,
                        detail.surah.namaLatin,
                        ayat.nomorAyat,
                      );
                    },
                    child: Obx(() {
                      final saved = bookmarkC.isBookmarked(
                        detail.surah.nomor,
                        ayat.nomorAyat,
                      );

                      return _actionButton(
                        icon: saved ? Iconsax.save_21 : Iconsax.save_2,
                        isDark: isDark,
                        color: saved
                            ? AppColors.secondary
                            : isDark
                            ? Colors.white
                            : HexColor.fromHex("#504F52"),
                      );
                    }),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: _actionButton(
                    icon: Iconsax.play_circle,
                    isDark: isDark,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Audio belum tersedia di dev_alquran'),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: _actionButton(
                    icon: Iconsax.export_2,
                    isDark: isDark,
                    onTap: () => _shareAyat(context, detail, ayat),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: _actionButton(
                    icon: Iconsax.info_circle,
                    isDark: isDark,
                    onTap: () => _showTafsir(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required bool isDark,
    VoidCallback? onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: const Color.fromARGB(37, 158, 158, 158),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(
          icon,
          color: color ?? (isDark ? Colors.white : HexColor.fromHex("#504F52")),
          size: 16,
        ),
      ),
    );
  }

  void _copyAyat(BuildContext context, Ayat ayat) {
    final buffer = StringBuffer();
    buffer.writeln(ayat.teksArab);
    if (ayat.teksLatin.isNotEmpty) {
      buffer.writeln('');
      buffer.writeln(ayat.teksLatin);
    }
    buffer.writeln('');
    buffer.writeln(ayat.teksIndonesia);

    Clipboard.setData(ClipboardData(text: buffer.toString()));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Teks disalin', style: TextStyle(color: Colors.white)),
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.primary,
      ),
    );
  }

  void _shareAyat(BuildContext context, SurahDetail detail, Ayat ayat) {
    final buffer = StringBuffer();
    buffer.writeln(detail.surah.namaLatin);
    buffer.writeln('');
    buffer.writeln('${ayat.nomorAyat}. ${ayat.teksArab}');
    if (ayat.teksLatin.isNotEmpty) {
      buffer.writeln('');
      buffer.writeln(ayat.teksLatin);
    }
    buffer.writeln('');
    buffer.writeln(ayat.teksIndonesia);

    SharePlus.instance.share(
      ShareParams(title: detail.surah.namaLatin, text: buffer.toString()),
    );
  }

  void _showTafsir(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.5,
          minChildSize: 0.3,
          maxChildSize: 1.0,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(
                        Iconsax.book_1,
                        color: AppColors.secondary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Tafsir",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Tafsir belum tersedia di dev_alquran.",
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
