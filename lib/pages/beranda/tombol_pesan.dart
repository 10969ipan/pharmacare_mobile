import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';

// Widget Tombol untuk Memesan Obat ke Keranjang
class TombolPesan extends StatelessWidget {
  final Map<String, dynamic> obat; // Data obat yang akan dipesan

  const TombolPesan({super.key, required this.obat});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Tombol memenuhi lebar kartu produk
      height: 34, // Tinggi tombol pesan
      child: ElevatedButton.icon(
        onPressed: () {
          // Menambahkan data obat ke keranjang menggunakan CartProvider
          Provider.of<CartProvider>(context, listen: false).addToCart(obat);
          ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Menyembunyikan snackbar aktif
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${obat['judul']} ditambahkan!'), // Pesan sukses tambah keranjang
              behavior: SnackBarBehavior.floating, // Desain snackbar melayang
              backgroundColor: const Color(0xFF1E88E5), // Warna latar belakang snackbar
              duration: const Duration(milliseconds: 1500), // Durasi tampil snackbar
            ),
          );
        },
        icon: const Icon(Icons.add_shopping_cart, size: 15, color: Colors.white), // Ikon tombol
        label: const Text("Pesan", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 13)), // Label tombol
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1E88E5), // Warna tombol biru
          elevation: 0, // Menghilangkan bayangan tombol
          padding: EdgeInsets.zero, // Menghilangkan padding bawaan tombol
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Sudut bulat tombol
        ),
      ),
    );
  }
}
