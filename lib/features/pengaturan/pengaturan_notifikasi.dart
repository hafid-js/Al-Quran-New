import 'package:alquran_new/features/pengaturan/widgets/prayer_tile.dart';
import 'package:alquran_new/utils/constants/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PengaturanNotifikasiScreen extends StatefulWidget {
  const PengaturanNotifikasiScreen({super.key});

  @override
  State<PengaturanNotifikasiScreen> createState() =>
      _PengaturanNotifikasiScreenState();
}

class _PengaturanNotifikasiScreenState
    extends State<PengaturanNotifikasiScreen> {
  String jenisNotif = "Bunyi + Getar";
  String bunyiNotif = "default";
  List<bool> prayerStates = [true, true, true, true, true, true];

  int selectedIndex = 3;

  final List<Map<String, dynamic>> notificationModes = [
    {"title": "Bunyi + Getar", "icon": Icons.notifications_active_rounded},
    {"title": "Bunyi Saja", "icon": Icons.menu_book_rounded},
    {"title": "Getar Saja", "icon": Icons.notification_important_rounded},
    {"title": "Senyap", "icon": Icons.sensors_off_rounded},
  ];

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
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                decoration: BoxDecoration(
                  color: HexColor.fromHex("#132e3a"),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
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
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: List.generate(notificationModes.length, (
                          index,
                        ) {
                          final item = notificationModes[index];
                          final bool isSelected = selectedIndex == index;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  jenisNotif = item["title"];
                                });

                                if (index == 0) {
                                  {}
                                }
                              },

                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? HexColor.fromHex(
                                          "#2cc4b6",
                                        ).withAlpha(20)
                                      : HexColor.fromHex("#1A3A4A"),

                                  borderRadius: BorderRadius.circular(16),

                                  border: Border.all(
                                    color: isSelected
                                        ? HexColor.fromHex("#2cc4b6")
                                        : Colors.transparent,
                                    width: 0.7,
                                  ),
                                ),

                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),

                                  leading: Icon(
                                    item["icon"],
                                    size: 20,
                                    color: HexColor.fromHex("#2dc8b9"),
                                  ),

                                  title: Text(
                                    item["title"],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),

                                  trailing: isSelected
                                      ? Icon(
                                          Icons.check_circle_rounded,
                                          color: HexColor.fromHex("#2dc8b9"),
                                        )
                                      : null,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),

              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                decoration: BoxDecoration(
                  color: HexColor.fromHex("#132D3B"),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      leading: Container(
                        height: 36,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: HexColor.fromHex("#17404a"),
                        ),
                        child: Icon(
                          Icons.volume_up_rounded,
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
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                bunyiNotif = "default";
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: bunyiNotif == "default"
                                    ? HexColor.fromHex("#2cc4b6").withAlpha(20)
                                    : HexColor.fromHex("#163241"),
                                borderRadius: BorderRadius.circular(16),
                                border: bunyiNotif == "default"
                                    ? Border.all(
                                        color: HexColor.fromHex("#2cc4b6"),
                                        width: 0.5,
                                      )
                                    : null,
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                leading: Icon(
                                  Icons.notifications,
                                  color: bunyiNotif == "default"
                                      ? Colors.tealAccent
                                      : HexColor.fromHex("#2F4C5B"),
                                ),
                                title: Text(
                                  "Suara Default",
                                  style: TextStyle(
                                    color: bunyiNotif == "default"
                                        ? Colors.white
                                        : HexColor.fromHex("#61737C"),
                                  ),
                                ),
                                trailing: bunyiNotif == "default"
                                    ? Icon(
                                        Icons.check_circle,
                                        color: Colors.tealAccent,
                                      )
                                    : null,
                              ),
                            ),
                          ),

                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                bunyiNotif = "adzan";
                              });

                              // NotificationService().showNotification(
                              //   title: "Al-Barokah",
                              //   body: "Adzan Isya Berkumandang",
                              //   soundSource: "alarmbeep.wav",
                              // );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: bunyiNotif == "adzan"
                                    ? HexColor.fromHex("#1f4d5c")
                                    : HexColor.fromHex("#163241"),
                                borderRadius: BorderRadius.circular(16),
                                border: bunyiNotif == "adzan"
                                    ? Border.all(
                                        color: Colors.tealAccent,
                                        width: 1.5,
                                      )
                                    : null,
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                leading: Icon(
                                  Icons.mosque_rounded,
                                  color: bunyiNotif == "adzan"
                                      ? Colors.tealAccent
                                      : HexColor.fromHex("#2F4C5B"),
                                ),
                                title: Text(
                                  "Suara Adzan",
                                  style: TextStyle(
                                    color: bunyiNotif == "adzan"
                                        ? Colors.white
                                        : HexColor.fromHex("#61737C"),
                                  ),
                                ),
                                trailing: bunyiNotif == "adzan"
                                    ? Icon(
                                        Icons.check_circle,
                                        color: Colors.tealAccent,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                decoration: BoxDecoration(
                  color: HexColor.fromHex("#132e3a"),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
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
                          PrayerTile(
                            title: "Imsak",
                            time: "04:26",
                            leadingIcon: Icons.dark_mode_rounded,
                            isActive: prayerStates[0],
                            onTap: () {
                              setState(() {
                                prayerStates[0] = !prayerStates[0];
                              });
                            },
                          ),
                          const SizedBox(height: 12),

                          PrayerTile(
                            title: "Subuh",
                            time: "04:36",
                            leadingIcon: Icons.bedtime_rounded,
                            isActive: prayerStates[1],
                            onTap: () {
                              setState(() {
                                prayerStates[1] = !prayerStates[1];
                              });
                            },
                          ),
                          const SizedBox(height: 12),

                          PrayerTile(
                            title: "Dzuhur",
                            time: "11:57",
                            leadingIcon: Icons.bedtime_rounded,
                            isActive: prayerStates[2],
                            onTap: () {
                              setState(() {
                                prayerStates[2] = !prayerStates[2];
                              });
                            },
                          ),
                          const SizedBox(height: 12),

                          PrayerTile(
                            title: "Ashar",
                            time: "15:14",
                            leadingIcon: Icons.bedtime_rounded,
                            isActive: prayerStates[3],
                            onTap: () {
                              setState(() {
                                prayerStates[3] = !prayerStates[3];
                              });
                            },
                          ),
                          const SizedBox(height: 12),

                          PrayerTile(
                            title: "Maghrib",
                            time: "17:47",
                            leadingIcon: Icons.bedtime_rounded,
                            isActive: prayerStates[4],
                            onTap: () {
                              setState(() {
                                prayerStates[4] = !prayerStates[4];
                              });
                            },
                          ),

                          const SizedBox(height: 12),

                          PrayerTile(
                            title: "Isya",
                            time: "19:00",
                            leadingIcon: Icons.bedtime_rounded,
                            isActive: prayerStates[5],
                            onTap: () {
                              setState(() {
                                prayerStates[5] = !prayerStates[5];
                              });
                            },
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
