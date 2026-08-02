import 'package:flutter/material.dart';

class TasbihScreenTest extends StatelessWidget {
  const TasbihScreenTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasbih"),
      ),
      body: Column(
        children: [
          Center(
            child: Text("الله أكبر"),
          )
        ],
      ),
    );
  }
}