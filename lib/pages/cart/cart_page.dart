import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';

// Halaman Keranjang Belanjaan Pengguna
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900], // Latar belakang AppBar biru tua
        title: const Text('Keranjang Belanja', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)), // Judul halaman
        iconTheme: const IconThemeData(color: Colors.white), // Tombol back berwarna putih
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          // Menampilkan halaman kosong jika tidak ada item belanjaan
          if (cartProvider.items.isEmpty) return _buildEmptyCart(context);
          return _buildCartList(context, cartProvider); // Menampilkan daftar item belanjaan
        },
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          // Bottom bar hanya tampil jika keranjang belanja berisi item
          if (cartProvider.items.isEmpty) return const SizedBox.shrink();
          return _buildCheckoutBar(context, cartProvider); // Bar aksi checkout total belanjaan
        },
      ),
    );
  }

  // Tampilan halaman ketika keranjang belanja masih kosong
  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0), // Padding wadah pesan kosong
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Pusatkan konten secara vertikal
          children: [
            Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.blue[200]), // Ikon keranjang kosong
            const SizedBox(height: 24), // Spasi pemisah vertikal
            const Text('Keranjang Anda Kosong', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), // Pesan utama kosong
            const SizedBox(height: 8), // Spasi pemisah vertikal
            Text('Silakan pilih obat kebutuhan Anda di halaman Beranda.', style: TextStyle(fontSize: 16, color: Colors.grey[600]), textAlign: TextAlign.center), // Petunjuk belanja
            const SizedBox(height: 32), // Spasi pemisah vertikal
            ElevatedButton(
              onPressed: () => Navigator.pop(context), // Kembali ke beranda
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900], // Latar belakang tombol biru tua
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Ukuran padding tombol
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // Sudut bulat tombol
              ),
              child: const Text('Mulai Belanja', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)), // Teks tombol belanja
            ),
          ],
        ),
      ),
    );
  }

  // Membangun daftar item obat yang dimasukkan ke keranjang belanja
  Widget _buildCartList(BuildContext context, CartProvider cartProvider) {
    return ListView.builder(
      padding: const EdgeInsets.all(12.0), // Padding di luar daftar item
      itemCount: cartProvider.items.length, // Total jumlah jenis obat di keranjang
      itemBuilder: (context, index) {
        final item = cartProvider.items[index]; // Data item obat saat ini
        return Card(
          elevation: 2, // Efek bayangan kartu item
          margin: const EdgeInsets.only(bottom: 12.0), // Jarak antar kartu item
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Sudut melengkung kartu
          child: Padding(
            padding: const EdgeInsets.all(12.0), // Padding isi di dalam kartu
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0), // Sudut bulat gambar obat
                  child: Image.asset(
                    item.foto, // Lokasi gambar aset obat
                    width: 70, height: 70, fit: BoxFit.cover, // Dimensi & pemotongan gambar
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 70, height: 70, color: Colors.blue[50], // Latar cadangan biru muda
                      child: const Icon(Icons.medication, size: 35, color: Colors.blue), // Ikon cadangan obat
                    ),
                  ),
                ),
                const SizedBox(width: 12), // Spasi horizontal
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri informasi teks obat
                    children: [
                      Text(item.judul, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), maxLines: 1, overflow: TextOverflow.ellipsis), // Nama obat
                      const SizedBox(height: 4), // Spasi pemisah vertikal
                      Text(item.harga, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 14)), // Harga satuan obat
                      const SizedBox(height: 8), // Spasi pemisah vertikal
                      Row(
                        children: [
                          _buildQuantityButton(icon: Icons.remove, onPressed: () => cartProvider.decrementQuantity(item.judul)), // Tombol minus kuantitas
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0), // Jarak kiri-kanan angka kuantitas
                            child: Text('${item.quantity}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), // Jumlah kuantitas obat
                          ),
                          _buildQuantityButton(icon: Icons.add, onPressed: () => cartProvider.incrementQuantity(item.judul)), // Tombol plus kuantitas
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red), // Tombol ikon hapus item obat
                  onPressed: () => cartProvider.removeItem(item.judul), // Hapus item tersebut dari keranjang
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Membuat tombol pengubah kuantitas bulat kecil (+ atau -)
  Widget _buildQuantityButton({required IconData icon, required VoidCallback onPressed}) {
    return Container(
      width: 32, height: 32, // Dimensi bulat
      decoration: BoxDecoration(color: Colors.blue[50], shape: BoxShape.circle), // Latar bulat biru muda
      child: IconButton(
        padding: EdgeInsets.zero, // Hilangkan padding internal default
        iconSize: 18, // Ukuran ikon kecil
        icon: Icon(icon, color: Colors.blue[900]), // Visual ikon plus/minus
        onPressed: onPressed, // Jalankan fungsi pengurang/penambah
      ),
    );
  }

  // Baris informasi total tagihan dan tombol penyelesaian belanja di bawah
  Widget _buildCheckoutBar(BuildContext context, CartProvider cartProvider) {
    return Container(
      padding: const EdgeInsets.all(16.0), // Padding di dalam bar checkout
      decoration: BoxDecoration(
        color: Colors.white, // Latar belakang putih bar
        boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.2), spreadRadius: 1, blurRadius: 5, offset: const Offset(0, -2))], // Bayangan ke arah atas
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Sejajarkan teks kiri dan tombol checkout kanan
          children: [
            Column(
              mainAxisSize: MainAxisSize.min, // Tinggi menyesuaikan konten
              crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri teks info harga
              children: [
                const Text('Total Tagihan', style: TextStyle(color: Colors.grey, fontSize: 14)), // Teks label info harga
                const SizedBox(height: 4), // Jarak pemisah vertikal
                Text(cartProvider.totalPriceFormatted, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[900])), // Angka total rupiah terformat
              ],
            ),
            ElevatedButton(
              onPressed: () => _checkout(context, cartProvider), // Jalankan proses penyelesaian belanja
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Warna tombol checkout hijau sukses
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12), // Ukuran tombol checkout
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // Sudut bulat tombol
              ),
              child: const Text('Checkout', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)), // Label tombol
            ),
          ],
        ),
      ),
    );
  }

  // Menampilkan dialog pesan penyelesaian transaksi belanja
  void _checkout(BuildContext context, CartProvider cartProvider) {
    showDialog(
      context: context, // Informasi konteks navigasi layar saat ini
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Checkout Berhasil'), // Judul dialog notifikasi
          content: const Text('Terima kasih! Pesanan obat Anda telah diterima dan sedang diproses.'), // Isi deskripsi notifikasi
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Menutup jendela dialog pop-up
                cartProvider.checkoutCart(); // Melakukan konfirmasi pemesanan dan kosongkan keranjang
                Navigator.pop(context); // Kembali ke halaman Beranda utama
              },
              child: const Text('Selesai', style: TextStyle(fontWeight: FontWeight.bold)), // Tombol aksi penutup dialog
            ),
          ],
        );
      },
    );
  }
}
