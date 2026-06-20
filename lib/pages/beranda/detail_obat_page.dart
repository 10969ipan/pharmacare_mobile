import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../cart/cart_page.dart';

class DetailObatPage extends StatelessWidget {
  final String judul;
  final String harga;
  final String foto;
  final String kategori;
  final String deskripsi;

  const DetailObatPage({
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Detail Obat', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 250,
              color: const Color(0xFFF9F9F9),
              child: Image.asset(
                foto,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFFEBF3FC),
                  child: const Icon(Icons.medication_liquid_rounded, size: 80, color: Color(0xFF1E88E5)),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: _getBadgeBgColor(), borderRadius: BorderRadius.circular(6)),
                    child: Text(
                      kategori,
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _getBadgeTextColor()),
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  Text(
                    judul,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50), height: 1.3),
                  ),
                  const SizedBox(height: 8),
                  
                  Text(
                    harga,
                    style: const TextStyle(fontSize: 22, color: Color(0xFF2E7D32), fontWeight: FontWeight.bold),
                  ),
                  const Divider(height: 32),
                  
                  const Text(
                    'Deskripsi Produk',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50)),
                  ),
                  const SizedBox(height: 8),
                  
                  Text(
                    deskripsi,
                    style: TextStyle(fontSize: 14, color: Colors.grey[800], height: 1.6),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
      
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false).addToCart({
                      'judul': judul,
                      'harga': harga,
                      'foto': foto,
                      'kategori': kategori,
                    });
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$judul ditambahkan ke keranjang!'),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: const Color(0xFF1E88E5),
                        duration: const Duration(milliseconds: 1500),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add_shopping_cart, color: Color(0xFF1E88E5), size: 18),
                  label: const Text("Keranjang", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E88E5))),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: Color(0xFF1E88E5), width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false).addToCart({
                      'judul': judul,
                      'harga': harga,
                      'foto': foto,
                      'kategori': kategori,
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CartPage()),
                    );
                  },
                  icon: const Icon(Icons.shopping_bag, color: Colors.white, size: 18),
                  label: const Text("Pesan", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
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
