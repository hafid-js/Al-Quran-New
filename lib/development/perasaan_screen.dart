import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/development/detail_perasaan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class PerasaanScreen extends StatelessWidget {
  const PerasaanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#F9F5EF"),
      appBar: AppBar(
        backgroundColor: HexColor.fromHex("#F9F5EF"),
        surfaceTintColor: HexColor.fromHex("#F9F5EF"),
        title:               Text("Perasaan", style: Theme.of(context).textTheme.titleLarge!.copyWith(color: HexColor.fromHex("#1E4355"), fontFamily: "Poppins", fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Text("Apa yang Anda rasakan saat ini?", style: Theme.of(context).textTheme.titleLarge!.copyWith(color: HexColor.fromHex("#1E4355")),),
                 SizedBox(height: 12),
              Text("Pilih perasaan Anda untuk menemukan doa yang tepat", style: Theme.of(context).textTheme.labelMedium!.copyWith(color: HexColor.fromHex("#1E4355")),textAlign: TextAlign.center,),
              SizedBox(height: 18),
              GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.3,
            ),
            itemBuilder: (context, index) {
              final item = _items[index];
              return GestureDetector(
                onTap: () => Get.to(
                  () => DetailPerasaanScreen(type: item.type),
                ),
                child: _buildPerasaanCard(item),
              );
            },
          ),
            ],
          )
        ),
      ),
    );
  }
}

class _PerasaanItem {
  final String title;
  final String type;
  final String icon;
  final Color containerColor;
  const _PerasaanItem({
    required this.title,
    required this.type,
    required this.icon,
    required this.containerColor,
  });
}

const List<_PerasaanItem> _items = [
  _PerasaanItem(
    title: "Marah",
    type: "marah",
    icon: "assets/svg_perasaan/marah.svg",
    containerColor: Color(0xFFF4B8C1),
  ),
  _PerasaanItem(
    title: "Cemas / Gelisah",
    type: "cemas_gelisah",
    icon: "assets/svg_perasaan/cemas.svg",
    containerColor: Color(0xFFB8D4F4),
  ),
  _PerasaanItem(
    title: "Bosan",
    type: "bosan",
    icon: "assets/svg_perasaan/bosan.svg",
    containerColor: Color(0xFFD4D4D4),
  ),
  _PerasaanItem(
    title: "Percaya Diri",
    type: "percaya_diri",
    icon: "assets/svg_perasaan/percaya_diri.svg",
    containerColor: Color(0xFFB8E8D4),
  ),
  _PerasaanItem(
    title: "Bingung",
    type: "bingung",
    icon: "assets/svg_perasaan/bingung.svg",
    containerColor: Color(0xFFB8D4F4),
  ),
  _PerasaanItem(
    title: "Puas/Tenang",
    type: "puas_tenang",
    icon: "assets/svg_perasaan/puas_tenang.svg",
    containerColor: Color(0xFFF4C8E8),
  ),
  _PerasaanItem(
    title: "Depresi/Sedih Mendalam",
    type: "depresi_sedih_mendalam",
    icon: "assets/svg_perasaan/depresi.svg",
    containerColor: Color(0xFFC8B4D4),
  ),
  _PerasaanItem(
    title: "Ragu-Ragu",
    type: "ragu_ragu",
    icon: "assets/svg_perasaan/ragu_ragu.svg",
    containerColor: Color(0xFFD4B8E8),
  ),
  _PerasaanItem(
    title: "Bersyukur",
    type: "bersyukur",
    icon: "assets/svg_perasaan/bersyukur.svg",
    containerColor: Color(0xFFB8E8C8),
  ),
  _PerasaanItem(
    title: "Serakah/Tamak",
    type: "serakah_tamak",
    icon: "assets/svg_perasaan/serakah.svg",
    containerColor: Color(0xFFE8D4B8),
  ),
];

Widget _buildPerasaanCard(_PerasaanItem item) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: item.containerColor,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          width: 45,
          height: 45,
          item.icon,
          colorFilter: ColorFilter.mode(
            HexColor.fromHex("#256980"),
            BlendMode.srcIn,
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: Text(
            item.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: HexColor.fromHex("#1E4355")
            ),
          ),
        ),
      ],
    ),
  );
}
