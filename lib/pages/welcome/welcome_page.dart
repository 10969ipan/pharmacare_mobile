import 'package:flutter/material.dart';
import '../login/login_page.dart';
import '../registrasi/registrasi_page.dart';

// Halaman Pembuka/Selamat Datang (Welcome Screen) Aplikasi
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white, // Warna latar belakang putih bersih
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0), // Jarak margin tepi layar
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Posisi kolom di tengah vertikal
          crossAxisAlignment: CrossAxisAlignment.stretch, // Meluaskan isi menyamping penuh
          children: [
            const Spacer(), // Pendorong bagian atas
            Image.asset(
              'assets/images/dokter.webp', /// Ilustrasi dokter selamat datang
              height: 280, fit: BoxFit.contain, // Batasan dimensi gambar
              errorBuilder: (_, _, _) => Container(
                height: 240, decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(20)), // Fallback kontainer bulat biru jika gambar error
                child: const Icon(Icons.local_pharmacy_rounded, size: 100, color: Color(0xFF1E88E5)), // Ikon medis darurat fallback
              ),
            ),
            const SizedBox(height: 40), // Jarak pemisah di bawah gambar
            const Text("Selamat Datang", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1E88E5)), textAlign: TextAlign.center), // Teks judul utama
            const SizedBox(height: 12), // Jarak di bawah judul utama
            Text(
              "Beli berbagai macam obat dan suplemen harian Anda dengan mudah hanya dalam satu aplikasi terpercaya.",
              style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.5), textAlign: TextAlign.center, // Subjudul deskripsi aplikasi
            ),
            const Spacer(), // Pendorong bagian bawah sebelum tombol
            SizedBox(
              height: 50, // Tinggi tetap tombol registrasi
              child: ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage())), // Buka RegisterPage
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E88E5), // Warna latar biru primer
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0, // Sudut bulat 12px flat tanpa bayangan
                ),
                child: const Text("Registrasi", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)), // Label tombol registrasi
              ),
            ),
            const SizedBox(height: 12), // Jarak antar tombol
            SizedBox(
              height: 50, // Tinggi tetap tombol login
              child: OutlinedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage())), // Buka LoginPage
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF1E88E5), width: 1.5), // Garis pembatas luar biru primer
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Sudut bulat 12px
                ),
                child: const Text("Login", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E88E5))), // Label tombol login
              ),
            ),
            const SizedBox(height: 24), // Spasi penutup paling bawah
          ],
        ),
      ),
    ),
  );
}
