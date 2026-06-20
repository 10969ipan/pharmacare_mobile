import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: const Text('Pesanan Saya', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Dalam Proses'),
              Tab(text: 'Riwayat Selesai'),
            ],
          ),
        ),
        body: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            final activeOrders = cartProvider.orders.where((order) => order['isCompleted'] == false).toList();
            final completedOrders = cartProvider.orders.where((order) => order['isCompleted'] == true).toList();
            return TabBarView(
              children: [
                _buildOrdersList(context, activeOrders, 'Belum ada pesanan aktif.', Icons.hourglass_empty),
                _buildOrdersList(context, completedOrders, 'Belum ada riwayat pesanan.', Icons.history),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildOrdersList(BuildContext context, List<Map<String, dynamic>> orders, String emptyMessage, IconData emptyIcon) {
    if (orders.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(emptyIcon, size: 80, color: Colors.grey[300]),
              const SizedBox(height: 16),
              Text(emptyMessage, style: TextStyle(fontSize: 16, color: Colors.grey[600], fontWeight: FontWeight.w500), textAlign: TextAlign.center),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12.0),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(order['id'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: (order['color'] as Color).withValues(alpha: 0.15), borderRadius: BorderRadius.circular(20)),
                      child: Text(order['status'] as String, style: TextStyle(color: order['color'] as Color, fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                  ],
                ),
                const Divider(height: 20),
                Text(order['tanggal'] as String, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                const SizedBox(height: 8),
                Text(order['obat'] as String, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Pembayaran', style: TextStyle(color: Colors.grey)),
                    Text(order['total'] as String, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[900], fontSize: 16)),
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
