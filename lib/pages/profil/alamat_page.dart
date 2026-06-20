import 'package:flutter/material.dart';

// Halaman Alamat Pengiriman
class AlamatPage extends StatelessWidget {
  const AlamatPage({super.key});

  @override
  Widget build(BuildContext context) {
    // List data alamat tersimpan
    final daftarAlamat = [
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

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA), // Latar abu-abu terang
      appBar: AppBar(
        backgroundColor: Colors.blue[900], // AppBar biru tua
        title: const Text('Alamat Pengiriman', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)), // Judul halaman
        iconTheme: const IconThemeData(color: Colors.white), // Tombol back putih
      ),
      body: Column(
        children: [
          // Daftar List Alamat Tersimpan
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16), // Padding luar list
              itemCount: daftarAlamat.length, // Jumlah alamat tersimpan
              itemBuilder: (context, index) {
                final item = daftarAlamat[index]; // Ambil data alamat
                final isUtama = index == 0; // Alamat pertama adalah utama
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Bulat sudut kartu
                    side: BorderSide(color: isUtama ? const Color(0xFF1E88E5) : Colors.grey[200]!, width: isUtama ? 1.5 : 1), // Border tebal biru untuk alamat utama
                  ),
                  margin: const EdgeInsets.only(bottom: 12), // Jarak spasi bawah antar kartu
                  child: Padding(
                    padding: const EdgeInsets.all(16), // Padding dalam kartu
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri konten
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Sejajarkan label dan badge utama
                          children: [
                            Text(item['label']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)), // Label nama tempat
                            if (isUtama)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), // Padding badge
                                decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(6)), // Latar biru transparan
                                child: const Text('Utama', style: TextStyle(color: Color(0xFF1565C0), fontSize: 10, fontWeight: FontWeight.bold)), // Teks badge
                              ),
                          ],
                        ),
                        const Divider(height: 20), // Garis pemisah horizontal
                        Text(item['penerima']!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black87)), // Nama penerima & no telepon
                        const SizedBox(height: 6), // Spasi vertikal kecil
                        Text(item['alamat']!, style: TextStyle(color: Colors.grey[600], fontSize: 13, height: 1.4)), // Detail alamat lengkap
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Tombol Tambah Alamat Baru
          Padding(
            padding: const EdgeInsets.all(16.0), // Padding tombol
            child: SizedBox(
              width: double.infinity, // Lebar penuh
              height: 48, // Tinggi tombol 48px
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Fitur tambah alamat sedang disiapkan!')), // Notifikasi sedang disiapkan
                  );
                },
                icon: const Icon(Icons.add, color: Colors.white), // Ikon plus
                label: const Text('Tambah Alamat Baru', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)), // Label
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
