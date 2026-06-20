import 'package:flutter/material.dart';

// Halaman Pendaftaran/Registrasi Akun Baru Pengguna
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controller input field untuk menampung data form pendaftaran secara efisien
  final _nama = TextEditingController(), _email = TextEditingController(), _phone = TextEditingController(), _pass = TextEditingController();

  @override
  void dispose() {
    // Bersihkan semua controller saat widget dihancurkan untuk menghindari kebocoran memori
    for (var c in [_nama, _email, _phone, _pass]) {
      c.dispose();
    }
    super.dispose();
  }

  // Fungsi menampilkan notifikasi sukses registrasi dan kembali ke halaman Login
  void _handleRegister() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Registrasi Berhasil! Silakan Login.'), // Toast notifikasi berhasil daftar
      backgroundColor: Colors.green, // Warna hijau tanda sukses
      behavior: SnackBarBehavior.floating, // Tampilan melayang
    ));
    Navigator.pop(context); // Kembali ke halaman sebelumnya (LoginPage)
  }

  // Helper widget untuk membuat TextField secara seragam, rapi, dan menghemat baris kode
  Widget _field(TextEditingController c, String lbl, String hint, IconData icon, {bool obscure = false, TextInputType type = TextInputType.text}) => TextField(
    controller: c, // Hubungkan controller input
    obscureText: obscure, // Sembunyikan karakter jika field password
    keyboardType: type, // Tipe keyboard masukan
    decoration: InputDecoration(
      labelText: lbl, // Label judul input
      hintText: hint, // Placeholder petunjuk teks
      prefixIcon: Icon(icon, color: Colors.green), // Ikon hijau di sebelah kiri input
      filled: true, fillColor: Colors.grey[50], // Latar belakang abu-abu halus
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)), // Border sudut melengkung default
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)), // Border saat tidak aktif
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.green, width: 2)), // Border hijau saat aktif
    ),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white, // Latar belakang putih bersih
    appBar: AppBar(
      title: const Text('Registrasi', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)), // Judul di AppBar
      backgroundColor: Colors.white, elevation: 0, centerTitle: true, // AppBar flat tanpa bayangan di tengah
      iconTheme: const IconThemeData(color: Colors.black87), // Warna ikon tombol back hitam
    ),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0), // Jarak padding tepi layar
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Konten memenuhi lebar layar
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0), // Jarak spasi vertikal teks logo
              child: const Text(
                'Pharmacare',
                textAlign: TextAlign.center, // Ratakan teks di tengah
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Color(0xFF1E88E5), // Warna logo biru keseluruhan
                ),
              ),
            ),
            const Text('Buat Akun Baru', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50)), textAlign: TextAlign.center), // Judul teks form
            const SizedBox(height: 8), // Spasi pemisah
            Text('Lengkapi data diri Anda untuk memulai perjalanan sehat', style: TextStyle(fontSize: 13, color: Colors.grey[600]), textAlign: TextAlign.center), // Penjelasan subform
            const SizedBox(height: 24), // Spasi sebelum input fields
            _field(_nama, "Nama Lengkap", "Contoh: Budi Santoso", Icons.account_circle_outlined), // Input nama lengkap
            const SizedBox(height: 16), // Spasi vertikal pemisah input
            _field(_email, "Email", "Contoh: budi@email.com", Icons.email_outlined, type: TextInputType.emailAddress), // Input email
            const SizedBox(height: 16), // Spasi vertikal pemisah input
            _field(_phone, "No. Hp", "Contoh: 08123456789", Icons.phone_outlined, type: TextInputType.phone), // Input nomor HP
            const SizedBox(height: 16), // Spasi vertikal pemisah input
            _field(_pass, "Password", "Masukkan password minimal 6 karakter", Icons.lock_outline, obscure: true), // Input password tersembunyi
            const SizedBox(height: 32), // Jarak sebelum tombol pendaftaran
            SizedBox(
              height: 50, // Tinggi tombol daftar
              child: ElevatedButton(
                onPressed: _handleRegister, // Aksi submit pendaftaran
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Warna tombol hijau sukses
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0, // Bentuk sudut bulat 12px tanpa bayangan
                ),
                child: const Text("Daftar", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)), // Teks label tombol
              ),
            ),
            const SizedBox(height: 24), // Jarak di bawah tombol submit
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Posisi baris di tengah secara horizontal
              children: [
                Text("Sudah memiliki akun? ", style: TextStyle(color: Colors.grey[600], fontSize: 13)), // Info teks pertanyaaan akun
                GestureDetector(
                  onTap: () => Navigator.pop(context), // Kembali ke Login saat di-klik
                  child: const Text("Login Di Sini", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13)), // Tautan teks login
                ),
              ],
            ),
            const SizedBox(height: 20), // Spasi terbawah
          ],
        ),
      ),
    ),
  );
}
