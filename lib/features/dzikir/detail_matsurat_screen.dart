import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/features/dzikir/widgets/dzikir_card.dart';
import 'package:alquran_new/features/pengaturan/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

class DetailMatsuratScreen extends StatelessWidget {
  const DetailMatsuratScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Column(
      //     children: [
      //       Text("Dzikir Pagi Sugro", style: Theme.of(context).textTheme.titleMedium),
      //       Text("Gulir untuk membaca seluruh dzikir", style: TextStyle(color: Colors.white, fontSize: 11),)
      //     ],
      //   ),
      //   actions: [
      //     Icon(Icons.settings)
      //   ],
      //   actionsPadding: EdgeInsets.only(right: 16),
      // ),
      body: SingleChildScrollView(
        child: Padding(
        padding: EdgeInsets.only(right: 16, left: 16, bottom: 16, top: 80),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 18),
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
                  Icon(Icons.settings),
                ],
              ),
            ),
            SizedBox(height: 10),
            DzikirCard(
              dibaca: 3,
              title: "Ta'awudz",
              hitung: 0,
              jumlah: 1,
              arab: "أَعُوْذُ بِاللهِ مِنَ الشَّيْطَانِ الرَّجِيْمِ",
              latin: "A'uudzu billaahi minasy-syaitoonir rojiim",
              arti:
                  "Aku berlindung kepada Allah Yang Maha Mendengar lagi Maha Mengetahui dari godaan setan yang terkutuk.",
            ),
            SizedBox(height: 10),
            DzikirCard(
              dibaca: 3,
              title: "Ta'awudz",
              hitung: 0,
              jumlah: 1,
              arab: "أَعُوْذُ بِاللهِ مِنَ الشَّيْطَانِ الرَّجِيْمِ",
              latin: "A'uudzu billaahi minasy-syaitoonir rojiim",
              arti:
                  "Aku berlindung kepada Allah Yang Maha Mendengar lagi Maha Mengetahui dari godaan setan yang terkutuk.",
            ),
            SizedBox(height: 10),
            DzikirCard(
              dibaca: 3,
              title: "Ta'awudz",
              hitung: 0,
              jumlah: 1,
              arab: "أَعُوْذُ بِاللهِ مِنَ الشَّيْطَانِ الرَّجِيْمِ",
              latin: "A'uudzu billaahi minasy-syaitoonir rojiim",
              arti:
                  "Aku berlindung kepada Allah Yang Maha Mendengar lagi Maha Mengetahui dari godaan setan yang terkutuk.",
            ),
          ],
        ),
      ),
      )
    );
  }
}
