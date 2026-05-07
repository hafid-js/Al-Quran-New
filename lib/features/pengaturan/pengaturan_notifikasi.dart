import 'package:alquran_new/utils/constants/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class PengaturanNotifikasiScreen extends StatelessWidget {
  const PengaturanNotifikasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#132D3B").withAlpha(120),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_circle_left_rounded),
          color: Colors.white,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 36,
              width: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: HexColor.fromHex("#17404a"),
              ),
              child: Icon(
                Icons.menu_book_rounded,
                size: 20,
                color: HexColor.fromHex("#2dc8b9"),
              ),
            ),
            SizedBox(width: 10),
            Text(
              "Pengaturan Notifikasi",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                decoration: BoxDecoration(
                  color: HexColor.fromHex("#132e3a"),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Container(
                        height: 36,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: HexColor.fromHex("#17404a"),
                        ),
                        child: Icon(
                          Icons.notification_important_rounded,
                          size: 20,
                          color: HexColor.fromHex("#2dc8b9"),
                        ),
                      ),
                      title: Text(
                        "Jenis Notifikasi",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: HexColor.fromHex("#1A3A4A"),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.notifications_active_rounded,
                                size: 20,
                                color: HexColor.fromHex("#2dc8b9"),
                              ),
                              title: Text(
                                "Bunyi + Getar",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: HexColor.fromHex("#1A3A4A"),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.menu_book_rounded,
                                size: 20,
                                color: HexColor.fromHex("#2dc8b9"),
                              ),
                              title: Text(
                                "Bunyi Saja",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: HexColor.fromHex("#1A3A4A"),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.notification_important_rounded,
                                size: 20,
                                color: HexColor.fromHex("#2dc8b9"),
                              ),
                              title: Text(
                                "Getar Saja",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                color: HexColor.fromHex("#2cc4b6").withAlpha(20),
                borderRadius: BorderRadius.circular(16),
                border: BoxBorder.all(
                  color: HexColor.fromHex("#2cc4b6"),
                  width: 0.5,
                ),
              ),
                            child: ListTile(
                              leading: Icon(
                                Icons.sensors_off_rounded,
                                size: 20,
                                color: HexColor.fromHex("#2dc8b9"),
                              ),
                              title: Text(
                                "Senyap",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              trailing: Icon(Icons.check_circle_rounded, color: HexColor.fromHex("#2dc8b9"),),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                decoration: BoxDecoration(
                  color: HexColor.fromHex("#132D3B"),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Container(
                        height: 36,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: HexColor.fromHex("#17404a"),
                        ),
                        child: Icon(
                          Icons.menu_book_rounded,
                          size: 20,
                          color: HexColor.fromHex("#2dc8b9"),
                        ),
                      ),
                      title: Text(
                        "Bunyi Notifikasi",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: HexColor.fromHex("#163241"),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.notifications,
                                size: 24,
                               color: HexColor.fromHex("#2F4C5B"),
                              ),
                              title: Text(
                                "Suara Default",
                                style: TextStyle(
                                 fontSize: 16,
                                  color: HexColor.fromHex("#61737C"),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: HexColor.fromHex("#163241"),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.mosque_rounded ,
                                size: 20,
                                color: HexColor.fromHex("#2F4C5B"),
                              ),
                              title: Text(
                                "Suara Adzan",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: HexColor.fromHex("#61737C"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),

              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                decoration: BoxDecoration(
                  color: HexColor.fromHex("#132e3a"),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Container(
                        height: 36,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: HexColor.fromHex("#17404a"),
                        ),
                        child: Icon(
                          Icons.access_time_filled_outlined,
                          size: 20,
                          color: HexColor.fromHex("#2dc8b9"),
                        ),
                      ),
                      title: Text(
                        "Waktu Notifikasi",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: HexColor.fromHex("#1A3A4A"),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.wb_twilight_rounded,
                                size: 24,
                                color: HexColor.fromHex("#48626E"),
                              ),
                              title: Text(
                                "Ashar",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              subtitle: Text("04:26", style: TextStyle(color: HexColor.fromHex("#5A7A8A")),),
                              trailing: Icon(
                          Icons.notifications,
                          size: 24,
                          color: HexColor.fromHex("#48626E"),
                        ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              // color: HexColor.fromHex("1A3A4A"),
                              color: HexColor.fromHex("#153945"),
                              borderRadius: BorderRadius.circular(16),
                              border: BoxBorder.all(color: HexColor.fromHex("#1C6367"))
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.bedtime_rounded,
                                size: 24,
                                color: HexColor.fromHex("#2EC4B6"),
                              ),
                              title: Text(
                                "Maghrib",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: HexColor.fromHex("#2EC4B6"),
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              subtitle: Text("04:26", style: TextStyle(color: HexColor.fromHex("#5A7A8A")),),
                              trailing: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: HexColor.fromHex("#2EC4B6"),
                        ),
                        child: Icon(
                          Icons.notifications,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                            ),
                          ),
                          
                          SizedBox(height: 10),
                          
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
