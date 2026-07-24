import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/development/detail_hizb_screen.dart';
import 'package:alquran_new/development/detail_juz_screen.dart';
import 'package:alquran_new/development/detail_surah_screen.dart';
import 'package:alquran_new/features/alquran/controllers/surah_controller.dart';
import 'package:alquran_new/features/alquran/domain/entities/surah.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';


class HizbData {
  final int number;
  final int startPage;
  final String startSurah;
  final int startAyah;
  final String endSurah;
  final int endAyah;

  const HizbData({
    required this.number,
    required this.startPage,
    required this.startSurah,
    required this.startAyah,
    required this.endSurah,
    required this.endAyah,
  });
}

class JuzData {
  final int number;
  final int startPage;
  final String startSurah;
  final int startAyah;
  final String endSurah;
  final int endAyah;

  const JuzData({
    required this.number,
    required this.startPage,
    required this.startSurah,
    required this.startAyah,
    required this.endSurah,
    required this.endAyah,
  });
}

final List<HizbData> hizbList = [
  HizbData(number: 1, startPage: 1, startSurah: "Al-Fatihah", startAyah: 1, endSurah: "Al-Baqarah", endAyah: 70),
  HizbData(number: 2, startPage: 12, startSurah: "Al-Baqarah", startAyah: 71, endSurah: "Al-Baqarah", endAyah: 141),
  HizbData(number: 3, startPage: 22, startSurah: "Al-Baqarah", startAyah: 142, endSurah: "Al-Baqarah", endAyah: 197),
  HizbData(number: 4, startPage: 32, startSurah: "Al-Baqarah", startAyah: 198, endSurah: "Al-Baqarah", endAyah: 252),
  HizbData(number: 5, startPage: 42, startSurah: "Al-Baqarah", startAyah: 253, endSurah: "Ali 'Imran", endAyah: 30),
  HizbData(number: 6, startPage: 52, startSurah: "Ali 'Imran", startAyah: 31, endSurah: "Ali 'Imran", endAyah: 92),
  HizbData(number: 7, startPage: 62, startSurah: "Ali 'Imran", startAyah: 93, endSurah: "An-Nisa", endAyah: 11),
  HizbData(number: 8, startPage: 72, startSurah: "An-Nisa", startAyah: 12, endSurah: "An-Nisa", endAyah: 23),
  HizbData(number: 9, startPage: 82, startSurah: "An-Nisa", startAyah: 24, endSurah: "An-Nisa", endAyah: 85),
  HizbData(number: 10, startPage: 92, startSurah: "An-Nisa", startAyah: 86, endSurah: "An-Nisa", endAyah: 147),
  HizbData(number: 11, startPage: 102, startSurah: "An-Nisa", startAyah: 148, endSurah: "Al-Ma'idah", endAyah: 40),
  HizbData(number: 12, startPage: 112, startSurah: "Al-Ma'idah", startAyah: 41, endSurah: "Al-Ma'idah", endAyah: 81),
  HizbData(number: 13, startPage: 121, startSurah: "Al-Ma'idah", startAyah: 82, endSurah: "Al-An'am", endAyah: 55),
  HizbData(number: 14, startPage: 131, startSurah: "Al-An'am", startAyah: 56, endSurah: "Al-An'am", endAyah: 110),
  HizbData(number: 15, startPage: 141, startSurah: "Al-An'am", startAyah: 111, endSurah: "Al-A'raf", endAyah: 43),
  HizbData(number: 16, startPage: 152, startSurah: "Al-A'raf", startAyah: 44, endSurah: "Al-A'raf", endAyah: 87),
  HizbData(number: 17, startPage: 162, startSurah: "Al-A'raf", startAyah: 88, endSurah: "Al-A'raf", endAyah: 151),
  HizbData(number: 18, startPage: 172, startSurah: "Al-A'raf", startAyah: 152, endSurah: "Al-Anfal", endAyah: 40),
  HizbData(number: 19, startPage: 181, startSurah: "Al-Anfal", startAyah: 41, endSurah: "At-Tawbah", endAyah: 40),
  HizbData(number: 20, startPage: 192, startSurah: "At-Tawbah", startAyah: 41, endSurah: "At-Tawbah", endAyah: 92),
  HizbData(number: 21, startPage: 201, startSurah: "At-Tawbah", startAyah: 93, endSurah: "Yunus", endAyah: 26),
  HizbData(number: 22, startPage: 212, startSurah: "Yunus", startAyah: 27, endSurah: "Hud", endAyah: 5),
  HizbData(number: 23, startPage: 222, startSurah: "Hud", startAyah: 6, endSurah: "Yusuf", endAyah: 52),
  HizbData(number: 24, startPage: 232, startSurah: "Yusuf", startAyah: 53, endSurah: "Ibrahim", endAyah: 52),
  HizbData(number: 25, startPage: 242, startSurah: "Al-Hijr", startAyah: 1, endSurah: "An-Nahl", endAyah: 64),
  HizbData(number: 26, startPage: 253, startSurah: "An-Nahl", startAyah: 65, endSurah: "An-Nahl", endAyah: 128),
  HizbData(number: 27, startPage: 262, startSurah: "Al-Isra'", startAyah: 1, endSurah: "Al-Kahf", endAyah: 37),
  HizbData(number: 28, startPage: 273, startSurah: "Al-Kahf", startAyah: 38, endSurah: "Al-Kahf", endAyah: 74),
  HizbData(number: 29, startPage: 282, startSurah: "Al-Kahf", startAyah: 75, endSurah: "Taha", endAyah: 67),
  HizbData(number: 30, startPage: 293, startSurah: "Taha", startAyah: 68, endSurah: "Taha", endAyah: 135),
  HizbData(number: 31, startPage: 302, startSurah: "Al-Anbiya'", startAyah: 1, endSurah: "Al-Hajj", endAyah: 38),
  HizbData(number: 32, startPage: 312, startSurah: "Al-Hajj", startAyah: 39, endSurah: "Al-Hajj", endAyah: 78),
  HizbData(number: 33, startPage: 322, startSurah: "Al-Mu'minun", startAyah: 1, endSurah: "An-Nur", endAyah: 20),
  HizbData(number: 34, startPage: 332, startSurah: "An-Nur", startAyah: 21, endSurah: "An-Nur", endAyah: 55),
  HizbData(number: 35, startPage: 342, startSurah: "An-Nur", startAyah: 56, endSurah: "Al-Furqan", endAyah: 20),
  HizbData(number: 36, startPage: 352, startSurah: "Al-Furqan", startAyah: 21, endSurah: "An-Naml", endAyah: 55),
  HizbData(number: 37, startPage: 362, startSurah: "An-Naml", startAyah: 56, endSurah: "Al-Qasas", endAyah: 43),
  HizbData(number: 38, startPage: 372, startSurah: "Al-Qasas", startAyah: 44, endSurah: "Al-'Ankabut", endAyah: 45),
  HizbData(number: 39, startPage: 382, startSurah: "Al-'Ankabut", startAyah: 46, endSurah: "Luqman", endAyah: 22),
  HizbData(number: 40, startPage: 393, startSurah: "Luqman", startAyah: 23, endSurah: "Al-Ahzab", endAyah: 30),
  HizbData(number: 41, startPage: 402, startSurah: "Al-Ahzab", startAyah: 31, endSurah: "Saba'", endAyah: 23),
  HizbData(number: 42, startPage: 413, startSurah: "Saba'", startAyah: 24, endSurah: "Az-Zumar", endAyah: 31),
  HizbData(number: 43, startPage: 422, startSurah: "Az-Zumar", startAyah: 32, endSurah: "Fussilat", endAyah: 23),
  HizbData(number: 44, startPage: 434, startSurah: "Fussilat", startAyah: 24, endSurah: "Fussilat", endAyah: 46),
  HizbData(number: 45, startPage: 444, startSurah: "Ash-Shura", startAyah: 1, endSurah: "Al-Jathiyah", endAyah: 37),
  HizbData(number: 46, startPage: 455, startSurah: "Al-Ahqaf", startAyah: 1, endSurah: "Al-Ahqaf", endAyah: 34),
  HizbData(number: 47, startPage: 465, startSurah: "Al-Ahqaf", startAyah: 35, endSurah: "Adh-Dhariyat", endAyah: 30),
  HizbData(number: 48, startPage: 476, startSurah: "Adh-Dhariyat", startAyah: 31, endSurah: "Al-Hadid", endAyah: 29),
  HizbData(number: 49, startPage: 486, startSurah: "Al-Mujadalah", startAyah: 1, endSurah: "Al-Mumtahanah", endAyah: 13),
  HizbData(number: 50, startPage: 496, startSurah: "Al-Mumtahanah", startAyah: 14, endSurah: "At-Tahrim", endAyah: 8),
  HizbData(number: 51, startPage: 506, startSurah: "Al-Mulk", startAyah: 1, endSurah: "Al-Qalam", endAyah: 32),
  HizbData(number: 52, startPage: 517, startSurah: "Al-Qalam", startAyah: 33, endSurah: "Al-Haqqah", endAyah: 20),
  HizbData(number: 53, startPage: 527, startSurah: "Al-Ma'arij", startAyah: 1, endSurah: "Al-Ma'arij", endAyah: 44),
  HizbData(number: 54, startPage: 537, startSurah: "Nuh", startAyah: 1, endSurah: "Al-Jinn", endAyah: 28),
  HizbData(number: 55, startPage: 548, startSurah: "Al-Jinn", startAyah: 29, endSurah: "Al-Muzzammil", endAyah: 20),
  HizbData(number: 56, startPage: 558, startSurah: "Al-Muddatstsir", startAyah: 1, endSurah: "Al-Qiyamah", endAyah: 40),
  HizbData(number: 57, startPage: 568, startSurah: "Al-Insan", startAyah: 1, endSurah: "Al-Mursalin", endAyah: 50),
  HizbData(number: 58, startPage: 578, startSurah: "An-Naba'", startAyah: 1, endSurah: "An-Nazi'at", endAyah: 46),
  HizbData(number: 59, startPage: 589, startSurah: "Ad-Dukhan", startAyah: 1, endSurah: "At-Tin", endAyah: 8),
  HizbData(number: 60, startPage: 594, startSurah: "Al-Alaq", startAyah: 1, endSurah: "An-Nas", endAyah: 6),
];

