import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';

// Halaman Riwayat Pemesanan Obat Pengguna
class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Jumlah kategori tab di halaman order (2 tab)
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900], // Latar belakang AppBar biru tua
          title: const Text('Pesanan Saya', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)), // Judul halaman
          bottom: const TabBar(
            labelColor: Colors.white, // Warna tab aktif putih
            unselectedLabelColor: Colors.white70, // Warna tab tidak aktif putih transparan
            indicatorColor: Colors.white, // Garis penunjuk tab aktif berwarna putih
            tabs: [
              Tab(text: 'Dalam Proses'), // Judul tab pertama
              Tab(text: 'Riwayat Selesai'), // Judul tab kedua
            ],
          ),
        ),
        body: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            // Membagi riwayat transaksi berdasarkan status pemrosesan aktif/selesai
            final activeOrders = cartProvider.orders.where((order) => order['isCompleted'] == false).toList();
            final completedOrders = cartProvider.orders.where((order) => order['isCompleted'] == true).toList();

            return TabBarView(
              children: [
                _buildOrdersList(context, activeOrders, 'Belum ada pesanan aktif.', Icons.hourglass_empty), // Tab daftar pesanan proses
                _buildOrdersList(context, completedOrders, 'Belum ada riwayat pesanan.', Icons.history), // Tab daftar pesanan selesai
              ],
            );
          },
        ),
      ),
    );
  }

  // Membuat daftar list transaksi pemesanan
  Widget _buildOrdersList(BuildContext context, List<Map<String, dynamic>> orders, String emptyMessage, IconData emptyIcon) {
    if (orders.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0), // Padding wadah pesan kosong
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Pusatkan isi kolom secara vertikal
            children: [
              Icon(emptyIcon, size: 80, color: Colors.grey[300]), // Ikon penanda data kosong
              const SizedBox(height: 16), // Jarak pemisah vertikal
              Text(emptyMessage, style: TextStyle(fontSize: 16, color: Colors.grey[600], fontWeight: FontWeight.w500), textAlign: TextAlign.center), // Teks pesan kosong
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12.0), // Padding di luar daftar riwayat order
      itemCount: orders.length, // Total jumlah transaksi order dalam daftar saat ini
      itemBuilder: (context, index) {
        final order = orders[index]; // Mengambil catatan transaksi order saat ini
        return Card(
          elevation: 2, // Bayangan efek kartu order
          margin: const EdgeInsets.only(bottom: 12.0), // Jarak pemisah vertikal antar kartu order
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Sudut bulat kartu order
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Padding dalam kartu riwayat order
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri isi kolom kartu
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Sejajarkan ID transaksi kiri dan status kanan jauh
                  children: [
                    Text(order['id'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), // ID Transaksi
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), // Padding dalam badge status
                      decoration: BoxDecoration(color: (order['color'] as Color).withValues(alpha: 0.15), borderRadius: BorderRadius.circular(20)), // Latar badge transparan sewarna teks status
                      child: Text(order['status'] as String, style: TextStyle(color: order['color'] as Color, fontWeight: FontWeight.bold, fontSize: 12)), // Teks status transaksi
                    ),
                  ],
                ),
                const Divider(height: 20), // Garis pembatas horizontal di dalam kartu
                Text(order['tanggal'] as String, style: TextStyle(color: Colors.grey[600], fontSize: 13)), // Tanggal order dilakukan
                const SizedBox(height: 8), // Jarak pemisah vertikal
                Text(order['obat'] as String, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)), // Nama dan kuantitas produk obat terpesan
                const SizedBox(height: 12), // Jarak pemisah vertikal
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Sejajarkan label total kiri dan nominal kanan jauh
                  children: [
                    const Text('Total Pembayaran', style: TextStyle(color: Colors.grey)), // Label total
                    Text(order['total'] as String, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[900], fontSize: 16)), // Nominal harga total pembayaran
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
