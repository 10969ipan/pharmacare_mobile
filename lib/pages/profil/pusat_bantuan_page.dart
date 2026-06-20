import 'package:flutter/material.dart';

class PusatBantuanPage extends StatelessWidget {
  const PusatBantuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = [
      {
        'q': 'Bagaimana cara memesan obat resep?',
        'a': 'Untuk memesan obat kategori resep dokter (bertanda merah), Anda harus mengunggah foto resep resmi dokter Anda saat berkonsultasi atau mengajukannya kepada apoteker kami melalui loket pemesanan.',
      },
      {
        'q': 'Berapa lama estimasi pengiriman obat?',
        'a': 'Estimasi pengiriman obat reguler berkisar antara 1-3 hari kerja bergantung pada wilayah alamat Anda. Untuk pengiriman instan (jika tersedia), obat akan tiba dalam waktu 1-3 jam setelah verifikasi pembayaran.',
      },
      {
        'q': 'Apakah saya bisa membatalkan pesanan?',
        'a': 'Pembatalan pesanan hanya dapat dilakukan apabila status transaksi Anda masih bertuliskan "Diproses". Jika status pesanan sudah berganti menjadi "Dikirim", maka pesanan tidak dapat dibatalkan.',
      },
      {
        'q': 'Bagaimana metode pengembalian obat?',
        'a': 'Pengembalian obat hanya dapat diproses apabila terjadi kelalaian pengiriman obat yang salah atau cacat kemasan. Silakan laporkan beserta foto bukti fisik kepada customer service kami paling lambat 24 jam setelah obat diterima.',
      }
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Pusat Bantuan', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: faqs.length,
              itemBuilder: (context, index) {
                final item = faqs[index];
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ExpansionTile(
                    title: Text(item['q']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF2C3E50))),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Text(item['a']!, style: TextStyle(color: Colors.grey[700], fontSize: 13, height: 1.5)),
                      ),
                    ],
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
                    const SnackBar(content: Text('Menghubungkan ke Customer Service via WhatsApp...')),
                  );
                },
                icon: const Icon(Icons.chat_bubble_outline_rounded, color: Colors.white),
                label: const Text('Hubungi CS via WhatsApp', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
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
