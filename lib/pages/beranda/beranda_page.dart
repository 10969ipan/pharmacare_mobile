import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../cart/cart_page.dart';
import './search_field.dart';
import './obat_list.dart';
import './obat_card.dart';

// Halaman Utama/Beranda Aplikasi Pharmacare
class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  String _searchQuery = ''; // Menyimpan kata kunci pencarian dari pengguna
  String _selectedCategory = 'Semua'; // Kategori obat terpilih untuk filter aktif

  // Daftar kategori obat yang ditampilkan pada menu pil filter
  final List<String> _categories = ['Semua', 'Resep', 'Bebas', 'Vitamin', 'Pereda Nyeri', 'Herbal'];

  @override
  Widget build(BuildContext context) {
    // Memproses penyaringan obat berdasarkan input cari dan kategori terpilih
    final filteredObat = obatList.where((obat) {
      final matchesSearch = (obat['judul'] as String).toLowerCase().contains(_searchQuery.toLowerCase()); // Filter nama obat
      final matchesCategory = _selectedCategory == 'Semua' || (obat['kategori'] as String).toLowerCase() == _selectedCategory.toLowerCase(); // Filter kategori obat
      return matchesSearch && matchesCategory; // Mengembalikan hasil penyaringan yang sesuai kedua filter
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA), // Latar belakang abu-abu sangat terang
      appBar: AppBar(
        backgroundColor: Colors.blue[900], // Latar belakang AppBar biru gelap senada halaman lain
        elevation: 0, // Menghilangkan efek bayangan bawah AppBar
        centerTitle: false, // Menyejajarkan teks judul ke sebelah kiri (ala modern)
        title: const Text('Pharmacare', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20)), // Judul aplikasi
        actions: [
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return Padding(
                padding: const EdgeInsets.only(right: 12.0), // Jarak badge dari batas kanan layar
                child: Badge(
                  label: Text('${cartProvider.totalItemsCount}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)), // Teks jumlah item di keranjang
                  isLabelVisible: cartProvider.totalItemsCount > 0, // Badge hanya terlihat jika keranjang berisi item
                  backgroundColor: Colors.redAccent, // Warna merah cerah untuk badge jumlah
                  child: IconButton(
                    icon: const Icon(Icons.shopping_cart, color: Colors.white, size: 24), // Ikon tombol keranjang belanja
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage())), // Buka halaman keranjang belanja
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri untuk seluruh isi kolom body
            children: [
              // Bagian Header Pencarian
              Container(
                width: double.infinity, // Lebar penuh layar
                color: Colors.white, // Latar belakang putih bersih
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), // Jarak di dalam area kolom cari
                child: SearchField(onChanged: (value) => setState(() => _searchQuery = value)), // Kolom input cari dinamis
              ),
              const SizedBox(height: 16), // Spasi pemisah vertikal
              
              // Banner Promosi Spesial
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0), // Jarak kiri-kanan dari layar
                child: Container(
                  width: double.infinity, // Lebar penuh banner
                  height: 110, // Tinggi banner promosi
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.blue[700]!, Colors.blue[900]!], begin: Alignment.topLeft, end: Alignment.bottomRight), // Gradasi warna biru
                    borderRadius: BorderRadius.circular(14), // Sudut melengkung banner
                    boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4))], // Bayangan biru lembut
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0), // Jarak teks di dalam banner
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Teks rata kiri
                          mainAxisAlignment: MainAxisAlignment.center, // Pusatkan teks secara vertikal
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), // Spasi dalam label promo
                              decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(6)), // Latar kuning sudut melengkung
                              child: const Text("PROMO SEHAT", style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.black87)), // Label penanda promo
                            ),
                            const SizedBox(height: 6), // Jarak antar teks
                            const Text("Hemat Hingga 30%", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)), // Judul promo banner
                            const SizedBox(height: 2), // Jarak antar teks
                            const Text("Beli vitamin & suplemen harian Anda", style: TextStyle(fontSize: 11, color: Colors.white70)), // Subjudul deskripsi promo
                          ],
                        ),
                      ),
                      Positioned(
                        right: 20, // Jarak ikon dari kanan banner
                        top: 25, // Jarak ikon dari atas banner
                        child: Icon(Icons.health_and_safety_rounded, size: 60, color: Colors.white.withOpacity(0.18)), // Ikon logo kesehatan samar
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20), // Spasi pemisah vertikal

              // Filter Berdasarkan Kategori
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0), // Jarak kiri-kanan teks judul kategori
                child: Text('Kategori Obat', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50))), // Judul bagian kategori
              ),
              const SizedBox(height: 10), // Jarak di bawah judul kategori
              SizedBox(
                height: 36, // Tinggi barisan filter pil kategori
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, // Arah gulir horizontal (menyamping)
                  padding: const EdgeInsets.symmetric(horizontal: 16), // Jarak kiri-kanan list
                  itemCount: _categories.length, // Jumlah pil filter kategori
                  itemBuilder: (context, index) {
                    final category = _categories[index]; // Mengambil nama kategori saat ini
                    final isSelected = _selectedCategory == category; // Memeriksa apakah sedang aktif dipilih
                    return GestureDetector(
                      onTap: () => setState(() => _selectedCategory = category), // Ganti filter aktif saat di-tap
                      child: Container(
                        margin: const EdgeInsets.only(right: 8), // Jarak antar pil kategori
                        padding: const EdgeInsets.symmetric(horizontal: 16), // Padding di dalam pil kategori
                        alignment: Alignment.center, // Pusatkan teks di tengah pil
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF1E88E5) : Colors.white, // Biru jika terpilih, putih jika tidak
                          borderRadius: BorderRadius.circular(10), // Sudut bulat pil filter
                          border: Border.all(color: isSelected ? const Color(0xFF1E88E5) : const Color(0xFFEEEEEE), width: 1.5), // Garis tepi pil
                        ),
                        child: Text(category, style: TextStyle(color: isSelected ? Colors.white : Colors.grey[700], fontWeight: isSelected ? FontWeight.bold : FontWeight.w600, fontSize: 12)), // Teks kategori
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24), // Spasi pemisah vertikal

              // Bagian Judul dan Jumlah Total Hasil Rekomendasi
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0), // Jarak dari batas tepi layar
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Sejajarkan teks kiri dan kanan berjauhan
                  children: [
                    const Text('Rekomendasi Untukmu', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50))), // Teks judul bagian rekomendasi
                    Text('${filteredObat.length} Produk', style: TextStyle(fontSize: 12, color: Colors.grey[500], fontWeight: FontWeight.w600)), // Jumlah total obat tersaring
                  ],
                ),
              ),
              const SizedBox(height: 12), // Jarak di bawah judul hasil rekomendasi

              // Grid List Tampilan Produk Obat
              filteredObat.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0), // Padding dalam wadah kosong
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center, // Tengahkan isi kolom
                          children: [
                            Icon(Icons.search_off_rounded, size: 70, color: Colors.grey[300]), // Ikon hasil tidak ditemukan
                            const SizedBox(height: 12), // Jarak vertikal
                            const Text('Obat Tidak Ditemukan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50))), // Judul pesan kosong
                            const SizedBox(height: 6), // Jarak vertikal
                            Text('Kata kunci tidak cocok dengan obat apa pun di kategori $_selectedCategory.', style: TextStyle(color: Colors.grey[500], fontSize: 13), textAlign: TextAlign.center), // Penjelasan detail kosong
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Jarak luar GridView kiri-kanan
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(), // Menonaktifkan scroll independen GridView
                        shrinkWrap: true, // Ukuran grid menyesuaikan total tinggi konten di dalamnya
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Membagi layar menjadi 2 kolom produk
                          crossAxisSpacing: 14.0, // Jarak antar kolom horizontal
                          mainAxisSpacing: 14.0, // Jarak antar kartu vertikal
                          mainAxisExtent: 270, // Tinggi tetap masing-masing kartu produk
                        ),
                        itemCount: filteredObat.length, // Total data obat yang lolos saring
                        itemBuilder: (_, index) {
                          final obat = filteredObat[index]; // Mengambil data obat per baris
                          return ObatCard(judul: obat['judul'] as String, harga: obat['harga'] as String, foto: obat['foto'] as String, kategori: obat['kategori'] as String); // Merender widget kartu obat
                        },
                      ),
                    ),
              const SizedBox(height: 20), // Spasi penutup di bawah grid
            ],
          ),
        ),
      ),
    );
  }
}
