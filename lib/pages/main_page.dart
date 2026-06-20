import 'package:flutter/material.dart';
import 'beranda/beranda_page.dart';
import 'order/order_page.dart';
import 'profil/profil_page.dart';

// Halaman Pembungkus Navigasi Utama/Kontainer Navigasi Utama Aplikasi
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _idx = 0; // Indeks tab halaman aktif terpilih saat ini

  // Daftar widget halaman yang akan dimuat berdasarkan tab aktif
  final _pages = const [BerandaPage(), OrderPage(), ProfilPage()];

  // Helper untuk membuat item BottomNavigationBar secara compact dan dinamis
  BottomNavigationBarItem _item(int i, IconData active, IconData inactive, String lbl, double sz) => BottomNavigationBarItem(
        icon: Icon(_idx == i ? active : inactive, size: sz), // Mengubah ikon solid/garis berdasarkan kecocokan indeks
        label: lbl, // Label teks navigasi wajib
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: _pages[_idx], // Merender halaman terpilih sesuai indeks
        bottomNavigationBar: Container(
          height: 56, // Ketinggian padat bar navigasi (label-less)
          decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Color(0xFFEEEEEE)))), // Garis tepi pembatas atas tipis ala Instagram
          child: BottomNavigationBar(
            currentIndex: _idx, // Indeks terpilih saat ini
            onTap: (i) => setState(() => _idx = i), // Pindah halaman ketika tab ditekan
            backgroundColor: Colors.white, elevation: 0, type: BottomNavigationBarType.fixed, // Desain flat minimalis
            selectedItemColor: Colors.black87, unselectedItemColor: Colors.grey[400], // Warna aktif hitam pekat & pasif abu-abu
            showSelectedLabels: false, showUnselectedLabels: false, // Sembunyikan label teks
            items: [
              _item(0, Icons.home_filled, Icons.home_outlined, "Beranda", 26), // Navigasi ke menu Beranda
              _item(1, Icons.shopping_bag, Icons.shopping_bag_outlined, "Order", 25), // Navigasi ke menu Order
              _item(2, Icons.person, Icons.person_outline, "Profil", 26), // Navigasi ke menu Profil
            ],
          ),
        ),
      );
}
