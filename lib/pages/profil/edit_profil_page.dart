import 'package:flutter/material.dart';

// Halaman Ubah Profil Pengguna
class EditProfilPage extends StatefulWidget {
  const EditProfilPage({super.key});

  @override
  State<EditProfilPage> createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  final _namaController = TextEditingController(text: 'Irfan Arfian Kusnadi'); // Controller nama
  final _emailController = TextEditingController(text: 'irfan.kusnadi@email.com'); // Controller email
  final _phoneController = TextEditingController(text: '+62 812-3456-7890'); // Controller no HP

  @override
  void dispose() {
    _namaController.dispose(); // Hapus controller nama
    _emailController.dispose(); // Hapus controller email
    _phoneController.dispose(); // Hapus controller no hp
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Latar putih
      appBar: AppBar(
        backgroundColor: Colors.blue[900], // AppBar biru tua
        title: const Text('Ubah Profil', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)), // Judul halaman
        iconTheme: const IconThemeData(color: Colors.white), // Tombol back putih
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0), // Padding dalam form
        child: Column(
          children: [
            // Area Foto Profil dengan tombol edit kamera
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: const AssetImage('assets/images/dokter.webp'), // Gambar profile saat ini
                    backgroundColor: Colors.blue[50], // Latar warna cadangan
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6), // Jarak di dalam bulat kamera
                      decoration: const BoxDecoration(color: Color(0xFF1E88E5), shape: BoxShape.circle), // Latar bulat biru kamera
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 16), // Ikon kamera
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32), // Spasi di bawah avatar
            // Input Nama Lengkap
            TextField(
              controller: _namaController, // Hubungkan controller
              decoration: const InputDecoration(
                labelText: "Nama Lengkap",
                prefixIcon: Icon(Icons.person_outline, color: Color(0xFF1E88E5)),
                border: OutlineInputBorder(), // Garis tepi kotak penuh
              ),
            ),
            const SizedBox(height: 16), // Spasi pemisah
            // Input Email
            TextField(
              controller: _emailController, // Hubungkan controller
              decoration: const InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF1E88E5)),
                border: OutlineInputBorder(), // Garis tepi kotak penuh
              ),
            ),
            const SizedBox(height: 16), // Spasi pemisah
            // Input No. Hp
            TextField(
              controller: _phoneController, // Hubungkan controller
              decoration: const InputDecoration(
                labelText: "No. Hp",
                prefixIcon: Icon(Icons.phone_outlined, color: Color(0xFF1E88E5)),
                border: OutlineInputBorder(), // Garis tepi kotak penuh
              ),
            ),
            const SizedBox(height: 32), // Spasi pemisah
            // Tombol Simpan Perubahan
            SizedBox(
              width: double.infinity, // Lebar penuh
              height: 48, // Tinggi tombol 48px
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Perubahan profil berhasil disimpan!'), backgroundColor: Colors.green), // Notifikasi sukses simpan
                  );
                  Navigator.pop(context); // Kembali ke halaman sebelumnya
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900], // Latar belakang biru tua
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Bulat sudut 8px
                ),
                child: const Text('Simpan Perubahan', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)), // Label tombol
              ),
            ),
          ],
        ),
      ),
    );
  }
}
