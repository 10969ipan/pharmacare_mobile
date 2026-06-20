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
  // Controller input field email dan password untuk menampung data input secara terpusat
  final _email = TextEditingController(), _pass = TextEditingController();

  @override
  void dispose() {
    // Menghapus controller untuk mencegah kebocoran memori saat widget tidak digunakan lagi
    for (var c in [_email, _pass]) {
      c.dispose();
    }
    super.dispose();
  }

  // Fungsi memproses aksi masuk pengguna dan mengarahkan ke halaman utama
  void _handleLogin() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MainPage()), // Pindah ke MainPage
      (route) => false, // Bersihkan tumpukan rute agar user tidak bisa back ke login
    );
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Login Berhasil! Selamat Datang.'), // Toast notifikasi selamat datang
      backgroundColor: Colors.blue, // Warna biru khas login sukses
      behavior: SnackBarBehavior.floating, // Desain toast melayang
    ));
  }

  // Helper widget pembuat field input terstandar untuk mengurangi repetisi kode
  Widget _field(TextEditingController c, String lbl, String hint, IconData icon, {bool obscure = false, TextInputType type = TextInputType.text}) => TextField(
    controller: c, // Hubungkan ke controller masukan
    obscureText: obscure, // Sembunyikan karakter jika bernilai true
    keyboardType: type, // Format tipe keyboard masukan
    decoration: InputDecoration(
      labelText: lbl, // Judul kolom input
      hintText: hint, // Placeholder petunjuk input
      prefixIcon: Icon(icon, color: const Color(0xFF1E88E5)), // Ikon pemanis biru di sisi kiri
      filled: true, fillColor: Colors.grey[50], // Latar belakang abu-abu terang
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)), // Sudut bulat melengkung border
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)), // Border saat kolom tidak aktif
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF1E88E5), width: 2)), // Border biru saat aktif terpilih
    ),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white, // Latar belakang halaman putih bersih
    appBar: AppBar(
      title: const Text('Login', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)), // Teks judul AppBar
      backgroundColor: Colors.white, elevation: 0, centerTitle: true, // Flat design AppBar di tengah
      iconTheme: const IconThemeData(color: Colors.black87), // Warna ikon back hitam pekat
    ),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0), // Padding di tepi layar kiri dan kanan
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Konten kolom memenuhi lebar layar
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0), // Jarak spasi vertikal teks logo
              child: RichText(
                textAlign: TextAlign.center, // Ratakan teks di tengah
                text: const TextSpan(
                  style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold, letterSpacing: 1.2), // Gaya teks dasar logo
                  children: [
                    TextSpan(text: 'Pharma', style: TextStyle(color: Color(0xFF1E88E5))), // Suku kata Pharma berwarna biru
                    TextSpan(text: 'care', style: TextStyle(color: Colors.green)), // Suku kata care berwarna hijau
                  ],
                ),
              ),
            ),
            const Text('Masuk ke Akun Anda', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50)), textAlign: TextAlign.center), // Judul teks form login
            const SizedBox(height: 8), // Jarak spasi vertikal subjudul
            Text('Silakan login untuk menikmati semua layanan Pharmacare', style: TextStyle(fontSize: 13, color: Colors.grey[600]), textAlign: TextAlign.center), // Deskripsi bantuan subform
            const SizedBox(height: 32), // Jarak sebelum input fields
            _field(_email, "Email", "Contoh: user@email.com", Icons.email_outlined, type: TextInputType.emailAddress), // Kolom input email
            const SizedBox(height: 16), // Spasi antar kolom input
            _field(_pass, "Password", "Masukkan password Anda", Icons.lock_outline, obscure: true), // Kolom input password
            const SizedBox(height: 32), // Jarak sebelum tombol submit masuk
            SizedBox(
              height: 50, // Tinggi tetap tombol masuk
              child: ElevatedButton(
                onPressed: _handleLogin, // Aksi handle masuk aplikasi
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900], // Latar belakang tombol biru tua
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0, // Sudut tombol bulat 12px tanpa bayangan
                ),
                child: const Text("Masuk", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)), // Teks tombol label masuk
              ),
            ),
            const SizedBox(height: 24), // Jarak di bawah tombol
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Pusatkan isi baris navigasi
              children: [
                Text("Belum memiliki akun? ", style: TextStyle(color: Colors.grey[600], fontSize: 13)), // Info teks penjelas
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage())), // Buka RegisterPage jika di-tap
                  child: const Text("Daftar Sekarang", style: TextStyle(color: Color(0xFF1E88E5), fontWeight: FontWeight.bold, fontSize: 13)), // Tautan daftar akun baru
                ),
              ],
            ),
            const SizedBox(height: 20), // Spasi penutup bagian paling bawah
          ],
        ),
      ),
    ),
  );
}
