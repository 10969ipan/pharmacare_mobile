import 'package:flutter/material.dart';
import './tombol_pesan.dart';

// Widget Kartu Tampilan Produk Obat
class ObatCard extends StatelessWidget {
  final String judul; // Nama obat
  final String harga; // Harga obat
  final String foto; // Alamat gambar obat
  final String kategori; // Kategori jenis obat

  const ObatCard({
    super.key,
    required this.judul,
    required this.harga,
    required this.foto,
    required this.kategori,
  });

  // Menentukan warna latar belakang badge berdasarkan kategori obat
  Color _getBadgeBgColor() {
    switch (kategori.toLowerCase()) {
      case 'resep': return const Color(0xFFFFEBEE); // Merah muda untuk obat resep
      case 'bebas': return const Color(0xFFE8F5E9); // Hijau muda untuk obat bebas
      case 'vitamin': return const Color(0xFFFFF8E1); // Kuning muda untuk suplemen vitamin
      case 'pereda nyeri': return const Color(0xFFE3F2FD); // Biru muda untuk pereda nyeri
      case 'herbal': return const Color(0xFFE0F2F1); // Teal muda untuk obat herbal
      default: return const Color(0xFFF5F5F5); // Abu-abu muda bawaan
    }
  }

  // Menentukan warna teks badge berdasarkan kategori obat
  Color _getBadgeTextColor() {
    switch (kategori.toLowerCase()) {
      case 'resep': return const Color(0xFFC62828); // Merah tua
      case 'bebas': return const Color(0xFF2E7D32); // Hijau tua
      case 'vitamin': return const Color(0xFFF57F17); // Kuning tua
      case 'pereda nyeri': return const Color(0xFF1565C0); // Biru tua
      case 'herbal': return const Color(0xFF00695C); // Teal tua
      default: return const Color(0xFF616161); // Abu-abu tua
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Latar belakang putih kartu
        borderRadius: BorderRadius.circular(16), // Sudut bulat kartu
        border: Border.all(color: const Color(0xFFEEEEEE), width: 1.5), // Garis pembatas kartu
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Meratakan konten ke kiri
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)), // Sudut bulat gambar atas saja
                  child: Image.asset(
                    foto, // Memuat file gambar obat
                    width: double.infinity, // Lebar penuh menyesuaikan kartu
                    fit: BoxFit.cover, // Gambar dipotong presisi memenuhi area
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: const Color(0xFFEBF3FC), // Latar cadangan jika gambar gagal dimuat
                      child: const Center(child: Icon(Icons.medication_liquid_rounded, size: 44, color: Color(0xFF1E88E5))), // Ikon cadangan obat
                    ),
                  ),
                ),
                Positioned(
                  top: 8, // Jarak badge dari batas atas
                  left: 8, // Jarak badge dari batas kiri
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Padding dalam badge kategori
                    decoration: BoxDecoration(color: _getBadgeBgColor(), borderRadius: BorderRadius.circular(6)), // Latar & sudut badge
                    child: Text(kategori, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: _getBadgeTextColor())), // Label kategori
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0), // Jarak dalam bagian info teks
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri info teks
              children: [
                Text(judul, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50), height: 1.3), maxLines: 2, overflow: TextOverflow.ellipsis), // Nama produk (max 2 baris)
                const SizedBox(height: 4), // Spasi vertikal
                Text(harga, style: const TextStyle(fontSize: 14, color: Color(0xFF2E7D32), fontWeight: FontWeight.w700)), // Harga obat
                const SizedBox(height: 8), // Spasi vertikal
                TombolPesan(obat: {'judul': judul, 'harga': harga, 'foto': foto, 'kategori': kategori}), // Tombol untuk memesan obat
              ],
            ),
          ),
        ],
      ),
    );
  }
}
