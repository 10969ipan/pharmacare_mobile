import 'package:flutter/material.dart';
import './tombol_pesan.dart';
import './detail_obat_page.dart';

class ObatCard extends StatelessWidget {
  final String judul;
  final String harga;
  final String foto;
  final String kategori;
  final String deskripsi;

  const ObatCard({
    super.key,
    required this.judul,
    required this.harga,
    required this.foto,
    required this.kategori,
    required this.deskripsi,
  });

  Color _getBadgeBgColor() {
    switch (kategori.toLowerCase()) {
      case 'resep': return const Color(0xFFFFEBEE);
      case 'bebas': return const Color(0xFFE8F5E9);
      case 'vitamin': return const Color(0xFFFFF8E1);
      case 'pereda nyeri': return const Color(0xFFE3F2FD);
      case 'herbal': return const Color(0xFFE0F2F1);
      default: return const Color(0xFFF5F5F5);
    }
  }

  Color _getBadgeTextColor() {
    switch (kategori.toLowerCase()) {
      case 'resep': return const Color(0xFFC62828);
      case 'bebas': return const Color(0xFF2E7D32);
      case 'vitamin': return const Color(0xFFF57F17);
      case 'pereda nyeri': return const Color(0xFF1565C0);
      case 'herbal': return const Color(0xFF00695C);
      default: return const Color(0xFF616161);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailObatPage(
                      judul: judul,
                      harga: harga,
                      foto: foto,
                      kategori: kategori,
                      deskripsi: deskripsi,
                    ),
                  ),
                );
              },
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)),
                    child: Image.asset(
                      foto,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: const Color(0xFFEBF3FC),
                        child: const Center(child: Icon(Icons.medication_liquid_rounded, size: 44, color: Color(0xFF1E88E5))),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: _getBadgeBgColor(), borderRadius: BorderRadius.circular(6)),
                      child: Text(kategori, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: _getBadgeTextColor())),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(judul, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50), height: 1.3), maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(harga, style: const TextStyle(fontSize: 14, color: Color(0xFF2E7D32), fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                TombolPesan(obat: {'judul': judul, 'harga': harga, 'foto': foto, 'kategori': kategori}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
