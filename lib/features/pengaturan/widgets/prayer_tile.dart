import 'package:alquran_new/utils/constants/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class PrayerTile extends StatelessWidget {
  final String title;
  final String time;
  final IconData leadingIcon;

  final bool isActive;

  final Color? activeColor;
  final Color? backgroundColor;
  final Color? borderColor;

  final Widget? trailing;

  final VoidCallback? onTap;

  const PrayerTile({
    super.key,
    required this.title,
    required this.time,
    required this.leadingIcon,
    this.isActive = false,
    this.activeColor,
    this.backgroundColor,
    this.borderColor,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = activeColor ?? HexColor.fromHex("#2EC4B6");

    final Color inactiveColor = HexColor.fromHex("#5A7A8A");
    final Color inactiveTitleColor = Colors.white;

    final Color transparent = Colors.transparent;

    final Color bgColor = isActive
        ? primaryColor.withAlpha(20)
        : backgroundColor ?? HexColor.fromHex("#1A3A4A");

    final Color boxColor = isActive ? primaryColor.withAlpha(120) : transparent;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: BoxBorder.all(color: boxColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            leading: Icon(
              leadingIcon,
              size: 24,
              color: isActive ? primaryColor : inactiveColor,
            ),

            title: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: isActive ? primaryColor : inactiveTitleColor,
                fontWeight: FontWeight.w600,
              ),
            ),

            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 13,
                  color: isActive ? primaryColor : inactiveColor,
                ),
              ),
            ),
            trailing:
                trailing ??
                (isActive
                    ? AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        height: 42,
                        width: 42,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: primaryColor,
                        ),
                        child: const Icon(
                          Icons.notifications,
                          size: 22,
                          color: Colors.white,
                        ),
                      )
                    : Icon(
                        Icons.motion_photos_off_rounded,
                        color: isActive ? primaryColor : inactiveColor,
                      )),
          ),
        ),
      ),
    );
  }
}
