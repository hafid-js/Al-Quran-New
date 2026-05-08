import 'package:alquran_new/notification_service.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: () {
          NotificationService().showNotification(
            title: "Hello",
            body: "This is your notification message",
            soundSource: ""
          );
        }, child: Text("Show Notification")),
      ),
    );
  }
}