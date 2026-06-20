import 'package:flutter/material.dart';
import 'beranda/beranda_page.dart';
import 'order/order_page.dart';
import 'profil/profil_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pageList = [
    const BerandaPage(),
    const OrderPage(),
    const ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList[_selectedIndex],
      bottomNavigationBar: Container(
        height: 56, // Compact height matching label-less design
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Color(0xFFEEEEEE),
              width: 1.0,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          backgroundColor: Colors.white,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black87, // Instagram-style dark active icons
          unselectedItemColor: Colors.grey[400], // Inactive grey icons
          showSelectedLabels: false, // Hide labels
          showUnselectedLabels: false, // Hide labels
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                _selectedIndex == 0 ? Icons.home_filled : Icons.home_outlined,
                size: 26,
              ),
              label: "Beranda",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _selectedIndex == 1 ? Icons.shopping_bag : Icons.shopping_bag_outlined,
                size: 25,
              ),
              label: "Order",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _selectedIndex == 2 ? Icons.person : Icons.person_outline,
                size: 26,
              ),
              label: "Profil",
            ),
          ],
        ),
      ),
    );
  }
}