final List<JuzData> juzList = [
  JuzData(number: 1, startPage: 1, startSurah: "Al-Fatihah", startAyah: 1, endSurah: "Al-Baqarah", endAyah: 141),
  JuzData(number: 2, startPage: 22, startSurah: "Al-Baqarah", startAyah: 142, endSurah: "Al-Baqarah", endAyah: 252),
  JuzData(number: 3, startPage: 42, startSurah: "Al-Baqarah", startAyah: 253, endSurah: "Ali 'Imran", endAyah: 92),
  JuzData(number: 4, startPage: 62, startSurah: "Ali 'Imran", startAyah: 93, endSurah: "An-Nisa", endAyah: 23),
  JuzData(number: 5, startPage: 82, startSurah: "An-Nisa", startAyah: 24, endSurah: "An-Nisa", endAyah: 147),
  JuzData(number: 6, startPage: 102, startSurah: "An-Nisa", startAyah: 148, endSurah: "Al-Ma'idah", endAyah: 81),
  JuzData(number: 7, startPage: 121, startSurah: "Al-Ma'idah", startAyah: 82, endSurah: "Al-An'am", endAyah: 110),
  JuzData(number: 8, startPage: 141, startSurah: "Al-An'am", startAyah: 111, endSurah: "Al-A'raf", endAyah: 87),
  JuzData(number: 9, startPage: 162, startSurah: "Al-A'raf", startAyah: 88, endSurah: "Al-Anfal", endAyah: 40),
  JuzData(number: 10, startPage: 181, startSurah: "Al-Anfal", startAyah: 41, endSurah: "At-Tawbah", endAyah: 92),
  JuzData(number: 11, startPage: 201, startSurah: "At-Tawbah", startAyah: 93, endSurah: "Hud", endAyah: 5),
  JuzData(number: 12, startPage: 222, startSurah: "Hud", startAyah: 6, endSurah: "Yusuf", endAyah: 52),
  JuzData(number: 13, startPage: 242, startSurah: "Yusuf", startAyah: 53, endSurah: "Ibrahim", endAyah: 52),
  JuzData(number: 14, startPage: 262, startSurah: "Al-Hijr", startAyah: 1, endSurah: "An-Nahl", endAyah: 128),
  JuzData(number: 15, startPage: 282, startSurah: "Al-Isra'", startAyah: 1, endSurah: "Al-Kahf", endAyah: 74),
  JuzData(number: 16, startPage: 302, startSurah: "Al-Kahf", startAyah: 75, endSurah: "Taha", endAyah: 135),
  JuzData(number: 17, startPage: 322, startSurah: "Al-Anbiya'", startAyah: 1, endSurah: "Al-Hajj", endAyah: 78),
  JuzData(number: 18, startPage: 342, startSurah: "Al-Mu'minun", startAyah: 1, endSurah: "Al-Furqan", endAyah: 20),
  JuzData(number: 19, startPage: 362, startSurah: "Al-Furqan", startAyah: 21, endSurah: "An-Nur", endAyah: 55),
  JuzData(number: 20, startPage: 382, startSurah: "An-Nur", startAyah: 56, endSurah: "Al-'Ankabut", endAyah: 45),
  JuzData(number: 21, startPage: 402, startSurah: "Al-'Ankabut", startAyah: 46, endSurah: "Al-Ahzab", endAyah: 30),
  JuzData(number: 22, startPage: 422, startSurah: "Al-Ahzab", startAyah: 31, endSurah: "Az-Zumar", endAyah: 31),
  JuzData(number: 23, startPage: 442, startSurah: "Az-Zumar", startAyah: 32, endSurah: "Fussilat", endAyah: 46),
  JuzData(number: 24, startPage: 462, startSurah: "Fussilat", startAyah: 47, endSurah: "Al-Jathiyah", endAyah: 37),
  JuzData(number: 25, startPage: 482, startSurah: "Al-Ahqaf", startAyah: 1, endSurah: "Adh-Dhariyat", endAyah: 30),
  JuzData(number: 26, startPage: 502, startSurah: "Adh-Dhariyat", startAyah: 31, endSurah: "Al-Hadid", endAyah: 29),
  JuzData(number: 27, startPage: 522, startSurah: "Al-Mujadalah", startAyah: 1, endSurah: "At-Tahrim", endAyah: 8),
  JuzData(number: 28, startPage: 542, startSurah: "Al-Mulk", startAyah: 1, endSurah: "Al-Mursalat", endAyah: 50),
  JuzData(number: 29, startPage: 562, startSurah: "An-Naba'", startAyah: 1, endSurah: "Az-Zalzalah", endAyah: 8),
  JuzData(number: 30, startPage: 582, startSurah: "Al-'Adiyat", startAyah: 1, endSurah: "An-Nas", endAyah: 6),
];

