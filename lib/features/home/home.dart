import 'package:alquran_new/features/alquran/alquran.dart';
import 'package:alquran_new/utils/constants/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#0c1d27"),
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: HexColor.fromHex("#0c1d27"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: HexColor.fromHex("#132e3a"),
                        ),
                        child: Icon(
                          Icons.location_on,
                          color: HexColor.fromHex("#2dc8b9"),
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        "Kota Jakarta",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: HexColor.fromHex("#132e3a"),
                    ),
                    child: Icon(
                      Icons.location_on,
                      size: 30,
                      color: HexColor.fromHex("#2dc8b9"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: 250,
                width: double.infinity,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      HexColor.fromHex("#228276"),
                      HexColor.fromHex("#27a399"),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: -30,
                      right: -25,
                      child: Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          color: HexColor.fromHex("#37b0a5"),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: -30,
                      left: -30,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: HexColor.fromHex("#259b8e"),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Assalamu'alaikum,",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 20),

                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: HexColor.fromHex("#45a399"),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              child: Text(
                                "Senin, 22 April 2026 - 4 Zulkaidah1447 H",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Imsak",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "04:27",
                                    style: TextStyle(
                                      color: HexColor.fromHex("#a5d9d4"),
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 80,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: HexColor.fromHex("#249085"),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "07:53:01",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Tersisa",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: HexColor.fromHex("#132e3a"),
                        ),
                        child: Icon(
                          Icons.access_time_filled_outlined,
                          color: HexColor.fromHex("#2dc8b9"),
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        "Jadwal Sholat",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: HexColor.fromHex("#132e3a"),
                    ),
                    child: Icon(
                      Icons.notifications,
                      color: HexColor.fromHex("#2dc8b9"),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              Container(
                height: 250,
                width: double.infinity,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: HexColor.fromHex("#132e3a"),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.bedtime_rounded,
                                color: HexColor.fromHex("#5a7b8a"),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Imsak",
                                style: TextStyle(
                                  color: HexColor.fromHex("#5a7b8a"),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "04:27",
                                style: TextStyle(
                                  color: HexColor.fromHex("#5a7b8a"),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.bedtime_rounded,
                                color: HexColor.fromHex("#5a7b8a"),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Subuh",
                                style: TextStyle(
                                  color: HexColor.fromHex("#5a7b8a"),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "04:37",
                                style: TextStyle(
                                  color: HexColor.fromHex("#5a7b8a"),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.sunny,
                                color: HexColor.fromHex("#5a7b8a"),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Dzuhur",
                                style: TextStyle(
                                  color: HexColor.fromHex("#5a7b8a"),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "11:55",
                                style: TextStyle(
                                  color: HexColor.fromHex("#5a7b8a"),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(
                        color: HexColor.fromHex("#5a7b8a"),
                        thickness: 0.1,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.sunny_snowing,
                                color: HexColor.fromHex("#5a7b8a"),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Ashar",
                                style: TextStyle(
                                  color: HexColor.fromHex("#5a7b8a"),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "15:14",
                                style: TextStyle(
                                  color: HexColor.fromHex("#5a7b8a"),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.bedtime_rounded,
                                color: HexColor.fromHex("#5a7b8a"),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Maghrib",
                                style: TextStyle(
                                  color: HexColor.fromHex("#5a7b8a"),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "04:27",
                                style: TextStyle(
                                  color: HexColor.fromHex("#5a7b8a"),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.bedtime_rounded,
                                color: HexColor.fromHex("#5a7b8a"),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Isya",
                                style: TextStyle(
                                  color: HexColor.fromHex("#5a7b8a"),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "04:27",
                                style: TextStyle(
                                  color: HexColor.fromHex("#5a7b8a"),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
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
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: HexColor.fromHex("#132e3a"),
                        ),
                        child: Icon(
                          Icons.grid_view_rounded,
                          color: HexColor.fromHex("#2dc8b9"),
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        "Menu",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 40,
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: HexColor.fromHex("#132e3a"),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Lihat Semua",
                          style: TextStyle(
                            color: HexColor.fromHex("#2f9993"),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.arrow_circle_down_rounded,
                          size: 20,
                          color: HexColor.fromHex("#2dc8b9"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Get.to(() => AlQuranScreen()),
                        child: Container(
                          width: 115,
                          height: 120,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: HexColor.fromHex("#132e3a"),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 55,
                                width: 55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: HexColor.fromHex("#17404a"),
                                ),
                                child: Icon(
                                  Icons.menu_book_rounded,
                                  size: 30,
                                  color: HexColor.fromHex("#2dc8b9"),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Quran",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: HexColor.fromHex("#5a7b8a"),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Container(
                        width: 115,
                        height: 120,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: HexColor.fromHex("#132e3a"),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: HexColor.fromHex("#17404a"),
                              ),
                              child: Icon(
                                Icons.feed_outlined,
                                size: 30,
                                color: HexColor.fromHex("#2dc8b9"),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Doa",
                              style: TextStyle(
                                fontSize: 13,
                                color: HexColor.fromHex("#5a7b8a"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 115,
                        height: 120,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: HexColor.fromHex("#132e3a"),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: HexColor.fromHex("#17404a"),
                              ),
                              child: Icon(
                                Icons.my_location_rounded,
                                size: 30,
                                color: HexColor.fromHex("#2dc8b9"),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Kiblat",
                              style: TextStyle(
                                fontSize: 13,
                                color: HexColor.fromHex("#5a7b8a"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 115,
                        height: 120,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: HexColor.fromHex("#132e3a"),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: HexColor.fromHex("#17404a"),
                              ),
                              child: Icon(
                                Icons.repeat_rounded,
                                size: 30,
                                color: HexColor.fromHex("#2dc8b9"),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Dzikir",
                              style: TextStyle(
                                fontSize: 13,
                                color: HexColor.fromHex("#5a7b8a"),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: 115,
                        height: 120,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: HexColor.fromHex("#132e3a"),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: HexColor.fromHex("#17404a"),
                              ),
                              child: Icon(
                                Icons.route_rounded,
                                size: 30,
                                color: HexColor.fromHex("#2dc8b9"),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Masjid Terdekat",
                              style: TextStyle(
                                fontSize: 13,
                                color: HexColor.fromHex("#5a7b8a"),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: 115,
                        height: 120,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: HexColor.fromHex("#132e3a"),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: HexColor.fromHex("#17404a"),
                              ),
                              child: Icon(
                                Icons.headset_rounded,
                                size: 30,
                                color: HexColor.fromHex("#2dc8b9"),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Pemutar Audio",
                              style: TextStyle(
                                color: HexColor.fromHex("#5a7b8a"),
                              ),
                            ),
                          ],
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
}
