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
  int _idx = 0;

  final _pages = const [BerandaPage(), OrderPage(), ProfilPage()];

  BottomNavigationBarItem _item(int i, IconData active, IconData inactive, String lbl, double sz) => BottomNavigationBarItem(
        icon: Icon(_idx == i ? active : inactive, size: sz),
        label: lbl,
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: _pages[_idx],
        bottomNavigationBar: Container(
          height: 56,
          decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Color(0xFFEEEEEE)))),
          child: BottomNavigationBar(
            currentIndex: _idx,
            onTap: (i) => setState(() => _idx = i),
            backgroundColor: Colors.white, elevation: 0, type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.black87, unselectedItemColor: Colors.grey[400],
            showSelectedLabels: false, showUnselectedLabels: false,
            items: [
              _item(0, Icons.home_filled, Icons.home_outlined, "Beranda", 26),
              _item(1, Icons.shopping_bag, Icons.shopping_bag_outlined, "Order", 25),
              _item(2, Icons.person, Icons.person_outline, "Profil", 26),
            ],
          ),
        ),
      );
}
