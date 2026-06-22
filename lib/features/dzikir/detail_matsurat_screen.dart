import 'package:alquran_new/features/dzikir/widgets/dzikir_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class DetailMatsuratScreen extends StatefulWidget {
  const DetailMatsuratScreen({super.key});

  @override
  State<DetailMatsuratScreen> createState() => _DetailMatsuratScreenState();
}

class _DetailMatsuratScreenState extends State<DetailMatsuratScreen> {
  double ukuranteksArab = 18;
  double ukuranLatinTerjemah = 14;
  bool latin = true;
  bool terjemah = true;
  bool getar = true;
  bool tasbih = true;

  final List<Map<String, dynamic>> _dzikirItems = [
    {
      "dibaca": 3,
      "title": "Ta'awudz",
      "jumlah": 3,
      "arab": "أَعُوْذُ بِاللهِ مِنَ الشَّيْطَانِ الرَّجِيْمِ",
      "latin": "A'uudzu billaahi minasy-syaitoonir rojiim",
      "arti": "Aku berlindung kepada Allah Yang Maha Mendengar lagi Maha Mengetahui dari godaan setan yang terkutuk.",
    },
    {
      "dibaca": 2,
      "title": "Ta'awudz",
      "jumlah": 2,
      "arab": "أَعُوْذُ بِاللهِ مِنَ الشَّيْطَانِ الرَّجِيْمِ",
      "latin": "A'uudzu billaahi minasy-syaitoonir rojiim",
      "arti": "Aku berlindung kepada Allah Yang Maha Mendengar lagi Maha Mengetahui dari godaan setan yang terkutuk.",
    },
    {
      "dibaca": 3,
      "title": "Ta'awudz",
      "jumlah": 3,
      "arab": "أَعُوْذُ بِاللهِ مِنَ الشَّيْطَانِ الرَّجِيْمِ",
      "latin": "A'uudzu billaahi minasy-syaitoonir rojiim",
      "arti": "Aku berlindung kepada Allah Yang Maha Mendengar lagi Maha Mengetahui dari godaan setan yang terkutuk.",
    },
  ];

