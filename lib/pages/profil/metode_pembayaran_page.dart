import 'package:flutter/material.dart';

class MetodePembayaranPage extends StatelessWidget {
  const MetodePembayaranPage({super.key});

  @override
  Widget build(BuildContext context) {
    final metode = [
      {'name': 'Virtual Account Mandiri', 'icon': Icons.account_balance, 'label': 'Mandiri'},
      {'name': 'GoPay E-Wallet', 'icon': Icons.wallet, 'label': 'GoPay (Aktif)'},
      {'name': 'Kartu Kredit Visa/Mastercard', 'icon': Icons.credit_card, 'label': 'Visa'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Metode Pembayaran', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: metode.length,
              itemBuilder: (context, index) {
                final item = metode[index];
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[50],
                      child: Icon(item['icon'] as IconData, color: Colors.blue[900]),
                    ),
                    title: Text(item['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    subtitle: Text(item['label'] as String, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                    trailing: const Icon(Icons.check_circle, color: Colors.green),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${item['name']} terpilih sebagai metode pembayaran utama.')),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Fitur tambah metode pembayaran baru sedang disiapkan!')),
                  );
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text('Tambah Metode Baru', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
