import 'dart:ui';
import 'package:flutter/material.dart';

void main() => runApp(const RefreshIndicatorExampleApp());

class RefreshIndicatorExampleApp extends StatelessWidget {
  const RefreshIndicatorExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: <PointerDeviceKind>{
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad,
          PointerDeviceKind.stylus,
        },
      ),
      home: const RefreshIndicatorExample(),
    );
  }
}

class RefreshIndicatorExample extends StatefulWidget {
  const RefreshIndicatorExample({super.key});

  @override
  State<RefreshIndicatorExample> createState() =>
      _RefreshIndicatorExampleState();
}

class _RefreshIndicatorExampleState extends State<RefreshIndicatorExample> {
  bool _isRefreshing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RefreshIndicator.noSpinner Sample')),
      body: Stack(
        children: <Widget>[
          RefreshIndicator.noSpinner(

            onStatusChange: (RefreshIndicatorStatus? status) {
              if (status == RefreshIndicatorStatus.done) {
                setState(() {
                  _isRefreshing = false;
                });
              }
            },

            onRefresh: () async {
              setState(() {
                _isRefreshing = true;
              });

              return Future<void>.delayed(const Duration(seconds: 3));
            },

            child: CustomScrollView(
              slivers: <Widget>[
                SliverList.builder(
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      tileColor: Colors.green[100],
                      title: const Text('Pull down here'),
                      subtitle: const Text(
                        'A custom refresh indicator will be shown',
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          if (_isRefreshing)
            ColoredBox(
              color: Colors.black45,
              child: Align(
                child: CircularProgressIndicator(
                  color: Colors.purple[500],
                  strokeWidth: 10,
                  semanticsLabel: 'Circular progress indicator',
                ),
              ),
            ),
        ],
      ),
    );
  }
}