  late List<GlobalKey> _cardKeys;
  late List<int> _hitungList;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _cardKeys = List.generate(_dzikirItems.length, (_) => GlobalKey());
    _hitungList = List.filled(_dzikirItems.length, 0);
  }

  void _onTasbihTap() {
    if (_currentIndex >= _dzikirItems.length) return;
    final jumlah = _dzikirItems[_currentIndex]["jumlah"] as int;
    if (_hitungList[_currentIndex] < jumlah) {
      setState(() {
        _hitungList[_currentIndex]++;
      });
      if (_hitungList[_currentIndex] >= jumlah &&
          _currentIndex < _dzikirItems.length - 1) {
        final nextIndex = _currentIndex + 1;
        setState(() {
          _currentIndex = nextIndex;
        });
        _scrollToCard(nextIndex);
      }
    }
  }

  void _onCardTap(int index) {
    if (index != _currentIndex) return;
    _onTasbihTap();
  }

  void _scrollToCard(int index) {
    final context = _cardKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOutCubic,
        alignment: 0.02,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: false,
            floating: true,
            backgroundColor: Colors.transparent,
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.only(
                  right: 16,
                  left: 16,
                  bottom: 16,
                  top: 80,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 18,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Icon(Icons.arrow_back_ios),
                          ),
                          Column(
                            children: [
                              Text(
                                "Dzikir Pagi Sugro",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Text("Gulir untuk mebaca seluruh dzikir"),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              WoltModalSheet.show(
                                context: context,
                                pageListBuilder: (modalSheetContext) => [
                                  SliverWoltModalSheetPage(
                                    backgroundColor: Theme.of(
                                      context,
                                    ).cardColor,
                                    hasTopBarLayer: false,
                                    mainContentSliversBuilder: (context) => [
                                      SliverToBoxAdapter(
                                        child: StatefulBuilder(
                                          builder: (context, modalSetState) {
                                            return Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      "Pengaturan",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge!
                                                          .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),

                                                  Text(
                                                    "Ukuran Teks Arab",
                                                    style: Theme.of(
                                                      context,
                                                    ).textTheme.titleSmall,
                                                  ),
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          modalSetState(() {
                                                            if (ukuranteksArab >
                                                                 10) {
                                                              ukuranteksArab -=
                                                                  1;
                                                            }
                                                          });
                                                          setState(() {});
                                                        },
                                                        icon: const Icon(
                                                          Icons.remove_rounded,
                                                        ),
                                                      ),

                                                      Expanded(
                                                        child: Slider(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          value:
                                                              ukuranteksArab,
                                                          max: 30,
                                                          divisions: 30,
                                                          label:
                                                              ukuranteksArab
                                                                  .round()
                                                                  .toString(),
                                                          onChanged: (value) {
                                                            modalSetState(() {
                                                              ukuranteksArab =
                                                                  value;
                                                            });
                                                            setState(() {});
                                                          },
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          IconButton(
                                                            onPressed: () {
                                                              modalSetState(() {
                                                                if (ukuranteksArab <
                                                                    30) {
                                                                  ukuranteksArab +=
                                                                      1;
                                                                }
                                                              });
                                                              setState(() {});
                                                            },
                                                            icon: const Icon(
                                                              Icons.add_rounded,
                                                            ),
                                                          ),
                                                          Text(
                                                            "${ukuranteksArab.toInt()}pt",
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 20),

                                                  Text(
                                                    "Ukuran Teks latin & Terjemah",
                                                    style: Theme.of(
                                                      context,
                                                    ).textTheme.titleSmall,
                                                  ),
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          modalSetState(() {
                                                            if (ukuranLatinTerjemah >
                                                                 10) {
                                                              ukuranLatinTerjemah -=
                                                                  1;
                                                            }
                                                          });
                                                          setState(() {});
                                                        },
                                                        icon: const Icon(
                                                          Icons.remove_rounded,
                                                        ),
                                                      ),

                                                      Expanded(
                                                        child: Slider(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          value:
                                                              ukuranLatinTerjemah,
                                                          max: 30,
                                                          divisions: 30,
                                                          label:
                                                              ukuranLatinTerjemah
                                                                  .round()
                                                                  .toString(),
                                                          onChanged: (value) {
                                                            modalSetState(() {
                                                              ukuranLatinTerjemah =
                                                                  value;
                                                            });
                                                            setState(() {});
                                                          },
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          IconButton(
                                                            onPressed: () {
                                                              modalSetState(() {
                                                                if (ukuranLatinTerjemah <
                                                                    30) {
                                                                  ukuranLatinTerjemah +=
                                                                      1;
                                                                }
                                                              });
                                                              setState(() {});
                                                            },
                                                            icon: const Icon(
                                                              Icons.add_rounded,
                                                            ),
                                                          ),
                                                          Text(
                                                            "${ukuranLatinTerjemah.toInt()}pt",
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Tampilan Latin",
                                                        style: Theme.of(
                                                          context,
                                                        ).textTheme.titleSmall,
                                                      ),
                                                      Switch(
                                                        value: latin,
                                                        activeThumbColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .primary,
                                                        onChanged:
                                                            (bool value) {
                                                              modalSetState(() {
                                                                latin = value;
                                                              });
                                                            },
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Tampilan Terjemah",
                                                        style: Theme.of(
                                                          context,
                                                        ).textTheme.titleSmall,
                                                      ),
                                                      Switch(
                                                        value: terjemah,
                                                        activeThumbColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .primary,
                                                        onChanged:
                                                            (bool value) {
                                                              modalSetState(() {
                                                                terjemah =
                                                                    value;
                                                              });
                                                            },
                                                      ),
                                                    ],
                                                  ),

                                                  const SizedBox(height: 20),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Getar Saat Tap",
                                                        style: Theme.of(
                                                          context,
                                                        ).textTheme.titleSmall,
                                                      ),
                                                      Switch(
                                                        value: getar,
                                                        activeThumbColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .primary,
                                                        onChanged:
                                                            (bool value) {
                                                              modalSetState(() {
                                                                getar = value;
                                                              });
                                                            },
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Tampilkan Tasbih Scroll",
                                                        style: Theme.of(
                                                          context,
                                                        ).textTheme.titleSmall,
                                                      ),
                                                      Switch(
                                                        value: tasbih,
                                                        activeThumbColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .primary,
                                                        onChanged:
                                                            (bool value) {
                                                              modalSetState(() {
                                                                tasbih = value;
                                                              });
                                                            },
                                                      ),
                                                    ],
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
                            },
                            child: const Icon(Icons.settings),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    ...List.generate(_dzikirItems.length, (i) {
                      final item = _dzikirItems[i];
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: i < _dzikirItems.length - 1 ? 10 : 0,
                        ),
                        child: DzikirCard(
                          key: _cardKeys[i],
                          ukuranTeksArab: ukuranteksArab,
                          ukuranTeksLatinTerjemah: ukuranLatinTerjemah,
                          dibaca: item["dibaca"],
                          title: item["title"],
                          hitung: _hitungList[i],
                          jumlah: item["jumlah"],
                          arab: item["arab"],
                          latin: item["latin"],
                          arti: item["arti"],
                          onIncrement: () => _onCardTap(i),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 25),
              decoration: BoxDecoration(
                border: BoxBorder.all(
                  width: 1,
                  color: Theme.of(context).colorScheme.primary.withAlpha(100),
                ),
                color: Theme.of(context).colorScheme.primary.withAlpha(18),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.play_arrow_rounded, size: 30),
                  ),
                  const SizedBox(width: 80),
                  const Icon(Icons.share_rounded),
                ],
              ),
            ),

            Positioned(
              top: -40,
              child: CircularPercentIndicator(
                animateFromLastPercent: true,
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.primary.withAlpha(20),
                backgroundWidth: 9,
                radius: 45,
                lineWidth: 4,
                percent: _currentIndex < _dzikirItems.length
                    ? (_hitungList[_currentIndex] /
                            _dzikirItems[_currentIndex]["jumlah"])
                        .clamp(0.0, 1.0)
                    : 0.0,
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Theme.of(context).colorScheme.primary,
                center: GestureDetector(
                  onTap: _onTasbihTap,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              top: 15,
                              left: 15,
                              child: Text(
                                "${_hitungList[_currentIndex]}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontWeight: FontWeight.w700),
                              ),
                            ),
                            Icon(FlutterIslamicIcons.solidTasbih, size: 48),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
