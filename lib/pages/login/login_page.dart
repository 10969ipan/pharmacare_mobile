import 'package:flutter/material.dart';
import '../main_page.dart';
import '../registrasi/registrasi_page.dart';

// Halaman Login Akun Pengguna
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController(); // Controller untuk input field email
  final _passwordController = TextEditingController(); // Controller untuk input field password

  @override
  void dispose() {
    _emailController.dispose(); // Menghapus controller email untuk cegah kebocoran memori
    _passwordController.dispose(); // Menghapus controller password untuk cegah kebocoran memori
    super.dispose();
  }

  // Fungsi memproses aksi masuk pengguna
  void _handleLogin() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MainPage()), // Berpindah ke Halaman Utama (MainPage)
      (route) => false, // Menghapus seluruh riwayat rute sebelumnya agar user tidak bisa memencet back ke login
    );
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login Berhasil! Selamat Datang.'), // Notifikasi toast melayang sukses masuk
        backgroundColor: Colors.blue, // Warna latar belakang notifikasi biru
        behavior: SnackBarBehavior.floating, // Posisi mengambang di layar
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang halaman putih bersih
      appBar: AppBar(
        title: const Text('Login', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)), // Judul halaman
        backgroundColor: Colors.white, // Latar belakang AppBar putih
        elevation: 0, // Hilangkan bayangan di bawah AppBar
        iconTheme: const IconThemeData(color: Colors.black87), // Tombol back berwarna gelap
        centerTitle: true, // Judul dipusatkan di tengah
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0), // Padding sisi kiri-kanan halaman
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Meluaskan isi kolom menyamping penuh
            children: [
              const SizedBox(height: 20), // Spasi atas
              // Gambar Ilustrasi Dokter
              Image.asset(
                'assets/images/dokter.webp', // Aset ilustrasi gambar dokter
                height: 200, fit: BoxFit.contain, // Batasan tinggi dan pemotongan gambar proporsional
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 180,
                  decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(16)), // Kontainer biru muda bulat jika gambar error
                  child: const Icon(Icons.lock_person_rounded, size: 80, color: Color(0xFF1E88E5)), // Ikon gembok medis
                ),
              ),
              const SizedBox(height: 32), // Jarak di bawah gambar
              const Text('Masuk ke Akun Anda', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50)), textAlign: TextAlign.center), // Teks judul form
              const SizedBox(height: 8), // Jarak spasi teks
              Text('Silakan login untuk menikmati semua layanan Pharmacare', style: TextStyle(fontSize: 13, color: Colors.grey[600]), textAlign: TextAlign.center), // Deskripsi bantuan login
              const SizedBox(height: 32), // Jarak sebelum input fields
              
              // Kolom Input Email
              TextField(
                controller: _emailController, // Hubungkan ke controller email
                keyboardType: TextInputType.emailAddress, // Keyboard dengan format email khusus (@ dan .com)
                decoration: InputDecoration(
                  labelText: "Email", // Label nama input
                  hintText: "Contoh: user@email.com", // Contoh input teks bantu
                  prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFF1E88E5)), // Ikon surat di kiri kolom
                  filled: true, fillColor: Colors.grey[50], // Latar belakang abu-abu sangat terang
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)), // Desain border melengkung
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)), // Desain border saat tidak aktif
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF1E88E5), width: 2)), // Desain border saat aktif terpilih
                ),
              ),
              const SizedBox(height: 16), // Jarak antar input field
              
              // Kolom Input Password
              TextField(
                controller: _passwordController, // Hubungkan ke controller password
                obscureText: true, // Menyembunyikan inputan teks menjadi lingkaran rahasia
                decoration: InputDecoration(
                  labelText: "Password", // Label nama input
                  hintText: "Masukkan password Anda", // Contoh input teks bantu
                  prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF1E88E5)), // Ikon gembok rahasia di kiri kolom
                  filled: true, fillColor: Colors.grey[50], // Latar belakang abu-abu terang
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)), // Desain border melengkung
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)), // Desain border saat tidak aktif
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF1E88E5), width: 2)), // Desain border saat aktif terpilih
                ),
              ),
              const SizedBox(height: 32), // Jarak sebelum tombol submit
              
              // Tombol Proses Masuk (Login)
              SizedBox(
                height: 50, // Tinggi tetap tombol submit
                child: ElevatedButton(
                  onPressed: _handleLogin, // Jalankan fungsi handle login ketika ditekan
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900], // Latar belakang tombol biru tua
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Sudut bulat tombol 12px
                    elevation: 0, // Tanpa bayangan tombol
                  ),
                  child: const Text("Masuk", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)), // Label tombol
                ),
              ),
              const SizedBox(height: 24), // Jarak di bawah tombol submit
              
              // Baris Navigasi Dialihkan ke Pendaftaran
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Pusatkan isi baris navigasi
                children: [
                  Text("Belum memiliki akun? ", style: TextStyle(color: Colors.grey[600], fontSize: 13)), // Teks info
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage())), // Buka halaman pendaftaran jika di-tap
                    child: const Text("Daftar Sekarang", style: TextStyle(color: Color(0xFF1E88E5), fontWeight: FontWeight.bold, fontSize: 13)), // Teks link aksi
                  ),
                ],
              ),
              const SizedBox(height: 20), // Spasi penutup di bawah halaman
            ],
          ),
        ),
      ),
    );
  }
}
