import 'package:flutter/material.dart';

// Halaman Pendaftaran/Registrasi Akun Baru Pengguna
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _namaController = TextEditingController(); // Controller untuk input Nama Lengkap
  final _emailController = TextEditingController(); // Controller untuk input Email
  final _phoneController = TextEditingController(); // Controller untuk input Nomor HP
  final _passwordController = TextEditingController(); // Controller untuk input Password

  @override
  void dispose() {
    _namaController.dispose(); // Bersihkan nama controller mencegah memory leaks
    _emailController.dispose(); // Bersihkan email controller mencegah memory leaks
    _phoneController.dispose(); // Bersihkan nomor hp controller mencegah memory leaks
    _passwordController.dispose(); // Bersihkan password controller mencegah memory leaks
    super.dispose();
  }

  // Fungsi memproses konfirmasi pendaftaran akun
  void _handleRegister() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registrasi Berhasil! Silakan Login.'), // Toast notifikasi berhasil daftar
        backgroundColor: Colors.green, // Latar belakang notifikasi hijau sukses
        behavior: SnackBarBehavior.floating, // Desain toast melayang di layar
      ),
    );
    Navigator.pop(context); // Kembali ke halaman sebelumnya (LoginPage)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang halaman putih
      appBar: AppBar(
        title: const Text('Registrasi', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)), // Teks judul halaman
        backgroundColor: Colors.white, // Latar belakang AppBar putih bersih
        elevation: 0, // Hilangkan garis bayangan AppBar
        iconTheme: const IconThemeData(color: Colors.black87), // Ikon tombol back berwarna hitam
        centerTitle: true, // Letak teks judul dipusatkan
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0), // Padding jarak tepi kiri-kanan halaman
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Lebar isi kolom meluas penuh
            children: [
              const SizedBox(height: 10), // Spasi atas
              // Gambar Ilustrasi Aset Pendaftaran
              Image.asset(
                'assets/images/dokter1.webp', // Lokasi aset ilustrasi gambar
                height: 180, fit: BoxFit.contain, // Tinggi dan pemotongan gambar presisi
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 150,
                  decoration: BoxDecoration(color: Colors.green[50], borderRadius: BorderRadius.circular(16)), // Kontainer latar cadangan hijau muda
                  child: const Icon(Icons.person_add_alt_1_rounded, size: 70, color: Colors.green), // Ikon pendaftaran pengguna
                ),
              ),
              const SizedBox(height: 24), // Spasi vertikal
              const Text('Buat Akun Baru', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50)), textAlign: TextAlign.center), // Judul form daftar
              const SizedBox(height: 8), // Spasi pemisah
              Text('Lengkapi data diri Anda untuk memulai perjalanan sehat', style: TextStyle(fontSize: 13, color: Colors.grey[600]), textAlign: TextAlign.center), // Penjelasan subform
              const SizedBox(height: 24), // Jarak sebelum input fields
              
              // Input Field Nama Lengkap
              TextField(
                controller: _namaController, // Hubungkan ke controller nama
                decoration: InputDecoration(
                  labelText: "Nama Lengkap", // Label inputan
                  hintText: "Contoh: Budi Santoso", // Petunjuk input teks bantuan
                  prefixIcon: const Icon(Icons.account_circle_outlined, color: Colors.green), // Ikon akun pengguna hijau di kiri kolom
                  filled: true, fillColor: Colors.grey[50], // Latar belakang kolom abu-abu muda
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)), // Sudut bulat border kolom
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)), // Border saat tidak aktif
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.green, width: 2)), // Border saat aktif terisi (hijau)
                ),
              ),
              const SizedBox(height: 16), // Spasi vertikal antar kolom
              
              // Input Field Email
              TextField(
                controller: _emailController, // Hubungkan ke controller email
                keyboardType: TextInputType.emailAddress, // Tipe keyboard khusus format alamat email
                decoration: InputDecoration(
                  labelText: "Email", // Label inputan
                  hintText: "Contoh: budi@email.com", // Petunjuk input teks bantu
                  prefixIcon: const Icon(Icons.email_outlined, color: Colors.green), // Ikon email di kiri kolom
                  filled: true, fillColor: Colors.grey[50], // Latar belakang abu-abu terang
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)), // Sudut bulat border kolom
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)), // Border saat tidak aktif
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.green, width: 2)), // Border saat aktif terisi (hijau)
                ),
              ),
              const SizedBox(height: 16), // Spasi vertikal antar kolom
              
              // Input Field Nomor Handphone
              TextField(
                controller: _phoneController, // Hubungkan ke controller no hp
                keyboardType: TextInputType.phone, // Tipe keyboard numerik khusus nomor telepon
                decoration: InputDecoration(
                  labelText: "No. Hp", // Label nama inputan
                  hintText: "Contoh: 08123456789", // Petunjuk input teks bantu
                  prefixIcon: const Icon(Icons.phone_outlined, color: Colors.green), // Ikon HP di kiri kolom
                  filled: true, fillColor: Colors.grey[50], // Latar belakang abu-abu terang
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)), // Sudut bulat border kolom
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)), // Border saat tidak aktif
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.green, width: 2)), // Border saat aktif terisi (hijau)
                ),
              ),
              const SizedBox(height: 16), // Spasi vertikal antar kolom
              
              // Input Field Kata Sandi (Password)
              TextField(
                controller: _passwordController, // Hubungkan ke controller password
                obscureText: true, // Menyembunyikan tampilan teks menjadi sandi bulat rahasia
                decoration: InputDecoration(
                  labelText: "Password", // Label nama inputan
                  hintText: "Masukkan password minimal 6 karakter", // Petunjuk masukan teks bantu
                  prefixIcon: const Icon(Icons.lock_outline, color: Colors.green), // Ikon gembok sandi di kiri kolom
                  filled: true, fillColor: Colors.grey[50], // Latar belakang abu-abu terang
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)), // Sudut bulat border kolom
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)), // Border saat tidak aktif
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.green, width: 2)), // Border saat aktif terisi (hijau)
                ),
              ),
              const SizedBox(height: 32), // Jarak sebelum tombol pendaftaran
              
              // Tombol Proses Pendaftaran (Daftar)
              SizedBox(
                height: 50, // Tinggi tetap tombol submit
                child: ElevatedButton(
                  onPressed: _handleRegister, // Jalankan fungsi pendaftaran ketika ditekan
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Latar belakang warna hijau sukses
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Sudut bulat tombol 12px
                    elevation: 0, // Tanpa bayangan tombol
                  ),
                  child: const Text("Daftar", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)), // Label teks tombol
                ),
              ),
              const SizedBox(height: 24), // Jarak di bawah tombol submit
              
              // Baris Navigasi Dialihkan ke Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Pusatkan isi kolom baris navigasi
                children: [
                  Text("Sudah memiliki akun? ", style: TextStyle(color: Colors.grey[600], fontSize: 13)), // Teks info bantuan
                  GestureDetector(
                    onTap: () => Navigator.pop(context), // Menutup halaman registrasi (kembali ke Login) jika di-tap
                    child: const Text("Login Di Sini", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13)), // Teks tautan balik
                  ),
                ],
              ),
              const SizedBox(height: 20), // Spasi penutup di paling bawah halaman
            ],
          ),
        ),
      ),
    );
  }
}
