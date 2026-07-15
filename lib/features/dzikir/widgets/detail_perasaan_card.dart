import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/core/helpers/responsive_helper.dart';
import 'package:alquran_new/features/dzikir/controllers/doa_perasaan_controller.dart';
import 'package:alquran_new/features/dzikir/models/doa_perasaan_model.dart';
import 'package:alquran_new/features/pengaturan/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class DetailPerasaanCard extends StatelessWidget {
  final DoaPerasaanModel item;
  final DoaPerasaanController controller;
  final int index;
  final int itemCount;
  final double ukuranTeksArab;
  final bool isBold;
  final double ukuranTeksLatinTerjemah;

  const DetailPerasaanCard({
    super.key,
    required this.item,
    required this.controller,
    required this.index,
    required this.itemCount,
    required this.ukuranTeksArab,
    this.isBold = true,
    required this.ukuranTeksLatinTerjemah,
  });

  String buildShareText() {
  final buffer = StringBuffer();

  buffer
  ..writeln(controller.title)
  ..writeln();
  

  buffer.writeln(item.arab);

  if (controller.latin.value) {
    buffer
      ..writeln()
      ..writeln(item.latin);
  }

  if (controller.terjemah.value) {
    buffer
      ..writeln()
      ..writeln(item.arti);
  }

  if ((item.keterangan ?? '').isNotEmpty) {
    buffer
      ..writeln()
      ..writeln("💡 Faedah/Konteks")
      ..writeln(item.keterangan);
  }

  buffer
    ..writeln()
    ..writeln("📚 Sumber")
    ..writeln(item.sumber)
    ..writeln()
    ..writeln("Hafid Tech - Al-Barokah App");

  return buffer.toString();
}

  @override
  Widget build(BuildContext context) {
    final SettingsController setting = Get.find<SettingsController>();
    final selectedIndex = setting.fontSelected.value;
    final fontFamily = fontArabs[selectedIndex]["title"];
    return Padding(
      padding: EdgeInsets.only(bottom: index < itemCount - 1 ? 10 : 0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withAlpha(40),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Data Ke-${item.nomor}",
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(fontSize: 11),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.copy_rounded),
                      onPressed: () async {
                        final buffer = StringBuffer();
                        buffer.writeln(item.arab);
                        if (controller.latin.value) {
                          buffer.writeln('');
                          buffer.writeln(item.latin);
                        }
                        if (controller.terjemah.value) {
                          buffer.writeln('');
                          buffer.writeln(item.arti);
                        }
                        buffer.writeln('');
                        buffer.writeln(
                            '💡 Faedah/Konteks: ${item.keterangan ?? ''}');
                        buffer.writeln('');
                        buffer.writeln('📚 Sumber:');
                        buffer.writeln(item.sumber);
                        final copyText = buffer.toString();

                        await Clipboard.setData(ClipboardData(text: copyText));

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              bottom: 5,
                            ),
                            duration: const Duration(seconds: 1),
                            backgroundColor: Theme.of(context).cardColor,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: Theme.of(context).colorScheme.primary),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            content: Text(
                              'Berhasil Disalin',
                              style: Theme.of(context).textTheme.titleSmall!
                                  .copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
  onPressed: () {
    SharePlus.instance.share(
      ShareParams(
        title: controller.title,
        text: buildShareText(),
      ),
    );
  },
  icon: const Icon(Icons.share_rounded),
),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Obx(() {
              return Column(
                children: [
                  Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(left: 18),
                child: Text(
                  item.arab,
                  softWrap: true,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: isBold ? FontWeight.bold : FontWeight.w200,
                    fontFamily: fontFamily,
                    height: 2.5,
                    fontSize: ukuranTeksArab,
                  ),
                ),
              ),
            ),
            if (controller.latin.value) ...[
              SizedBox(height: 15),
              Text(
                item.latin,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize:
                                                                    Responsive.fontSize(
                                                                      context,
                                                                      phone: controller.ukuranLatinTerjemah.value,
                                                                    ),
                  color: Theme.of(context).colorScheme.primary
                ),
              ),
            ],
            if (controller.terjemah.value) ...[
              SizedBox(height: 10),
              Text(
                item.arti,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                 fontSize:
                                                                    Responsive.fontSize(
                                                                      context,
                                                                      phone: controller.ukuranLatinTerjemah.value,
                                                                    ),

                ),
              ),
            ],
            SizedBox(height: 20),
            Container(
              width: double.infinity,

              decoration: BoxDecoration(
                border: Border(left: BorderSide(width: 3, color: Colors.amber)),

                color: Colors.amber.withAlpha(10),

                borderRadius: BorderRadius.circular(12),
              ),

              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "💡Faedah/Konteks: ",
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: ukuranTeksLatinTerjemah,
                                ),
                          ),
                          TextSpan(
                            text: item.keterangan,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(
                                  fontSize: ukuranTeksLatinTerjemah,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 10),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "📚 Sumber: ",
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: ukuranTeksLatinTerjemah,
                                ),
                          ),
                          TextSpan(
                            text: item.sumber,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(
                                  fontSize: ukuranTeksLatinTerjemah,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
