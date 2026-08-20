import 'dart:io';

import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/development/pengaturan/pengaturan_aplikasi.dart';
import 'package:alquran_new/development/pengaturan/webview_page.dart';
import 'package:alquran_new/development/pengaturan/pengaturan_notifikasi.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';

enum Availability { loading, available, unavailable }

class PengaturanScreen extends StatefulWidget {
  const PengaturanScreen({super.key});

  @override
  State<PengaturanScreen> createState() => _PengaturanScreenState();
}

class _PengaturanScreenState extends State<PengaturanScreen> {
  final InAppReview _inAppReview = InAppReview.instance;

  Availability _availability = Availability.loading;

  @override
  void initState() {
    super.initState();

    // (<T>(T? o) => o!) ensures that the following expression is not null for backwards compatibility.
    (<T>(T? o) => o!)(WidgetsBinding.instance).addPostFrameCallback((_) async {
      try {
        final isAvailable = await _inAppReview.isAvailable();

        setState(() {
          // This plugin cannot be tested on Android by installing your app
          // locally. See https://github.com/britannio/in_app_review#testing for
          // more information.
          _availability = isAvailable && !Platform.isAndroid
              ? Availability.available
              : Availability.unavailable;
        });
      } catch (_) {
        setState(() => _availability = Availability.unavailable);
      }
    });
  }

  Future<void> _requestReview() => _inAppReview.requestReview();

  Future<void> _openWhatsApp() async {
    final Uri url = Uri.parse('https://wa.me/6288298654539');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text(
          "Pengaturan",
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Utama",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => Get.to(() => PengaturanNotifikasi()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black.withAlpha(10),
                        child: Icon(
                          Iconsax.notification_bing,
                          color: HexColor.fromHex("#256980"),
                        ),
                      ),
                      SizedBox(width: 18),
                      Text(
                        "Pengaturan Notifikasi",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Iconsax.arrow_right_3,
                    color: HexColor.fromHex("#256980"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(color: const Color.fromARGB(17, 0, 0, 0)),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => Get.to(() => PengaturanAplikasi()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black.withAlpha(10),
                        child: Icon(
                          Iconsax.setting_2,
                          color: HexColor.fromHex("#256980"),
                        ),
                      ),
                      SizedBox(width: 18),
                      Text(
                        "Pengaturan Aplikasi",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Iconsax.arrow_right_3,
                    color: HexColor.fromHex("#256980"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(color: const Color.fromARGB(17, 0, 0, 0)),
            SizedBox(height: 20),

            Text(
              "Lainnya",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: _openWhatsApp,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black.withAlpha(10),
                        child: Icon(
                          Icons.contact_support_outlined,
                          color: HexColor.fromHex("#256980"),
                        ),
                      ),
                      SizedBox(width: 18),
                      Text(
                        "Pusat Bantuan",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Iconsax.arrow_right_3,
                    color: HexColor.fromHex("#256980"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(color: const Color.fromARGB(17, 0, 0, 0)),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Get.to(
                  () => const LocalWebViewPage(
                    title: "Syarat & Ketentuan",
                    assetPath: "assets/development/terms.html",
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black.withAlpha(10),
                        child: Icon(
                          Iconsax.document_text,
                          color: HexColor.fromHex("#256980"),
                        ),
                      ),
                      SizedBox(width: 18),
                      Text(
                        "Syarat & Ketentuan",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Iconsax.arrow_right_3,
                    color: HexColor.fromHex("#256980"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(color: const Color.fromARGB(17, 0, 0, 0)),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Get.to(
                  () => const LocalWebViewPage(
                    title: "Kebijakan Privasi",
                    assetPath: "assets/development/privacy_policy.html",
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black.withAlpha(10),
                        child: Icon(
                          Iconsax.shield,
                          color: HexColor.fromHex("#256980"),
                        ),
                      ),
                      SizedBox(width: 18),
                      Text(
                        "Kebijakan Privasi",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Iconsax.arrow_right_3,
                    color: HexColor.fromHex("#256980"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(color: const Color.fromARGB(17, 0, 0, 0)),
            SizedBox(height: 10),
            GestureDetector(
              onTap: _requestReview,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black.withAlpha(10),
                        child: Icon(
                          Iconsax.star,
                          color: HexColor.fromHex("#256980"),
                        ),
                      ),
                      SizedBox(width: 18),
                      Text(
                        "Rating Aplikasi",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "v2.0.0",
                        style: TextStyle(color: HexColor.fromHex("#D39D52")),
                      ),
                      Icon(
                        Iconsax.arrow_right_3,
                        color: HexColor.fromHex("#256980"),
                      ),
                    ],
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
