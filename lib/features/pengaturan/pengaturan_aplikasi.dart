import 'package:alquran_new/utils/constants/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PengaturanAplikasiScreen extends StatelessWidget {
  const PengaturanAplikasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#132D3B").withAlpha(120),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 65,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_circle_left_rounded),
          color: Colors.white,
        ),
        titleSpacing: 5,
        title: Row(
          children: [
            Container(
              height: 36,
              width: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: HexColor.fromHex("#17404a"),
              ),
              child: Icon(
                Icons.settings,
                size: 20,
                color: HexColor.fromHex("#2dc8b9"),
              ),
            ),
            SizedBox(width: 10),
            Text(
              "Pengaturan",
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
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.headphones),
                SizedBox(width: 10),
                Text(
                  "Qari Default",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: HexColor.fromHex("#6F8390"),
                  ),
                ),
              ],
            ),
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
                        InkWell(
                          onTap: () {
                            // NotificationService().showNotification(
                            //   title: "Al-Barokah",
                            //   body: "Adzan Isya Berkumandang",
                            //   soundSource: "adzansubuh",
                            // );
                          },
                          child: Container(
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
                            trailing: Icon(
                              Icons.check_circle_rounded,
                              color: HexColor.fromHex("#2dc8b9"),
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
          ],
        ),
      ),
    );
  }
}
