import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import 'checkout_confirm_page.dart';


class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Keranjang Belanja', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) => cartProvider.items.isEmpty 
            ? _buildEmptyCart(context)
            : _buildCartList(context, cartProvider),
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cartProvider, child) => cartProvider.items.isEmpty 
            ? const SizedBox.shrink()
            : _buildCheckoutBar(context, cartProvider),
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.blue[200]),
          const SizedBox(height: 24),
          const Text('Keranjang Anda Kosong', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Silakan pilih obat kebutuhan Anda di halaman Beranda.', style: TextStyle(fontSize: 16, color: Colors.grey[600]), textAlign: TextAlign.center),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[900],
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Mulai Belanja', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    ),
  );

  Widget _buildCartList(BuildContext context, CartProvider cartProvider) => ListView.builder(
    padding: const EdgeInsets.all(12.0),
    itemCount: cartProvider.items.length,
    itemBuilder: (context, index) {
      final item = cartProvider.items[index];
      return Card(
        elevation: 2,
        margin: const EdgeInsets.only(bottom: 12.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  item.foto,
                  width: 70, height: 70, fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 70, height: 70, color: Colors.blue[50],
                    child: const Icon(Icons.medication, size: 35, color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.judul, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Text(item.harga, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 14)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildQuantityButton(icon: Icons.remove, onPressed: () => cartProvider.decrementQuantity(item.judul)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('${item.quantity}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                        _buildQuantityButton(icon: Icons.add, onPressed: () => cartProvider.incrementQuantity(item.judul)),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () => cartProvider.removeItem(item.judul),
              ),
            ],
          ),
        ),
      );
    },
  );

  Widget _buildQuantityButton({required IconData icon, required VoidCallback onPressed}) => Container(
    width: 32, height: 32,
    decoration: BoxDecoration(color: Colors.blue[50], shape: BoxShape.circle),
    child: IconButton(
      padding: EdgeInsets.zero,
      iconSize: 18,
      icon: Icon(icon, color: Colors.blue[900]),
      onPressed: onPressed,
    ),
  );

  Widget _buildCheckoutBar(BuildContext context, CartProvider cartProvider) => Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.2), spreadRadius: 1, blurRadius: 5, offset: const Offset(0, -2))],
    ),
    child: SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Total Tagihan', style: TextStyle(color: Colors.grey, fontSize: 14)),
              const SizedBox(height: 4),
              Text(cartProvider.totalPriceFormatted, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[900])),
            ],
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CheckoutConfirmPage())),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Checkout', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    ),
  );
}
