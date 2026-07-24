import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';

class PerasaanData {
  final String title;
  final String icon;
  final Color containerColor;

  const PerasaanData({
    required this.title,
    required this.icon,
    required this.containerColor,
  });
}

final List<PerasaanData> perasaanList = [
  PerasaanData(
    title: "Marah",
    icon: "assets/svg_perasaan/marah.svg",
    containerColor: HexColor.fromHex("#F4B8C1"),
  ),
  PerasaanData(
    title: "Cemas / Gelisah",
    icon: "assets/svg_perasaan/cemas.svg",
    containerColor: HexColor.fromHex("#B8D4F4"),
  ),
  PerasaanData(
    title: "Bosan",
    icon: "assets/svg_perasaan/bosan.svg",
    containerColor: HexColor.fromHex("#D4D4D4"),
  ),
  PerasaanData(
    title: "Percaya Diri",
    icon: "assets/svg_perasaan/percaya_diri.svg",
    containerColor: HexColor.fromHex("#B8E8D4"),
  ),
  PerasaanData(
    title: "Bingung",
    icon: "assets/svg_perasaan/bingung.svg",
    containerColor: HexColor.fromHex("#B8D4F4"),
  ),
  PerasaanData(
    title: "Puas/Tenang",
    icon: "assets/svg_perasaan/puas_tenang.svg",
    containerColor: HexColor.fromHex("#F4C8E8"),
  ),
  PerasaanData(
    title: "Depresi/Sedih Mendalam",
    icon: "assets/svg_perasaan/depresi.svg",
    containerColor: HexColor.fromHex("#C8B4D4"),
  ),
  PerasaanData(
    title: "Ragu-Ragu",
    icon: "assets/svg_perasaan/ragu_ragu.svg",
    containerColor: HexColor.fromHex("#D4B8E8"),
  ),
  PerasaanData(
    title: "Bersyukur",
    icon: "assets/svg_perasaan/bersyukur.svg",
    containerColor: HexColor.fromHex("#B8E8C8"),
  ),
  PerasaanData(
    title: "Serakah/Tamak",
    icon: "assets/svg_perasaan/serakah.svg",
    containerColor: HexColor.fromHex("#E8D4B8"),
  ),
];

class PerasaanScreen extends StatelessWidget {
  const PerasaanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#F9F5EF"),
      appBar: AppBar(
        backgroundColor: HexColor.fromHex("#F9F5EF"),
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: perasaanList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.3,
            ),
            itemBuilder: (context, index) {
              return _buildPerasaanCard(perasaanList[index]);
            },
          ),
        ),
      ),
    );
  }
}

Widget _buildPerasaanCard(PerasaanData perasaan) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: perasaan.containerColor,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          width: 45,
          height: 45,
          "${perasaan.icon}",
          colorFilter: ColorFilter.mode(
            HexColor.fromHex("#256980"),
            BlendMode.srcIn,
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: Text(
            perasaan.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: HexColor.fromHex("#1E4355")
            ),
          ),
        ),
      ],
    ),
  );
}
