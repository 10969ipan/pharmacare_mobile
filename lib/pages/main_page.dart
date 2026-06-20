import 'package:flutter/material.dart';
import 'beranda/beranda_page.dart';
import 'order/order_page.dart';
import 'profil/profil_page.dart';

// Halaman Pembungkus Navigasi Utama Aplikasi (Main Container)
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0; // Indeks halaman aktif terpilih saat ini

  // Daftar widget halaman yang akan dimuat berdasarkan tab aktif
  final List<Widget> _pageList = [
    const BerandaPage(), // Halaman indeks ke-0 (Beranda)
    const OrderPage(), // Halaman indeks ke-1 (Order/Pesanan)
    const ProfilPage(), // Halaman indeks ke-2 (Profil Akun)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList[_selectedIndex], // Merender halaman terpilih sesuai indeks
      bottomNavigationBar: Container(
        height: 56, // Ketinggian padat bar navigasi (label-less)
        decoration: const BoxDecoration(
          color: Colors.white, // Latar belakang bar putih
          border: Border(top: BorderSide(color: Color(0xFFEEEEEE), width: 1.0)), // Garis tepi pembatas atas tipis ala Instagram
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex, // Indeks terpilih saat ini
          onTap: (index) => setState(() => _selectedIndex = index), // Fungsi penggantian halaman saat tab di-tap
          backgroundColor: Colors.white, // Latar belakang BottomNavigationBar putih
          elevation: 0, // Hilangkan bayangan bawaan
          type: BottomNavigationBarType.fixed, // Tipe fixed agar bar lebar proporsional statis
          selectedItemColor: Colors.black87, // Warna ikon aktif hitam pekat ala Instagram
          unselectedItemColor: Colors.grey[400], // Warna ikon tidak aktif abu-abu
          showSelectedLabels: false, // Menyembunyikan teks label tab terpilih
          showUnselectedLabels: false, // Menyembunyikan teks label tab tidak terpilih
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                _selectedIndex == 0 ? Icons.home_filled : Icons.home_outlined, // Ganti ikon home solid/garis
                size: 26, // Ukuran ikon home
              ),
              label: "Beranda", // Label teks (tetap wajib dideklarasikan di Flutter)
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _selectedIndex == 1 ? Icons.shopping_bag : Icons.shopping_bag_outlined, // Ganti ikon bag belanja solid/garis
                size: 25, // Ukuran ikon order
              ),
              label: "Order", // Label teks (tetap wajib dideklarasikan di Flutter)
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _selectedIndex == 2 ? Icons.person : Icons.person_outline, // Ganti ikon profil solid/garis
                size: 26, // Ukuran ikon profil
              ),
              label: "Profil", // Label teks (tetap wajib dideklarasikan di Flutter)
            ),
          ],
        ),
      ),
    );
  }
}
