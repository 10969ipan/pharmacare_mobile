import 'package:flutter/material.dart';

// Widget Input Pencarian Obat
class SearchField extends StatelessWidget {
  final ValueChanged<String>? onChanged; // Callback ketika teks pencarian berubah

  const SearchField({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5), // Warna latar abu-abu terang
        borderRadius: BorderRadius.circular(12), // Sudut bulat kontainer pencarian
        border: Border.all(color: const Color(0xFFE0E0E0)), // Garis pembatas kontainer
      ),
      child: TextField(
        onChanged: onChanged, // Memicu callback pencarian di halaman utama
        decoration: const InputDecoration(
          hintText: 'Cari obat, multivitamin...', // Teks petunjuk pencarian
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14), // Gaya teks petunjuk
          prefixIcon: Icon(Icons.search, color: Colors.grey, size: 22), // Ikon kaca pembesar di kiri
          border: InputBorder.none, // Menghilangkan garis bawah default TextField
          contentPadding: EdgeInsets.symmetric(vertical: 12), // Jarak vertikal di dalam kolom input
        ),
      ),
    );
  }
}
