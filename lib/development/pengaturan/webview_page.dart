import 'package:flutter/material.dart';
import 'package:alquran_new/development/shared/widgets/common_app_bar.dart';
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
        appBar: CommonAppBar(
          title: widget.title,
        ),
        backgroundColor: Colors.white,
        body: WebViewWidget(controller: controller),
    );
  }
}