class AlquranScreenNew extends StatefulWidget {
  const AlquranScreenNew({super.key});

  @override
  State<AlquranScreenNew> createState() => _AlquranScreenNewState();
}

class _AlquranScreenNewState extends State<AlquranScreenNew>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final SurahController controller = Get.put(SurahController(), permanent: true);

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Widget _buildSurahItem(Surah surah) {
    return GestureDetector(
      onTap: () => Get.to(
        () => DetailSurahScreen(),
        arguments: {"surah": surah.nomor, "ayat": null},
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: HexColor.fromHex("#DBB893").withAlpha(30),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            "${surah.nomor}",
                            style: TextStyle(
                              color: HexColor.fromHex("#1E4355"),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Image.asset(
                            "assets/icon/octagram.png",
                            height: 35,
                            width: 35,
                            color: HexColor.fromHex("#DBB893"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${surah.namaLatin} (${surah.arti})",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: HexColor.fromHex("#1E4355"),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${surah.tempatTurun.name} - ${surah.jumlahAyat} Ayat",
                            style: TextStyle(
                              color: HexColor.fromHex("#676767"),
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
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
                      Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHizbItem(HizbData hizb) {
    return GestureDetector(
      onTap: () => Get.to(
        () => DetailHizbScreen(),
        arguments: {"hizb": hizb.number},
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: HexColor.fromHex("#DBB893").withAlpha(30),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          "${hizb.number}",
                          style: TextStyle(
                            color: HexColor.fromHex("#151419"),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Image.asset(
                          "assets/icon/octagram.png",
                          height: 35,
                          width: 35,
                          color: HexColor.fromHex("#DBB893"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hizb ${hizb.number}",
                        style: TextStyle(
                          color: HexColor.fromHex("#151419"),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${hizb.startSurah}: ${hizb.startAyah} - ${hizb.endSurah}: ${hizb.endAyah}",
                        style: TextStyle(
                          color: HexColor.fromHex("#676767"),
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
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
    );
  }

  Widget _buildJuzItem(JuzData juz) {
    return GestureDetector(
      onTap: () => Get.to(
        () => DetailJuzScreen(),
        arguments: {"juz": juz.number},
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: HexColor.fromHex("#DBB893").withAlpha(30),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          "${juz.number}",
                          style: TextStyle(
                            color: HexColor.fromHex("#151419"),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Image.asset(
                          "assets/icon/octagram.png",
                          height: 35,
                          width: 35,
                          color: HexColor.fromHex("#DBB893"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Juz ${juz.number}",
                        style: TextStyle(
                          color: HexColor.fromHex("#151419"),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${juz.startSurah}: ${juz.startAyah} - ${juz.endSurah}: ${juz.endAyah}",
                        style: TextStyle(
                          color: HexColor.fromHex("#676767"),
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#F9F5EF"),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Quran",
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: Colors.black),
        ),
        actions: [Icon(Iconsax.search_normal_1, color: Colors.black)],
        actionsPadding: EdgeInsets.all(16),
        bottom: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          controller: tabController,
          indicatorColor: HexColor.fromHex("#256980"),
          labelColor: HexColor.fromHex("#256980"),
          unselectedLabelColor: Colors.black,
          indicatorWeight: 2.5,
          labelStyle: TextStyle(fontSize: 14),
          tabs: [
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [const Text("Surah")],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [const Text("Juz")],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [const Text("Hizb")],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          Obx(() {
            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8),
              itemCount: controller.filteredSurah.length,
              itemBuilder: (context, index) {
                return _buildSurahItem(controller.filteredSurah[index]);
              },
            );
          }),
          ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 8),
            itemCount: juzList.length,
            itemBuilder: (context, index) {
              return _buildJuzItem(juzList[index]);
            },
          ),
          ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 8),
            itemCount: hizbList.length,
            itemBuilder: (context, index) {
              return _buildHizbItem(hizbList[index]);
            },
          ),
        ],
      ),
    );
  }
}
