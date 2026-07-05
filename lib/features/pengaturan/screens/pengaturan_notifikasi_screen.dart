import 'package:alquran_new/features/pengaturan/controllers/notification_settings_controller.dart';
import 'package:alquran_new/features/pengaturan/widgets/prayer_tile.dart';
import 'package:alquran_new/core/helpers/helper_functions.dart';
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
  final List<Map<String, dynamic>> notificationModes = [
    {"title": "Bunyi + Getar", "icon": Icons.notifications_active_rounded},
    {"title": "Bunyi Saja", "icon": Icons.menu_book_rounded},
    {"title": "Getar Saja", "icon": Icons.notification_important_rounded},
    {"title": "Senyap", "icon": Icons.sensors_off_rounded},
  ];

  final notifController = Get.find<NotificationSettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_circle_left_rounded),
          color: Colors.white,
        ),
        title: Row(
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Icon(
                Icons.menu_book_rounded,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
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
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
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
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        child: Icon(
                          Icons.notification_important_rounded,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
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
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: List.generate(notificationModes.length, (
                          index,
                        ) {
                          final item = notificationModes[index];

                          return Obx(() {
                            final isSelected =
                                notifController.notificationMode.value == index;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () => notifController.changeMode(index),

                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.surface
                                        : HexColor.fromHex("#1A3A4A"),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: isSelected
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.primary
                                          : Colors.transparent,
                                      width: 0.7,
                                    ),
                                  ),

                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),

                                    leading: Icon(
                                      item["icon"],
                                      size: 20,
                                      color: isSelected
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.primary
                                          : HexColor.fromHex("#5A7A8A"),
                                    ),

                                    title: Text(
                                      item["title"],
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: isSelected
                                            ? Theme.of(
                                                context,
                                              ).colorScheme.primary
                                            : null,
                                      ),
                                    ),

                                    trailing: Icon(
                                      Icons.check_circle_rounded,
                                      color: isSelected
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.primary
                                          : HexColor.fromHex("#5A7A8A"),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                        }),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),

              SizedBox(height: 20),
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
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        child: Icon(
                          Icons.volume_up_rounded,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
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
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Obx(
                            () => GestureDetector(
                              onTap: () =>
                                  notifController.changeSound('default'),
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      notifController.soundType.value ==
                                          'default'
                                      ? Theme.of(context).colorScheme.surface
                                      : HexColor.fromHex("#1A3A4A"),
                                  borderRadius: BorderRadius.circular(16),
                                  border:
                                      notifController.soundType.value ==
                                          'default'
                                      ? Border.all(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                          width: 0.5,
                                        )
                                      : null,
                                ),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.notifications,
                                    color:
                                        notifController.soundType.value ==
                                            'default'
                                        ? Theme.of(context).colorScheme.primary
                                        : HexColor.fromHex("#2F4C5B"),
                                  ),
                                  title: Text(
                                    "Suara Default",
                                    style: TextStyle(
                                      color:
                                          notifController.soundType.value ==
                                              'default'
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.primary
                                          : HexColor.fromHex("#61737C"),
                                    ),
                                  ),
                                  trailing:
                                      notifController.soundType.value ==
                                          'default'
                                      ? Icon(
                                          Icons.check_circle,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        )
                                      : null,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 10),

                          Obx(
                            () => GestureDetector(
                              onTap: () => notifController.changeSound('adzan'),
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      notifController.soundType.value == 'adzan'
                                      ? Theme.of(context).colorScheme.surface
                                      : HexColor.fromHex("#163241"),
                                  borderRadius: BorderRadius.circular(16),
                                  border:
                                      notifController.soundType.value == 'adzan'
                                      ? Border.all(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                          width: 0.5,
                                        )
                                      : null,
                                ),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.mosque_rounded,
                                    color:
                                        notifController.soundType.value ==
                                            'adzan'
                                        ? Theme.of(context).colorScheme.primary
                                        : HexColor.fromHex("#5A7A8A"),
                                  ),
                                  title: Text(
                                    "Suara Adzan",
                                    style: TextStyle(
                                      color:
                                          notifController.soundType.value ==
                                              'adzan'
                                          ? Colors.white
                                          : HexColor.fromHex("#5A7A8A"),
                                    ),
                                  ),
                                  trailing:
                                      notifController.soundType.value == 'adzan'
                                      ? Icon(
                                          Icons.check_circle,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        )
                                      : Icon(
                                          Icons.check_circle,
                                          color: HexColor.fromHex("#5A7A8A"),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
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
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        child: Icon(
                          Icons.access_time_filled_outlined,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
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
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Obx(
                            () => PrayerTile(
                              title: "Imsak",
                              time: "04:26",
                              leadingIcon: Icons.dark_mode_rounded,
                              isActive: notifController.imsak.value,
                              onTap: () =>
                                  notifController.togglePrayer('imsak'),
                            ),
                          ),
                          const SizedBox(height: 12),

                          Obx(
                            () => PrayerTile(
                              title: "Subuh",
                              time: "04:36",
                              leadingIcon: Icons.bedtime_rounded,
                              isActive: notifController.subuh.value,
                              onTap: () =>
                                  notifController.togglePrayer('subuh'),
                            ),
                          ),
                          const SizedBox(height: 12),

                          Obx(
                            () => PrayerTile(
                              title: "Dzuhur",
                              time: "11:57",
                              leadingIcon: Icons.bedtime_rounded,
                              isActive: notifController.dzuhur.value,
                              onTap: () =>
                                  notifController.togglePrayer('dzuhur'),
                            ),
                          ),
                          const SizedBox(height: 12),

                          Obx(
                            () => PrayerTile(
                              title: "Ashar",
                              time: "15:14",
                              leadingIcon: Icons.bedtime_rounded,
                              isActive: notifController.ashar.value,
                              onTap: () =>
                                  notifController.togglePrayer('ashar'),
                            ),
                          ),
                          const SizedBox(height: 12),

                          Obx(
                            () => PrayerTile(
                              title: "Maghrib",
                              time: "17:47",
                              leadingIcon: Icons.bedtime_rounded,
                              isActive: notifController.maghrib.value,
                              onTap: () =>
                                  notifController.togglePrayer('maghrib'),
                            ),
                          ),

                          const SizedBox(height: 12),

                          Obx(
                            () => PrayerTile(
                              title: "Isya",
                              time: "19:00",
                              leadingIcon: Icons.bedtime_rounded,
                              isActive: notifController.isya.value,
                              onTap: () => notifController.togglePrayer('isya'),
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
      ),
    );
  }
}
