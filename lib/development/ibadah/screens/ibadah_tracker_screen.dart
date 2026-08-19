import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IbadahTrackerScreen extends StatelessWidget {
  const IbadahTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#F9F5EF"),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        actions: [
          Row(
            
          )
        ],
      ),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20), child: Column(
        children: [],
      ),),
    );
  }
}