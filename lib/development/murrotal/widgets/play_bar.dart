import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/development/murrotal/controllers/murrotal_controller.dart';
import 'package:alquran_new/development/murrotal/widgets/seek_playbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class PlayBar extends StatelessWidget {
  const PlayBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MurrotalController>();
    final player = controller.player;

    return Obx(() {
      final qariData =
          MurrotalController.qariData[controller.murrotalQariIndex.value];

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Container(
          padding: EdgeInsets.only(right: 12, left: 12, top: 0, bottom: 12),
          decoration: BoxDecoration(
            color: HexColor.fromHex("#256980"),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(8),
                    child: Image.asset(
                      qariData["image"] ?? "",
                      height: 45,
                      width: 45,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Obx(() {
                    return Text(
                      controller.murrotalSurahName.value,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  }),
                  subtitle: Text(
                    qariData["title"] ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _button(
                        Iconsax.previous5,
                        player.hasPrevious ? player.seekToPrevious : null,
                      ),
                      const SizedBox(width: 4),
                      _button(
                        controller.isMurrotalPlaying.value
                            ? Iconsax.pause_circle5
                            : Iconsax.play_circle5,
                        () {
                          if (player.playing) {
                            player.pause();
                            controller.isMurrotalPlaying.value = false;
                          } else {
                            player.play();
                            controller.isMurrotalPlaying.value = true;
                          }
                        },
                      ),
                      const SizedBox(width: 4),
                      _button(
                        Iconsax.next5,
                        player.hasNext ? player.seekToNext : null,
                      ),
                      const SizedBox(width: 4),
                      _button(
                        Iconsax.stop_circle5,
                        () => controller.stopMurrotal(),
                      ),
                    ],
                  ),
                ),
                SeekPlayBar(player: player),
              ],
            ),
        ),
      );
    });
  }

  Widget _button(IconData icon, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(20),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(child: Icon(icon, color: Colors.white, size: 25)),
      ),
    );
  }
}
