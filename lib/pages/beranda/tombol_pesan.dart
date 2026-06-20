import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';

class TombolPesan extends StatelessWidget {
  final Map<String, dynamic> obat;

  const TombolPesan({super.key, required this.obat});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 34,
      child: ElevatedButton.icon(
        onPressed: () {
          Provider.of<CartProvider>(context, listen: false).addToCart(obat);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${obat['judul']} ditambahkan!'),
              behavior: SnackBarBehavior.floating,
              backgroundColor: const Color(0xFF1E88E5),
              duration: const Duration(milliseconds: 1500),
            ),
          );
        },
        icon: const Icon(Icons.add_shopping_cart, size: 15, color: Colors.white),
        label: const Text("Pesan", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 13)),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1E88E5),
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
