import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../cart/cart_page.dart';

// Halaman Detail Informasi Produk Obat
class DetailObatPage extends StatelessWidget {
  final String judul; // Nama obat
  final String harga; // Harga obat
  final String foto; // Lokasi gambar obat
  final String kategori; // Kategori obat
  final String deskripsi; // Deskripsi produk obat

  const DetailObatPage({
    super.key,
    required this.judul,
    required this.harga,
    required this.foto,
    required this.kategori,
    required this.deskripsi,
  });

  // Menentukan warna latar belakang badge berdasarkan kategori obat
  Color _getBadgeBgColor() {
    switch (kategori.toLowerCase()) {
      case 'resep': return const Color(0xFFFFEBEE); // Merah muda untuk obat resep
      case 'bebas': return const Color(0xFFE8F5E9); // Hijau muda untuk obat bebas
      case 'vitamin': return const Color(0xFFFFF8E1); // Kuning muda untuk vitamin
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
    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang putih halaman detail
      appBar: AppBar(
        backgroundColor: Colors.blue[900], // AppBar biru tua
        title: const Text('Detail Obat', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)), // Judul AppBar
        iconTheme: const IconThemeData(color: Colors.white), // Tombol back berwarna putih
        elevation: 0, // Hilangkan bayangan AppBar
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Ratakan konten ke kiri
          children: [
            // Bagian Tampilan Gambar Produk Besar
            Container(
              width: double.infinity, // Mengisi lebar layar penuh
              height: 250, // Tinggi area gambar
              color: const Color(0xFFF9F9F9), // Latar belakang abu-abu terang gambar
              child: Image.asset(
                foto, // Aset file gambar obat
                fit: BoxFit.contain, // Gambar dimuat utuh di dalam kontainer
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFFEBF3FC), // Latar cadangan biru jika gambar error
                  child: const Icon(Icons.medication_liquid_rounded, size: 80, color: Color(0xFF1E88E5)), // Ikon medis cadangan
                ),
              ),
            ),
            
            // Area Detail Informasi Teks
            Padding(
              padding: const EdgeInsets.all(20.0), // Jarak di dalam area deskripsi teks
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri konten informasi obat
                children: [
                  // Badge Kategori Obat
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), // Padding badge
                    decoration: BoxDecoration(color: _getBadgeBgColor(), borderRadius: BorderRadius.circular(6)), // Latar & sudut badge
                    child: Text(
                      kategori, // Label kategori
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _getBadgeTextColor()), // Gaya teks badge
                    ),
                  ),
                  const SizedBox(height: 12), // Jarak pemisah vertikal
                  
                  // Nama Produk Obat
                  Text(
                    judul, // Nama obat
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50), height: 1.3), // Gaya teks judul besar
                  ),
                  const SizedBox(height: 8), // Jarak pemisah vertikal
                  
                  // Harga Produk Obat
                  Text(
                    harga, // Harga obat rupiah
                    style: const TextStyle(fontSize: 22, color: Color(0xFF2E7D32), fontWeight: FontWeight.bold), // Gaya teks harga tebal hijau
                  ),
                  const Divider(height: 32), // Garis batas pemisah horizontal abu-abu
                  
                  // Judul Bagian Deskripsi
                  const Text(
                    'Deskripsi Produk', // Penanda judul deskripsi
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50)), // Gaya teks judul bagian
                  ),
                  const SizedBox(height: 8), // Jarak di bawah judul deskripsi
                  
                  // Isi Teks Deskripsi
                  Text(
                    deskripsi, // Narasi deskripsi detail obat
                    style: TextStyle(fontSize: 14, color: Colors.grey[800], height: 1.6), // Gaya teks isi paragraf
                  ),
                  const SizedBox(height: 24), // Jarak pemisah penutup di bawah
                ],
              ),
            ),
          ],
        ),
      ),
      
      // Bagian Tombol Aksi di Bawah (Keranjang dan Beli/Pesan)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0), // Jarak padding di dalam bar tombol
        decoration: BoxDecoration(
          color: Colors.white, // Latar belakang bar putih
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05), // Bayangan halus pembatas
              blurRadius: 10, // Efek sebaran blur bayangan
              offset: const Offset(0, -4), // Arah bayangan ke atas
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              // Tombol Tambah ke Keranjang Belanja
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Tambah data obat ini ke CartProvider
                    Provider.of<CartProvider>(context, listen: false).addToCart({
                      'judul': judul,
                      'harga': harga,
                      'foto': foto,
                      'kategori': kategori,
                    });
                    ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Tutup snackbar yang sedang tampil
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$judul ditambahkan ke keranjang!'), // Pesan sukses tambah keranjang
                        behavior: SnackBarBehavior.floating, // Bentuk melayang
                        backgroundColor: const Color(0xFF1E88E5), // Latar belakang biru
                        duration: const Duration(milliseconds: 1500), // Tampil 1.5 detik
                      ),
                    );
                  },
                  icon: const Icon(Icons.add_shopping_cart, color: Color(0xFF1E88E5), size: 18), // Ikon keranjang
                  label: const Text("Keranjang", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E88E5))), // Label tombol
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14), // Ukuran tombol tinggi
                    side: const BorderSide(color: Color(0xFF1E88E5), width: 1.5), // Garis pembatas luar biru
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Sudut bulat tombol 12px
                  ),
                ),
              ),
              const SizedBox(width: 12), // Spasi pemisah horizontal antar tombol
              
              // Tombol Pesan Langsung (Beli Sekarang)
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Tambahkan data obat ke CartProvider
                    Provider.of<CartProvider>(context, listen: false).addToCart({
                      'judul': judul,
                      'harga': harga,
                      'foto': foto,
                      'kategori': kategori,
                    });
                    // Navigasi langsung ke halaman keranjang belanja
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CartPage()),
                    );
                  },
                  icon: const Icon(Icons.shopping_bag, color: Colors.white, size: 18), // Ikon tas belanja
                  label: const Text("Pesan", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)), // Label tombol
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900], // Latar belakang biru tua
                    padding: const EdgeInsets.symmetric(vertical: 14), // Ukuran tombol tinggi
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Sudut bulat tombol 12px
                    elevation: 0, // Tanpa bayangan tombol
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
