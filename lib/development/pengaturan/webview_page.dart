import 'package:flutter/material.dart';
import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LocalWebViewPage extends StatefulWidget {
  final String title;
  final String assetPath;

  const LocalWebViewPage({
    super.key,
    required this.title,
    required this.assetPath,
  });

  @override
  State<LocalWebViewPage> createState() => _LocalWebViewPageState();
}

class _LocalWebViewPageState extends State<LocalWebViewPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadFlutterAsset(widget.assetPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
          title: Text(widget.title, style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: Colors.black),),         surfaceTintColor: Colors.white, foregroundColor: Colors.white, backgroundColor: Colors.white,),
        backgroundColor: Colors.white,
        body: WebViewWidget(controller: controller),
    );
  }
}