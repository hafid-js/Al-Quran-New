import 'package:alquran_new/utils/constants/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class PengaturanScreen extends StatelessWidget {
  const PengaturanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#132e3a").withAlpha(120),
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
                          Icons.menu_book_rounded,
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
                              color: HexColor.fromHex("#5a7b8a").withAlpha(30),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.menu_book_rounded,
                                size: 20,
                                color: HexColor.fromHex("#2dc8b9"),
                              ),
                              title: Text(
                                "Bunyi + Getar",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: HexColor.fromHex("#5a7b8a").withAlpha(30),
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
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: HexColor.fromHex("#5a7b8a").withAlpha(30),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.menu_book_rounded,
                                size: 20,
                                color: HexColor.fromHex("#2dc8b9"),
                              ),
                              title: Text(
                                "Getar Saja",
                                style: TextStyle(
                                  fontSize: 14,
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
                                Icons.menu_book_rounded,
                                size: 20,
                                color: HexColor.fromHex("#2dc8b9"),
                              ),
                              title: Text(
                                "Senyap",
                                style: TextStyle(
                                  fontSize: 14,
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
                              color: HexColor.fromHex("#5a7b8a").withAlpha(30),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.menu_book_rounded,
                                size: 20,
                                color: HexColor.fromHex("#2dc8b9"),
                              ),
                              title: Text(
                                "Suara Default",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: HexColor.fromHex("#5a7b8a").withAlpha(30),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.menu_book_rounded,
                                size: 20,
                                color: HexColor.fromHex("#2dc8b9"),
                              ),
                              title: Text(
                                "Suara Adzan",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
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
                          Icons.menu_book_rounded,
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
                              color: HexColor.fromHex("#5a7b8a").withAlpha(30),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.menu_book_rounded,
                                size: 20,
                                color: HexColor.fromHex("#2dc8b9"),
                              ),
                              title: Text(
                                "Imsak",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text("04:26"),
                              trailing: Container(
                        height: 36,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: HexColor.fromHex("#17404a"),
                        ),
                        child: Icon(
                          Icons.notifications,
                          size: 20,
                          color: HexColor.fromHex("#2dc8b9"),
                        ),
                      ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: HexColor.fromHex("#5a7b8a").withAlpha(30),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.menu_book_rounded,
                                size: 20,
                                color: HexColor.fromHex("#2dc8b9"),
                              ),
                              title: Text(
                                "Subuh",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text("04:26"),
                              trailing: Container(
                        height: 36,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: HexColor.fromHex("#17404a"),
                        ),
                        child: Icon(
                          Icons.notifications,
                          size: 20,
                          color: HexColor.fromHex("#2dc8b9"),
                        ),
                      ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: HexColor.fromHex("#5a7b8a").withAlpha(30),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.menu_book_rounded,
                                size: 20,
                                color: HexColor.fromHex("#2dc8b9"),
                              ),
                              title: Text(
                                "Dzuhur",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text("04:26"),
                              trailing: Container(
                        height: 36,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: HexColor.fromHex("#17404a"),
                        ),
                        child: Icon(
                          Icons.notifications,
                          size: 20,
                          color: HexColor.fromHex("#2dc8b9"),
                        ),
                      ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: HexColor.fromHex("#5a7b8a").withAlpha(30),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.menu_book_rounded,
                                size: 20,
                                color: HexColor.fromHex("#2dc8b9"),
                              ),
                              title: Text(
                                "Ashar",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text("04:26"),
                              trailing: Container(
                        height: 36,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: HexColor.fromHex("#17404a"),
                        ),
                        child: Icon(
                          Icons.notifications,
                          size: 20,
                          color: HexColor.fromHex("#2dc8b9"),
                        ),
                      ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: HexColor.fromHex("#5a7b8a").withAlpha(30),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.menu_book_rounded,
                                size: 20,
                                color: HexColor.fromHex("#2dc8b9"),
                              ),
                              title: Text(
                                "Maghrib",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text("04:26"),
                              trailing: Container(
                        height: 36,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: HexColor.fromHex("#17404a"),
                        ),
                        child: Icon(
                          Icons.notifications,
                          size: 20,
                          color: HexColor.fromHex("#2dc8b9"),
                        ),
                      ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: HexColor.fromHex("#5a7b8a").withAlpha(30),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.menu_book_rounded,
                                size: 20,
                                color: HexColor.fromHex("#2dc8b9"),
                              ),
                              title: Text(
                                "Isya",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text("04:26"),
                              trailing: Container(
                        height: 36,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: HexColor.fromHex("#17404a"),
                        ),
                        child: Icon(
                          Icons.notifications,
                          size: 20,
                          color: HexColor.fromHex("#2dc8b9"),
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
