import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';

class CheckoutConfirmPage extends StatefulWidget {
  const CheckoutConfirmPage({super.key});

  @override
  State<CheckoutConfirmPage> createState() => _CheckoutConfirmPageState();
}

class _CheckoutConfirmPageState extends State<CheckoutConfirmPage> {
  int _selectedAddressIdx = 0;
  int _selectedPaymentIdx = 0;

  final List<Map<String, String>> _daftarAlamat = [
    {
      'label': 'Rumah (Utama)',
      'penerima': 'Irfan Arfian Kusnadi (+62 812-3456-7890)',
      'alamat': 'Jl. Merdeka No. 10, Kel. Babakan Ciamis, Kec. Sumur Bandung, Kota Bandung, Jawa Barat, 40117.',
    },
    {
      'label': 'Kantor',
      'penerima': 'Irfan Arfian Kusnadi (022-4211234)',
      'alamat': 'Gedung Mediserve Lantai 3, Jl. Asia Afrika No. 45, Kota Bandung, Jawa Barat, 40111.',
    }
  ];

  final List<Map<String, dynamic>> _metodePembayaran = [
    {'name': 'GoPay E-Wallet', 'icon': Icons.wallet, 'label': 'Saldo Aktif'},
    {'name': 'Virtual Account Mandiri', 'icon': Icons.account_balance, 'label': 'Transfer VA'},
    {'name': 'Kartu Kredit Visa', 'icon': Icons.credit_card, 'label': 'Visa/Mastercard'},
    {'name': 'Bayar di Tempat (COD)', 'icon': Icons.local_shipping, 'label': 'Tunai saat tiba'},
  ];

  String _formatRupiah(int nominal) {
    final buffer = StringBuffer();
    final nomStr = nominal.toString();
    int count = 0;
    for (int i = nomStr.length - 1; i >= 0; i--) {
      buffer.write(nomStr[i]);
      count++;
      if (count % 3 == 0 && i != 0) buffer.write('.');
    }
    return 'Rp ${buffer.toString().split('').reversed.join('')}';
  }

  void _confirmCheckout(BuildContext context, CartProvider cartProvider) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Pesanan Berhasil'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Terima kasih! Pesanan Anda telah dikonfirmasi.', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text('Alamat: ${_daftarAlamat[_selectedAddressIdx]['label']}', style: const TextStyle(fontSize: 13, color: Colors.grey)),
            Text('Metode: ${_metodePembayaran[_selectedPaymentIdx]['name']}', style: const TextStyle(fontSize: 13, color: Colors.grey)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              cartProvider.checkoutCart();
              Navigator.pop(context);
            },
            child: const Text('Selesai', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Konfirmasi Pesanan', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Alamat Pengiriman', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 8),
            ...List.generate(_daftarAlamat.length, (idx) {
              final item = _daftarAlamat[idx];
              final isSelected = _selectedAddressIdx == idx;
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: isSelected ? const Color(0xFF1E88E5) : Colors.grey[200]!, width: isSelected ? 1.5 : 1),
                ),
                margin: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () => setState(() => _selectedAddressIdx = idx),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          child: Icon(
                            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                            color: isSelected ? const Color(0xFF1E88E5) : Colors.grey[400],
                            size: 22,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['label']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                              const SizedBox(height: 4),
                              Text(item['penerima']!, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 2),
                              Text(item['alamat']!, style: TextStyle(fontSize: 12, color: Colors.grey[600], height: 1.4)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),
            
            const Text('Pilih Metode Pembayaran', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 8),
            ...List.generate(_metodePembayaran.length, (idx) {
              final item = _metodePembayaran[idx];
              final isSelected = _selectedPaymentIdx == idx;
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: isSelected ? Colors.green : Colors.grey[200]!, width: isSelected ? 1.5 : 1),
                ),
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: Icon(item['icon'] as IconData, color: isSelected ? Colors.green : Colors.blue[900]),
                  title: Text(item['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  subtitle: Text(item['label'] as String, style: TextStyle(color: Colors.grey[500], fontSize: 11)),
                  trailing: Icon(
                    isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                    color: isSelected ? Colors.green : Colors.grey[400],
                    size: 22,
                  ),
                  onTap: () => setState(() => _selectedPaymentIdx = idx),
                ),
              );
            }),
            const SizedBox(height: 16),
            
            const Text('Ringkasan Pesanan', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ...cartProvider.items.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text('${item.judul} (x${item.quantity})', style: const TextStyle(fontSize: 13))),
                          Text(_formatRupiah(item.totalNumericPrice), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    )),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Pembayaran', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        Text(cartProvider.totalPriceFormatted, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue[900])),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () => _confirmCheckout(context, cartProvider),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0,
                ),
                child: const Text('Konfirmasi & Bayar', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
