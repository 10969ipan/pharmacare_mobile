import 'package:flutter/material.dart';
import '../login/login_page.dart';
import '../registrasi/registrasi_page.dart';

// Halaman Pembuka/Selamat Datang (Welcome Screen) Aplikasi
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Warna latar belakang putih bersih
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0), // Jarak padding kiri-kanan halaman
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Pusatkan seluruh konten kolom secara vertikal
            crossAxisAlignment: CrossAxisAlignment.stretch, // Meluaskan isi kolom secara horizontal penuh
            children: [
              const Spacer(), // Dorong konten di bawah ke arah tengah bawah
              // Gambar Ilustrasi Dokter
              Image.asset(
                'assets/images/dokter.webp', // Menggunakan ilustrasi asset dokter
                height: 280, fit: BoxFit.contain, // Tinggi gambar 280px dan rasio pemotongan proporsional
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 240,
                  decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(20)), // Latar cadangan biru bulat
                  child: const Icon(Icons.local_pharmacy_rounded, size: 100, color: Color(0xFF1E88E5)), // Ikon medis darurat
                ),
              ),
              const SizedBox(height: 40), // Jarak di bawah gambar ilustrasi
              // Teks Selamat Datang Utama
              const Text(
                "Selamat Datang",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1E88E5)), // Ukuran teks 28px tebal dengan warna biru primer
                textAlign: TextAlign.center, // Ratakan teks di tengah
              ),
              const SizedBox(height: 12), // Jarak di bawah judul sapaan
              // Teks Subjudul Deskripsi Aplikasi
              Text(
                "Beli berbagai macam obat dan suplemen harian Anda dengan mudah hanya dalam satu aplikasi terpercaya.",
                style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.5), // Teks warna abu-abu gelap dengan tinggi baris renggang
                textAlign: TextAlign.center, // Ratakan teks di tengah
              ),
              const Spacer(), // Dorong tombol navigasi ke bagian paling bawah layar
              
              // Tombol Menuju Pendaftaran (Registrasi)
              SizedBox(
                height: 50, // Tinggi tombol 50px
                child: ElevatedButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage())), // Berpindah rute ke RegisterPage saat diklik
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E88E5), // Latar belakang tombol berwarna biru primer
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Sudut bulat tombol 12px
                    elevation: 0, // Menghilangkan bayangan default tombol
                  ),
                  child: const Text("Registrasi", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)), // Label tombol
                ),
              ),
              const SizedBox(height: 12), // Jarak vertikal pemisah antar tombol
              
              // Tombol Menuju Halaman Masuk (Login)
              SizedBox(
                height: 50, // Tinggi tombol 50px
                child: OutlinedButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage())), // Berpindah rute ke LoginPage saat diklik
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF1E88E5), width: 1.5), // Memberikan garis pembatas luar biru tebal 1.5px
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Sudut bulat tombol 12px
                  ),
                  child: const Text("Login", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E88E5))), // Label tombol dengan warna biru primer
                ),
              ),
              const SizedBox(height: 24), // Spasi penutup bagian paling bawah
            ],
          ),
        ),
      ),
    );
  }
}
