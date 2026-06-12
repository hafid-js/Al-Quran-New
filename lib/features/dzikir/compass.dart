import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:permission_handler/permission_handler.dart';

class Compass extends StatefulWidget {
  const Compass({Key? key}) : super(key: key);

  @override
  State<Compass> createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  bool _hasPermissions = false;

  CompassEvent? _lastRead;
  DateTime? _lastReadAt;

  @override
  void initState() {
    super.initState();
    _fetchPermissionStatus();
  }

  // =========================
  // PERMISSION CHECK
  // =========================
  Future<void> _fetchPermissionStatus() async {
    final status = await Permission.locationWhenInUse.status;

    debugPrint("📍 Permission status: $status");

    if (!mounted) return;

    setState(() {
      _hasPermissions = status.isGranted;
    });
  }

  Future<void> _requestPermission() async {
    final status = await Permission.locationWhenInUse.request();

    debugPrint("📍 Permission request result: $status");

    if (status.isPermanentlyDenied) {
      debugPrint("⚠️ Permanently denied → opening settings");
      await openAppSettings();
    }

    _fetchPermissionStatus();
  }

  // =========================
  // UI
  // =========================
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Flutter Compass'),
        ),
        body: _hasPermissions ? _buildCompassUI() : _buildPermissionUI(),
      ),
    );
  }

  Widget _buildPermissionUI() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Location Permission Required',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: _requestPermission,
            child: const Text("Request Permission"),
          ),

          const SizedBox(height: 12),

          ElevatedButton(
            onPressed: () async {
              await openAppSettings();
            },
            child: const Text("Open Settings"),
          ),
        ],
      ),
    );
  }

  Widget _buildCompassUI() {
    return Column(
      children: [
        _buildManualReader(),
        Expanded(child: _buildCompass()),
      ],
    );
  }

  Widget _buildManualReader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () async {
              final event = await FlutterCompass.events?.first;

              if (event == null) return;

              setState(() {
                _lastRead = event;
                _lastReadAt = DateTime.now();
              });
            },
            child: const Text('Read Value'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Last: $_lastRead',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'Time: $_lastReadAt',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompass() {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final direction = snapshot.data!.heading;

        if (direction == null) {
          return const Center(
            child: Text("Device does not support compass sensor"),
          );
        }

        return Center(
          child: Material(
            shape: const CircleBorder(),
            elevation: 6,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Transform.rotate(
                angle: (direction * (math.pi / 180) * -1),
                child: Image.asset('assets/compass.jpg'),
              ),
            ),
          ),
        );
      },
    );
  }
}