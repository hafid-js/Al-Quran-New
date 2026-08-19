import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/development/shared/widgets/common_app_bar.dart';
import 'package:alquran_new/development/pengaturan/controllers/notification_settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class PengaturanNotifikasi extends StatefulWidget {
  const PengaturanNotifikasi({super.key});

  @override
  State<PengaturanNotifikasi> createState() => _PengaturanNotifikasiState();
}

class _PengaturanNotifikasiState extends State<PengaturanNotifikasi> {
  final notifController = Get.find<NotificationSettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#F9F5EF"),
      appBar: CommonAppBar(
        title: "Pengaturan Notifikasi",
        surfaceTintColor: HexColor.fromHex("#F9F5EF"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              _buildPrayerSection(),
              SizedBox(height: 15),
              _buildSoundSection(),
              SizedBox(height: 15),
              _buildModeSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrayerSection() {
    return Container(
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
          _buildPrayerToggle(
            title: "Imsak",
            icon: Iconsax.moon,
            isActive: notifController.imsak,
            onTap: () => notifController.togglePrayer('imsak'),
          ),
          Divider(color: const Color.fromARGB(17, 0, 0, 0)),
          _buildPrayerToggle(
            title: "Subuh",
            icon: Iconsax.moon,
            isActive: notifController.subuh,
            onTap: () => notifController.togglePrayer('subuh'),
          ),
          Divider(color: const Color.fromARGB(17, 0, 0, 0)),
          _buildPrayerToggle(
            title: "Dzuhur",
            icon: Iconsax.sun_1,
            isActive: notifController.dzuhur,
            onTap: () => notifController.togglePrayer('dzuhur'),
          ),
          Divider(color: const Color.fromARGB(17, 0, 0, 0)),
          _buildPrayerToggle(
            title: "Ashar",
            icon: Icons.sunny_snowing,
            isActive: notifController.ashar,
            onTap: () => notifController.togglePrayer('ashar'),
          ),
          Divider(color: const Color.fromARGB(17, 0, 0, 0)),
          _buildPrayerToggle(
            title: "Maghrib",
            icon: Iconsax.sun_fog,
            isActive: notifController.maghrib,
            onTap: () => notifController.togglePrayer('maghrib'),
          ),
          Divider(color: const Color.fromARGB(17, 0, 0, 0)),
          _buildPrayerToggle(
            title: "Isya",
            icon: Iconsax.moon,
            isActive: notifController.isya,
            onTap: () => notifController.togglePrayer('isya'),
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerToggle({
    required String title,
    required IconData icon,
    required RxBool isActive,
    required VoidCallback onTap,
  }) {
    return Obx(() {
      final active = isActive.value;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.black.withAlpha(10),
                child: Icon(icon, color: Colors.black),
              ),
              SizedBox(width: 18),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Transform.scale(
            scale: 0.7,
            child: Switch(
              value: active,
              thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                (states) {
                  return const Icon(
                    Icons.check,
                    size: 14,
                    color: Colors.white,
                  );
                },
              ),
              thumbColor: const WidgetStatePropertyAll(Colors.white),
              trackColor: WidgetStateProperty.resolveWith<Color>(
                (states) {
                  if (states.contains(WidgetState.selected)) {
                    return HexColor.fromHex("#256980");
                  }
                  return Colors.black.withAlpha(60);
                },
              ),
              trackOutlineColor: WidgetStateProperty.resolveWith<Color>(
                (states) {
                  return Colors.white;
                },
              ),
              onChanged: (bool value) => onTap(),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildSoundSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bunyi Notifikasi",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          Obx(() {
            final isSelected = notifController.soundType.value == 'adzan';
            return GestureDetector(
              onTap: () => notifController.changeSound('adzan'),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                                    ? Colors.white
                                    : HexColor.fromHex("#256980").withAlpha(10),
                                border: isSelected
                                    ? BoxBorder.all(
                                        color: HexColor.fromHex("#256980"),
                                        width: 1.5,
                                      )
                                    : null,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.black.withAlpha(10),
                          child: Icon(
                            FlutterIslamicIcons.solidMosque,
                            color: isSelected
                                ? HexColor.fromHex("#256980")
                                : HexColor.fromHex("#256980").withAlpha(130),
                          ),
                        ),
                        SizedBox(width: 18),
                        Text(
                          "Suara Adzan",
                          style: TextStyle(
                            color: isSelected
                                ? HexColor.fromHex("#256980")
                                : HexColor.fromHex("#256980").withAlpha(130),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.check_circle,
                      color: isSelected
                          ? HexColor.fromHex("#256980")
                          : HexColor.fromHex("#256980").withAlpha(130),
                    ),
                  ],
                ),
              ),
            );
          }),
          SizedBox(height: 10),
          Obx(() {
            final isSelected = notifController.soundType.value == 'default';
            return GestureDetector(
              onTap: () => notifController.changeSound('default'),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                                    ? Colors.white
                                    : HexColor.fromHex("#256980").withAlpha(10),
                                border: isSelected
                                    ? BoxBorder.all(
                                        color: HexColor.fromHex("#256980"),
                                        width: 1.5,
                                      )
                                    : null,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.black.withAlpha(10),
                          child: Icon(
                            Icons.notifications_outlined,
                            color: isSelected
                                ? HexColor.fromHex("#256980")
                                : HexColor.fromHex("#256980").withAlpha(130),
                          ),
                        ),
                        SizedBox(width: 18),
                        Text(
                          "Suara Default",
                          style: TextStyle(
                            color: isSelected
                                ? HexColor.fromHex("#256980")
                                : HexColor.fromHex("#256980").withAlpha(130),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.check_circle,
                      color: isSelected
                          ? HexColor.fromHex("#256980")
                          : HexColor.fromHex("#256980").withAlpha(130),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildModeSection() {
    final List<Map<String, dynamic>> notificationModes = [
      {"title": "Bunyi + Getar", "icon": Icons.notifications_active},
      {"title": "Bunyi Saja", "icon": Icons.notifications_outlined},
      {"title": "Getar Saja", "icon": Icons.vibration_outlined},
      {"title": "Senyap", "icon": Iconsax.volume_slash},
    ];

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          ...List.generate(notificationModes.length, (index) {
            final item = notificationModes[index];
            return Obx(() {
              final isSelected = notifController.notificationMode.value == index;
              return Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  onTap: () => notifController.changeMode(index),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                     color: isSelected
                                    ? Colors.white
                                    : HexColor.fromHex("#256980").withAlpha(10),
                                border: isSelected
                                    ? BoxBorder.all(
                                        color: HexColor.fromHex("#256980"),
                                        width: 1.5,
                                      )
                                    : null,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.black.withAlpha(10),
                              child: Icon(
                                item["icon"],
                                color: isSelected
                                    ? HexColor.fromHex("#256980")
                                    : HexColor.fromHex("#256980")
                                        .withAlpha(130),
                              ),
                            ),
                            SizedBox(width: 18),
                            Text(
                              item["title"],
                              style: TextStyle(
                                color: isSelected
                                    ? HexColor.fromHex("#256980")
                                    : HexColor.fromHex("#256980")
                                        .withAlpha(130),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.check_circle,
                          color: isSelected
                              ? HexColor.fromHex("#256980")
                              : HexColor.fromHex("#256980").withAlpha(130),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
          }),
        ],
      ),
    );
  }
}
