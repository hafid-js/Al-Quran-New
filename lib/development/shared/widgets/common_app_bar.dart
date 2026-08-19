import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final Color? backgroundColor;
  final Color? surfaceTintColor;
  final Color? backIconColor;
  final Color? titleColor;
  final List<Widget>? actions;
  final EdgeInsetsGeometry? actionsPadding;
  final PreferredSizeWidget? bottom;
  final double? toolbarHeight;
  final double? leadingWidth;
  final Widget? leading;
  final bool showBack;
  final String? Function()? onBack;

  const CommonAppBar({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.backgroundColor,
    this.surfaceTintColor,
    this.backIconColor,
    this.titleColor,
    this.actions,
    this.actionsPadding,
    this.bottom,
    this.toolbarHeight,
    this.leadingWidth,
    this.leading,
    this.showBack = true,
    this.onBack,
  });

  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight + (bottom?.preferredSize.height ?? 0),
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBack
          ? (leading ?? GestureDetector(
              onTap: () => onBack?.call() ?? Get.back(),
              child: Icon(
                Icons.arrow_back_ios,
                color: backIconColor ?? Colors.black,
              ),
            ))
          : null,
      surfaceTintColor: surfaceTintColor ?? Colors.white,
      backgroundColor: backgroundColor ?? Colors.white,
      centerTitle: centerTitle,
      toolbarHeight: toolbarHeight,
      leadingWidth: leadingWidth,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
          color: titleColor ?? Colors.black,
        ),
      ),
      actions: actions,
      actionsPadding: actionsPadding,
      bottom: bottom,
    );
  }
}
