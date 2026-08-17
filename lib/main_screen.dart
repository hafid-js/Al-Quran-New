import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/development/home_screen_new.dart';
import 'package:alquran_new/development/ibadah/ibadah_screen.dart';
import 'package:alquran_new/development/murrotal/controllers/murrotal_controller.dart';
import 'package:alquran_new/development/pengaturan/pengaturan_notifikasi.dart';
import 'package:alquran_new/development/pengaturan/pengaturan_screen.dart';
import 'package:alquran_new/development/perasaan_screen.dart';
import 'package:alquran_new/development/play_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  bool _showPlayBar = false;
  int _ibadahKey = 0;

  late final MurrotalController _murrotalController;
  late final Worker _playingWorker;
  late final Worker _nomorWorker;

  @override
  void initState() {
    super.initState();
    if (!GetInstance().isRegistered<MurrotalController>()) {
      Get.put(MurrotalController(), permanent: true);
    }
    _murrotalController = Get.find<MurrotalController>();

    _playingWorker = ever(_murrotalController.isMurrotalPlaying, (_) => _updatePlayBarVisibility());
    _nomorWorker = ever(_murrotalController.murrotalSurahNomor, (_) => _updatePlayBarVisibility());
  }

  @override
  void dispose() {
    _playingWorker.dispose();
    _nomorWorker.dispose();
    super.dispose();
  }

  void _updatePlayBarVisibility() {
    final show = _murrotalController.isMurrotalPlaying.value ||
        _murrotalController.murrotalSurahNomor.value != 0;
    if (show != _showPlayBar) {
      _showPlayBar = show;
    }
    setState(() {});
  }

  final List<Widget> _pages = [
    const HomeScreenNew(),
    const PerasaanScreen(),
    const PengaturanScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      if (index == 2) _ibadahKey++;
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
            backgroundColor: HexColor.fromHex("#F9F5EF"),
      body: Column(
        children: [
          Expanded(
            child: _selectedIndex == 2
                ? PengaturanScreen(key: ValueKey(_ibadahKey))
                : _pages[_selectedIndex],
          ),
          if (_showPlayBar) const PlayBar(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        selectedItemColor: HexColor.fromHex("#256980"),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(Iconsax.home_15, size: 30),
            icon: Icon(Iconsax.home, size: 23),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Iconsax.happyemoji5, size: 30),
            icon: Icon(Iconsax.happyemoji, size: 23),
            label: 'Perasaan',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.settings, size: 30),
            icon: Icon(Iconsax.setting_2, size: 23),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}