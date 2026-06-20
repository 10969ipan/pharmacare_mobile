import 'package:flutter/material.dart';

// Halaman Metode Pembayaran
class MetodePembayaranPage extends StatelessWidget {
  const MetodePembayaranPage({super.key});

  @override
  Widget build(BuildContext context) {
    // List opsi metode pembayaran tersimpan
    final metode = [
      {'name': 'Virtual Account Mandiri', 'icon': Icons.account_balance, 'label': 'Mandiri'},
      {'name': 'GoPay E-Wallet', 'icon': Icons.wallet, 'label': 'GoPay (Aktif)'},
      {'name': 'Kartu Kredit Visa/Mastercard', 'icon': Icons.credit_card, 'label': 'Visa'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA), // Latar abu-abu terang
      appBar: AppBar(
        backgroundColor: Colors.blue[900], // AppBar biru tua
        title: const Text('Metode Pembayaran', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)), // Judul halaman
        iconTheme: const IconThemeData(color: Colors.white), // Tombol back putih
      ),
      body: Column(
        children: [
          // Daftar List Metode Pembayaran
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16), // Padding list
              itemCount: metode.length, // Jumlah metode terdaftar
              itemBuilder: (context, index) {
                final item = metode[index]; // Ambil data metode
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Bulat sudut kartu
                  margin: const EdgeInsets.only(bottom: 12), // Jarak spasi bawah
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[50], // Latar belakang bulat biru muda
                      child: Icon(item['icon'] as IconData, color: Colors.blue[900]), // Ikon representasi metode
                    ),
                    title: Text(item['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), // Nama metode pembayaran
                    subtitle: Text(item['label'] as String, style: TextStyle(color: Colors.grey[500], fontSize: 12)), // Sub-keterangan singkat metode
                    trailing: const Icon(Icons.check_circle, color: Colors.green), // Ikon ceklis hijau terpilih
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${item['name']} terpilih sebagai metode pembayaran utama.')), // Toast konfirmasi terpilih
                      );
                    },
                  ),
                );
              },
            ),
          ),
          // Tombol Tambah Metode Baru
          Padding(
            padding: const EdgeInsets.all(16.0), // Padding tombol
            child: SizedBox(
              width: double.infinity, // Lebar penuh
              height: 48, // Tinggi tombol 48px
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Fitur tambah metode pembayaran baru sedang disiapkan!')), // Notifikasi sedang disiapkan
                  );
                },
                icon: const Icon(Icons.add, color: Colors.white), // Ikon plus
                label: const Text('Tambah Metode Baru', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)), // Label tombol
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900], // Biru tua
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Bulat sudut 8px
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
