import 'package:alquran_new/utils/constants/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class DetailEventScreen extends StatelessWidget {
  const DetailEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: const Text(
          "Event Detail",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset("assets/icons/share.png", height: 35, width: 35),
            onPressed: () {},
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Image.asset(
                "assets/images/events/event-5.jpg",
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 6),
            SizedBox(
              width: 130,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor.fromHex("F67619").withAlpha(50),
                  foregroundColor: HexColor.fromHex("F67619"),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "Lihat Laman Resmi",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Jalan Sehat Dan Baksos Karang Taruna Desa Gunung Condong",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: 4),

                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      style: TextStyle(fontSize: 12, color: Colors.black),
                      children: [
                        TextSpan(text: "Diselenggarakan oleh "),
                        TextSpan(
                          text: "Kabupaten Purworejo",
                          style: TextStyle(color: HexColor.fromHex("F67619")),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 14),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/date.png",
                        height: 30,
                        width: 30,
                      ),
                      SizedBox(width: 6),
                      Text(
                        "27 Februari 2026",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/location.png",
                        height: 30,
                        width: 30,
                      ),
                      SizedBox(width: 6),
                     Expanded(child:  Text(
                        "Gedung Kesenian Pendopo",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),)
                    ],
                  ),

                  SizedBox(height: 14),
                  Text(
                    "DESKRIPSI",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "Dalam rangka memperingati hari pahlawan. Karang taruna desa Gunungcondong Kecamatan Bruno. Mengadakan baksos sembako murah bagi keluarga miskin di desa Ngunut dan jalan sehat dengan hadiah undian seekor kambing, kompor gas, HP, kipas angin dan masih banyak lainnya.",
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
