import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax/iconsax.dart';

class PengaturanNotifikasi extends StatefulWidget {
  const PengaturanNotifikasi({super.key});

  @override
  State<PengaturanNotifikasi> createState() => _PengaturanNotifikasiState();
}

class _PengaturanNotifikasiState extends State<PengaturanNotifikasi> {
  bool light = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#F9F5EF"),
      appBar: AppBar(
        surfaceTintColor: HexColor.fromHex("#F9F5EF"),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Pengaturan Notifikasi",
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Waktu Notifikasi",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black.withAlpha(10),
                            child: Icon(Iconsax.moon, color: Colors.black),
                          ),
                          SizedBox(width: 18),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Imsak",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "04:26",
                                style: TextStyle(
                                  color: HexColor.fromHex("#D39D52"),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Transform.scale(
                        scale: 0.7,
                        child: Switch(
                          value: light,
                          thumbColor: WidgetStatePropertyAll(Colors.white),
                          trackColor: WidgetStatePropertyAll(
                            HexColor.fromHex("#256980"),
                          ),
                          activeThumbColor: HexColor.fromHex("#256980"),
                          inactiveThumbColor: HexColor.fromHex(
                            "#256980",
                          ).withAlpha(20),
                          onChanged: (bool value) {
                            setState(() {
                              light = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Divider(color: const Color.fromARGB(17, 0, 0, 0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black.withAlpha(10),
                            child: Icon(Iconsax.moon, color: Colors.black),
                          ),
                          SizedBox(width: 18),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Subuh",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "04:26",
                                style: TextStyle(
                                  color: HexColor.fromHex("#D39D52"),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Transform.scale(
                        scale: 0.7,
                        child: Switch(
                          value: light,
                          thumbColor: WidgetStatePropertyAll(Colors.white),
                          trackColor: WidgetStatePropertyAll(
                            HexColor.fromHex("#256980"),
                          ),
                          activeThumbColor: HexColor.fromHex("#256980"),
                          inactiveThumbColor: HexColor.fromHex(
                            "#256980",
                          ).withAlpha(20),
                          onChanged: (bool value) {
                            setState(() {
                              light = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Divider(color: const Color.fromARGB(17, 0, 0, 0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black.withAlpha(10),
                            child: Icon(Iconsax.sun_1, color: Colors.black),
                          ),
                          SizedBox(width: 18),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dzuhur",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "04:26",
                                style: TextStyle(
                                  color: HexColor.fromHex("#D39D52"),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Transform.scale(
                        scale: 0.7,
                        child: Switch(
                          value: light,
                          thumbColor: WidgetStatePropertyAll(Colors.white),
                          trackColor: WidgetStatePropertyAll(
                            HexColor.fromHex("#256980"),
                          ),
                          activeThumbColor: HexColor.fromHex("#256980"),
                          inactiveThumbColor: HexColor.fromHex(
                            "#256980",
                          ).withAlpha(20),
                          onChanged: (bool value) {
                            setState(() {
                              light = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Divider(color: const Color.fromARGB(17, 0, 0, 0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black.withAlpha(10),
                            child: Icon(
                              Icons.sunny_snowing,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 18),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ashar",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "04:26",
                                style: TextStyle(
                                  color: HexColor.fromHex("#D39D52"),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Transform.scale(
                        scale: 0.7,
                        child: Switch(
                          value: light,
                          thumbColor: WidgetStatePropertyAll(Colors.white),
                          trackColor: WidgetStatePropertyAll(
                            HexColor.fromHex("#256980"),
                          ),
                          activeThumbColor: HexColor.fromHex("#256980"),
                          inactiveThumbColor: HexColor.fromHex(
                            "#256980",
                          ).withAlpha(20),
                          onChanged: (bool value) {
                            setState(() {
                              light = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Divider(color: const Color.fromARGB(17, 0, 0, 0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black.withAlpha(10),
                            child: Icon(Iconsax.sun_fog, color: Colors.black),
                          ),
                          SizedBox(width: 18),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Maghrib",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "04:26",
                                style: TextStyle(
                                  color: HexColor.fromHex("#D39D52"),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Transform.scale(
                        scale: 0.7,
                        child: Switch(
                          value: light,
                          thumbColor: WidgetStatePropertyAll(Colors.white),
                          trackColor: WidgetStatePropertyAll(
                            HexColor.fromHex("#256980"),
                          ),
                          activeThumbColor: HexColor.fromHex("#256980"),
                          inactiveThumbColor: HexColor.fromHex(
                            "#256980",
                          ).withAlpha(20),
                          onChanged: (bool value) {
                            setState(() {
                              light = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Divider(color: const Color.fromARGB(17, 0, 0, 0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black.withAlpha(10),
                            child: Icon(Iconsax.moon, color: Colors.black),
                          ),
                          SizedBox(width: 18),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Isya",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "04:26",
                                style: TextStyle(
                                  color: HexColor.fromHex("#D39D52"),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Transform.scale(
                        scale: 0.7,
                        child: Switch(
                          value: light,
                          thumbColor: WidgetStatePropertyAll(Colors.white),
                          trackColor: WidgetStatePropertyAll(
                            HexColor.fromHex("#256980"),
                          ),
                          activeThumbColor: HexColor.fromHex("#256980"),
                          inactiveThumbColor: HexColor.fromHex(
                            "#256980",
                          ).withAlpha(20),
                          onChanged: (bool value) {
                            setState(() {
                              light = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: HexColor.fromHex("#256980").withAlpha(25),
                border: BoxBorder.all(color: HexColor.fromHex("#256980")),
                borderRadius: BorderRadius.circular(16)
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black.withAlpha(10),
                            child: Icon(FlutterIslamicIcons.solidMosque, color: HexColor.fromHex("#256980")),
                          ),
                          SizedBox(width: 18),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Suara Adzan",
                                style: TextStyle(
                                  color: HexColor.fromHex("#256980"),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Icon(Icons.check_circle, color: HexColor.fromHex("#256980"),)
                    ],
                  ),
                  
                ],
              )
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: HexColor.fromHex("#256980").withAlpha(10),
                // border: BoxBorder.all(color: HexColor.fromHex("#256980")),
                borderRadius: BorderRadius.circular(16)
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black.withAlpha(10),
                            child: Icon(Icons.notifications_outlined, color: HexColor.fromHex("#256980").withAlpha(130),),
                          ),
                          SizedBox(width: 18),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Suara Default",
                                style: TextStyle(
                                  color: HexColor.fromHex("#256980").withAlpha(130),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Icon(Icons.check_circle, color: HexColor.fromHex("#256980").withAlpha(130),)
                    ],
                  ),
                  
                ],
              )
            ),
            
           
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    "Jenis Notifikasi",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: HexColor.fromHex("#256980").withAlpha(25),
                border: BoxBorder.all(color: HexColor.fromHex("#256980")),
                borderRadius: BorderRadius.circular(16)
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black.withAlpha(10),
                            child: Icon(Icons.notifications_active, color: HexColor.fromHex("#256980")),
                          ),
                          SizedBox(width: 18),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Bunyi + Getar",
                                style: TextStyle(
                                  color: HexColor.fromHex("#256980"),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Icon(Icons.check_circle, color: HexColor.fromHex("#256980"),)
                    ],
                  ),
                  
                ],
              )
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: HexColor.fromHex("#256980").withAlpha(10),
                // border: BoxBorder.all(color: HexColor.fromHex("#256980")),
                borderRadius: BorderRadius.circular(16)
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black.withAlpha(10),
                            child: Icon(Icons.notifications_outlined, color: HexColor.fromHex("#256980").withAlpha(130),),
                          ),
                          SizedBox(width: 18),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Bunyi Saja",
                                style: TextStyle(
                                  color: HexColor.fromHex("#256980").withAlpha(130),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Icon(Icons.check_circle, color: HexColor.fromHex("#256980").withAlpha(130),)
                    ],
                  ),
                  
                ],
              )
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: HexColor.fromHex("#256980").withAlpha(10),
                // border: BoxBorder.all(color: HexColor.fromHex("#256980")),
                borderRadius: BorderRadius.circular(16)
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black.withAlpha(10),
                            child: Icon(Icons.vibration_outlined, color: HexColor.fromHex("#256980").withAlpha(130),),
                          ),
                          SizedBox(width: 18),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Getar Saja",
                                style: TextStyle(
                                  color: HexColor.fromHex("#256980").withAlpha(130),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Icon(Icons.check_circle, color: HexColor.fromHex("#256980").withAlpha(130),)
                    ],
                  ),
                  
                ],
              )
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: HexColor.fromHex("#256980").withAlpha(10),
                // border: BoxBorder.all(color: HexColor.fromHex("#256980")),
                borderRadius: BorderRadius.circular(16)
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black.withAlpha(10),
                            child: Icon(Iconsax.volume_slash, color: HexColor.fromHex("#256980").withAlpha(130),),
                          ),
                          SizedBox(width: 18),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Senyap",
                                style: TextStyle(
                                  color: HexColor.fromHex("#256980").withAlpha(130),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Icon(Icons.check_circle, color: HexColor.fromHex("#256980").withAlpha(130),)
                    ],
                  ),
                  
                ],
              )
            ),
           
                ],
              ),
            ),
            
          ],
        ),
      ),
      )
    );
  }
}
