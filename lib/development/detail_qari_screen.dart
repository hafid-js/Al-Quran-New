import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/development/just_audio/detail_murrotal_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class DetailQariScreen extends StatelessWidget {
  const DetailQariScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor.fromHex("#256980"),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
              HexColor.fromHex("#256980").withAlpha(210),
              BlendMode.srcATop,
            ),
            fit: BoxFit.cover,
            image: AssetImage("assets/images/image.png"),
          ),
          color: HexColor.fromHex("#256980"),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  ColorFiltered(
                    colorFilter: const ColorFilter.matrix([
                      0.26,
                      0.72,
                      0.02,
                      0,
                      0,
                      0.26,
                      0.72,
                      0.02,
                      0,
                      0,
                      0.26,
                      0.72,
                      0.02,
                      0,
                      0,
                      0,
                      0,
                      0,
                      1,
                      0,
                    ]),
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(16),
                      child: Image.asset(
                        "assets/images/banners/Mishary-Rasyid-Al-Afasi.jpg",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Syekh Misyari bin Rasyid bin Gharib bin Muhammad bin Rasyid Al-Afasi Al-Muthairi adalah seorang qari hafiz dan imam berkebangsaan Kuwait. Ia belajar di Fakultas Qur'an Universitas Islam Madinah, yang mengkhususkan diri dalam sepuluh qira'at tafsir.",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.justify,
                    softWrap: true,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                children: [
                  Text(
                    "Pilihan Surat",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 12),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        visualDensity: const VisualDensity(vertical: -1),
                        contentPadding: EdgeInsets.only(right: 5),
                        leading: ColorFiltered(
                          colorFilter: const ColorFilter.matrix([
                            0.26,
                            0.72,
                            0.02,
                            0,
                            0,
                            0.26,
                            0.72,
                            0.02,
                            0,
                            0,
                            0.26,
                            0.72,
                            0.02,
                            0,
                            0,
                            0,
                            0,
                            0,
                            1,
                            0,
                          ]),
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(8),
                            child: Image.asset(
                              "assets/images/banners/Mishary-Rasyid-Al-Afasi.jpg",
                              width: 50,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(
                          "Al-Kahfi",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: HexColor.fromHex("#256980"),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text(
                          "Mishary Rasyid",
                          style: TextStyle(
                            color: HexColor.fromHex("#676767"),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: () => Get.to(() => DetailMurrotalScreen()),
                          child: Icon(
                            Iconsax.play_circle5,
                            color: HexColor.fromHex("#256980"),
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
