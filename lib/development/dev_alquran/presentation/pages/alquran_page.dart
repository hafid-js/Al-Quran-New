import 'package:alquran_new/core/constants/app_colors.dart';
import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/core/services/injection_container.dart';
import 'package:alquran_new/development/dev_alquran/domain/entities/surah.dart';
import 'package:alquran_new/development/dev_alquran/presentation/bloc/surah_bloc.dart';
import 'package:alquran_new/development/dev_alquran/presentation/bloc/surah_event.dart';
import 'package:alquran_new/development/dev_alquran/presentation/bloc/surah_state.dart';
import 'package:alquran_new/development/dev_alquran/presentation/pages/detail_surah_page.dart';
import 'package:alquran_new/development/shared/widgets/common_app_bar.dart';
import 'package:alquran_new/development/shared/widgets/common_empty_widget.dart';
import 'package:alquran_new/development/shared/widgets/octagram_badge.dart';
import 'package:alquran_new/development/shared/widgets/search_bar.dart';
import 'package:alquran_new/development/shared/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

class AlquranPage extends StatelessWidget {
  const AlquranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SurahBloc>()..add(const SurahEvent.fetch()),
      child: const _AlquranView(),
    );
  }
}

class _AlquranView extends StatefulWidget {
  const _AlquranView();

  @override
  State<_AlquranView> createState() => _AlquranViewState();
}

class _AlquranViewState extends State<_AlquranView> {
  String _query = '';

  List<Surah> _filter(List<Surah> surahs) {
    final query = _query.toLowerCase().trim();
    if (query.isEmpty) return surahs;

    return surahs
        .where(
          (e) =>
              e.namaLatin.toLowerCase().contains(query) ||
              e.nama.toLowerCase().contains(query) ||
              e.arti.toLowerCase().contains(query),
        )
        .toList();
  }

  Future<void> _onRefresh() async {
    final bloc = context.read<SurahBloc>();
    bloc.add(const SurahEvent.refresh());

    try {
      await bloc.stream
          .firstWhere((state) => state is SurahLoaded || state is SurahFailure)
          .timeout(const Duration(seconds: 20));
    } catch (_) {
      // Biarkan RefreshIndicator selesai walau state tidak terdeteksi.
    }
  }

  void _retry() {
    context.read<SurahBloc>().add(const SurahEvent.fetch());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CommonAppBar(
        title: "Quran",
        backIconColor: isDark
            ? Theme.of(context).textTheme.titleSmall!.color
            : Theme.of(context).textTheme.titleMedium!.color,
        titleColor: isDark
            ? Theme.of(context).textTheme.titleSmall!.color
            : Theme.of(context).textTheme.titleMedium!.color,
        backgroundColor: isDark
            ? Theme.of(context).scaffoldBackgroundColor
            : AppColors.textPrimaryDark,
        surfaceTintColor: isDark
            ? Theme.of(context).scaffoldBackgroundColor
            : AppColors.textPrimaryDark,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 8, top: 8),
            child: AppSearchBar(
              onChanged: (value) => setState(() => _query = value),
              hintText: "Cari Surah...",
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              child: BlocBuilder<SurahBloc, SurahState>(
                builder: (context, state) {
                  return switch (state) {
                    SurahInitial() => _empty(
                      message: "Data Tidak Ditemukan",
                      showRefresh: false,
                    ),
                    SurahLoading() => const _SurahListShimmer(),
                    SurahFailure(:final message) => _empty(
                      message: message,
                      showRefresh: true,
                    ),
                    SurahLoaded(:final surahs) => _surahList(surahs),
                    SurahRefreshing(:final surahs) => _surahList(surahs),
                  };
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _empty({required String message, required bool showRefresh}) {
    return CommonEmptyWidget(
      message: message,
      showRefresh: showRefresh,
      padded: true,
      bordered: true,
      refresh: _retry,
    );
  }

  Widget _surahList(List<Surah> surahs) {
    final filtered = _filter(surahs);

    if (filtered.isEmpty) {
      return CommonEmptyWidget(
        padded: true,
        bordered: true,
        refresh: _retry,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: filtered.length,
      itemBuilder: (context, index) => _SurahItem(surah: filtered[index]),
    );
  }
}

class _SurahItem extends StatelessWidget {
  const _SurahItem({required this.surah});

  final Surah surah;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => DetailSurahPage(nomor: surah.nomor),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OctagramBadge(
                      number: "${surah.nomor}",
                      numberColor: isDark ? AppColors.light : AppColors.dark,
                    ),
                    const SizedBox(width: 15),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${surah.namaLatin} (${surah.arti})",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall!.copyWith(fontSize: 14),
                          ),
                          Text(
                            "${surah.tempatTurun.name} - ${surah.jumlahAyat} Ayat",
                            style: Theme.of(context).textTheme.labelSmall!
                                .copyWith(
                                  color: isDark
                                      ? AppColors.textPrimaryDark.withAlpha(120)
                                      : HexColor.fromHex("#676767"),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                width: 55,
                height: 55,
                "assets/svg_arab_kaligrafi/Surah_${surah.nomor}_of_114.svg",
                colorFilter: ColorFilter.mode(
                  isDark ? AppColors.light : AppColors.dark,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SurahListShimmer extends StatelessWidget {
  const _SurahListShimmer();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const subWidths = [160.0, 120.0, 140.0, 180.0];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: 9,
      itemBuilder: (context, index) {
        final subWidth = subWidths[index % subWidths.length];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Shimmer.fromColors(
            baseColor: isDark
                ? const Color(0xFF263238)
                : const Color(0xFFE3E7EC),
            highlightColor: isDark
                ? const Color(0xFF3A464F)
                : const Color(0xFFF4F6F9),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ShimmerBox(width: 40, height: 40, radius: 10),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ShimmerBox(
                          width: double.infinity,
                          height: 14,
                          radius: 6,
                        ),
                        const SizedBox(height: 8),
                        ShimmerBox(width: subWidth, height: 12, radius: 6),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  const ShimmerBox(width: 55, height: 55, radius: 8),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}