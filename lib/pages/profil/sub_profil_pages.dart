import 'package:flutter/material.dart';

// ==========================================
// 1. Halaman Ubah Profil
// ==========================================
class EditProfilPage extends StatefulWidget {
  const EditProfilPage({super.key});

  @override
  State<EditProfilPage> createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  final _namaController = TextEditingController(text: 'Irfan Arfian Kusnadi'); // Controller nama
  final _emailController = TextEditingController(text: 'irfan.kusnadi@email.com'); // Controller email
  final _phoneController = TextEditingController(text: '+62 812-3456-7890'); // Controller no HP

  @override
  void dispose() {
    _namaController.dispose(); // Hapus controller nama
    _emailController.dispose(); // Hapus controller email
    _phoneController.dispose(); // Hapus controller no hp
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Latar putih
      appBar: AppBar(
        backgroundColor: Colors.blue[900], // AppBar biru tua
        title: const Text('Ubah Profil', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)), // Judul halaman
        iconTheme: const IconThemeData(color: Colors.white), // Tombol back putih
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0), // Padding dalam form
        child: Column(
          children: [
            // Area Foto Profil dengan tombol edit kamera
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: const AssetImage('assets/images/dokter.webp'), // Gambar profile saat ini
                    backgroundColor: Colors.blue[50], // Latar warna cadangan
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6), // Jarak di dalam bulat kamera
                      decoration: const BoxDecoration(color: Color(0xFF1E88E5), shape: BoxShape.circle), // Latar bulat biru kamera
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 16), // Ikon kamera
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32), // Spasi di bawah avatar
            // Input Nama Lengkap
            TextField(
              controller: _namaController, // Hubungkan controller
              decoration: const InputDecoration(
                labelText: "Nama Lengkap",
                prefixIcon: Icon(Icons.person_outline, color: Color(0xFF1E88E5)),
                border: OutlineInputBorder(), // Garis tepi kotak penuh
              ),
            ),
            const SizedBox(height: 16), // Spasi pemisah
            // Input Email
            TextField(
              controller: _emailController, // Hubungkan controller
              decoration: const InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF1E88E5)),
                border: OutlineInputBorder(), // Garis tepi kotak penuh
              ),
            ),
            const SizedBox(height: 16), // Spasi pemisah
            // Input No. Hp
            TextField(
              controller: _phoneController, // Hubungkan controller
              decoration: const InputDecoration(
                labelText: "No. Hp",
                prefixIcon: Icon(Icons.phone_outlined, color: Color(0xFF1E88E5)),
                border: OutlineInputBorder(), // Garis tepi kotak penuh
              ),
            ),
            const SizedBox(height: 32), // Spasi pemisah
            // Tombol Simpan Perubahan
            SizedBox(
              width: double.infinity, // Lebar penuh
              height: 48, // Tinggi tombol 48px
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Perubahan profil berhasil disimpan!'), backgroundColor: Colors.green), // Notifikasi sukses simpan
                  );
                  Navigator.pop(context); // Kembali ke halaman sebelumnya
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900], // Latar belakang biru tua
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Bulat sudut 8px
                ),
                child: const Text('Simpan Perubahan', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)), // Label tombol
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 2. Halaman Alamat Pengiriman
// ==========================================
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

// ==========================================
// 3. Halaman Metode Pembayaran
// ==========================================
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

// ==========================================
// 4. Halaman Pusat Bantuan (FAQ)
// ==========================================
class PusatBantuanPage extends StatelessWidget {
  const PusatBantuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    // List pertanyaan dan jawaban FAQ
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
      backgroundColor: const Color(0xFFFAFAFA), // Latar abu-abu terang
      appBar: AppBar(
        backgroundColor: Colors.blue[900], // AppBar biru tua
        title: const Text('Pusat Bantuan', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)), // Judul halaman
        iconTheme: const IconThemeData(color: Colors.white), // Tombol back putih
      ),
      body: Column(
        children: [
          // Daftar List FAQ Akordion
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16), // Padding list
              itemCount: faqs.length, // Jumlah FAQ
              itemBuilder: (context, index) {
                final item = faqs[index]; // Ambil data FAQ
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Bulat sudut kartu
                  margin: const EdgeInsets.only(bottom: 12), // Jarak spasi bawah
                  child: ExpansionTile(
                    title: Text(item['q']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF2C3E50))), // Teks pertanyaan tebal
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16), // Jarak padding teks jawaban
                        child: Text(item['a']!, style: TextStyle(color: Colors.grey[700], fontSize: 13, height: 1.5)), // Paragraf teks jawaban
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Tombol Hubungi CS via WhatsApp
          Padding(
            padding: const EdgeInsets.all(16.0), // Padding tombol
            child: SizedBox(
              width: double.infinity, // Lebar penuh
              height: 48, // Tinggi tombol 48px
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Menghubungkan ke Customer Service via WhatsApp...')), // Notifikasi kirim pesan WA
                  );
                },
                icon: const Icon(Icons.chat_bubble_outline_rounded, color: Colors.white), // Ikon obrolan
                label: const Text('Hubungi CS via WhatsApp', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)), // Label tombol
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700], // Latar belakang hijau WhatsApp
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
