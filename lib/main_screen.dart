import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/development/alquran_screen_new.dart';
import 'package:alquran_new/development/home_screen_new.dart';
import 'package:alquran_new/development/perasaan_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreenNew(),
    PerasaanScreen(),
    const _ProfilPlaceholder(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#FF4158D0"),
      body: _pages[_selectedIndex],
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
            activeIcon: Icon(Iconsax.profile_circle5, size: 30),
            icon: Icon(Iconsax.profile_circle, size: 23),
            label: 'Akun',
          ),
        ],
      ),
    );
  }
}

class _ProfilPlaceholder extends StatelessWidget {
  const _ProfilPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_outline, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Profil',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Coming Soon',
            style: TextStyle(fontSize: 14, color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }
}
