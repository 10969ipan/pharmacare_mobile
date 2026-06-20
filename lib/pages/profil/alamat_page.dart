import 'package:flutter/material.dart';

class AlamatPage extends StatelessWidget {
  const AlamatPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Alamat Pengiriman', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: daftarAlamat.length,
              itemBuilder: (context, index) {
                final item = daftarAlamat[index];
                final isUtama = index == 0;
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: isUtama ? const Color(0xFF1E88E5) : Colors.grey[200]!, width: isUtama ? 1.5 : 1),
                  ),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item['label']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            if (isUtama)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(6)),
                                child: const Text('Utama', style: TextStyle(color: Color(0xFF1565C0), fontSize: 10, fontWeight: FontWeight.bold)),
                              ),
                          ],
                        ),
                        const Divider(height: 20),
                        Text(item['penerima']!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black87)),
                        const SizedBox(height: 6),
                        Text(item['alamat']!, style: TextStyle(color: Colors.grey[600], fontSize: 13, height: 1.4)),
                      ],
                    ),
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
                    const SnackBar(content: Text('Fitur tambah alamat sedang disiapkan!')),
                  );
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text('Tambah Alamat Baru', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
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
