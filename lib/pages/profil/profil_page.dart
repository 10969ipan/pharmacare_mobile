import 'package:flutter/material.dart';
import '../welcome/welcome_page.dart';

// Halaman Profil Pengguna Modern & Minimalis
class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA), // Latar belakang abu-abu sangat terang
      appBar: AppBar(
        backgroundColor: Colors.blue[900], // AppBar biru tua
        title: const Text('Profil Saya', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20)), // Judul halaman
        centerTitle: true, // Pusatkan judul
        elevation: 0, // Tanpa bayangan bawah AppBar
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24), // Jarak spasi atas
            _buildProfileHeader(context), // Render informasi akun pengguna
            const SizedBox(height: 24), // Spasi pemisah
            _buildStatsSection(), // Render stats poin/voucher (hi-fi design)
            const SizedBox(height: 24), // Spasi pemisah
            _buildProfileMenu(context), // Render barisan menu pengaturan
            const SizedBox(height: 32), // Spasi penutup bawah
          ],
        ),
      ),
    );
  }

  // Membuat visual informasi diri pengguna (Avatar, nama, email, hp)
  Widget _buildProfileHeader(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // Kontainer foto profil berbayang halus
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle, // Bentuk bulat penuh
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 6))], // Efek bayangan bulat
            ),
            child: CircleAvatar(
              radius: 54, // Ukuran radius lingkaran
              backgroundColor: Colors.white, // Lingkaran tepi putih
              child: CircleAvatar(
                radius: 50, // Radius avatar dalam
                backgroundImage: const AssetImage('assets/images/dokter.webp'), // Gambar utama
                backgroundColor: Colors.blue[50], // Latar warna cadangan
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/dokter.webp', // Memuat berkas gambar
                    fit: BoxFit.cover, width: 100, height: 100, // Menyesuaikan lebar
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.account_circle, size: 90, color: Colors.blue[900]), // Ikon cadangan jika error
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16), // Spasi di bawah avatar
          const Text('Irfan Arfian Kusnadi', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50))), // Teks nama tebal
          const SizedBox(height: 6), // Spasi vertikal kecil
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Pusatkan info baris
            children: [
              Icon(Icons.email_outlined, size: 14, color: Colors.grey[500]), // Ikon email kecil
              const SizedBox(width: 6), // Jarak spasi horizontal
              Text('irfan.kusnadi@email.com', style: TextStyle(fontSize: 13, color: Colors.grey[600])), // Teks email
            ],
          ),
          const SizedBox(height: 4), // Spasi vertikal kecil
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Pusatkan info baris
            children: [
              Icon(Icons.phone_android_outlined, size: 14, color: Colors.grey[500]), // Ikon HP kecil
              const SizedBox(width: 6), // Jarak spasi horizontal
              Text('+62 812-3456-7890', style: TextStyle(fontSize: 13, color: Colors.grey[600])), // Teks nomor hp
            ],
          ),
        ],
      ),
    );
  }

  // Membuat visualisasi ringkasan poin, voucher, dan transaksi aktif
  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0), // Jarak margin dari layar
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16), // Padding dalam kontainer stats
        decoration: BoxDecoration(
          color: Colors.white, // Warna latar kontainer putih
          borderRadius: BorderRadius.circular(16), // Sudut bulat kontainer
          border: Border.all(color: const Color(0xFFEEEEEE)), // Batas tepi abu-abu tipis
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribusi spasi merata
          children: [
            _buildStatItem('150', 'Poin Sehat', Icons.stars_rounded, Colors.amber), // Item poin sehat
            _buildDivider(), // Garis vertikal
            _buildStatItem('3', 'Voucher', Icons.local_offer_rounded, Colors.green), // Item jumlah voucher
            _buildDivider(), // Garis vertikal
            _buildStatItem('2', 'Order Aktif', Icons.local_shipping_rounded, Colors.blue), // Item pesanan diproses
          ],
        ),
      ),
    );
  }

  // Membuat widget pembagi vertikal di area stats
  Widget _buildDivider() => Container(height: 30, width: 1, color: Colors.grey[200]);

  // Membuat elemen statistik tunggal (Angka, judul, ikon pendukung)
  Widget _buildStatItem(String val, String label, IconData icon, Color color) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: color), // Ikon kecil bertema
            const SizedBox(width: 4), // Jarak spasi horizontal
            Text(val, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50))), // Angka stats
          ],
        ),
        const SizedBox(height: 4), // Jarak di bawah angka
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500)), // Judul statistik
      ],
    );
  }

  // Membangun daftar menu pengaturan akun pengguna
  Widget _buildProfileMenu(BuildContext context) {
    // Definisi list data menu profil
    final items = [
      {'icon': Icons.edit, 'title': 'Ubah Profil', 'color': Colors.blue[50], 'iconColor': Colors.blue[700]},
      {'icon': Icons.location_on, 'title': 'Alamat Pengiriman', 'color': Colors.green[50], 'iconColor': Colors.green[700]},
      {'icon': Icons.payment, 'title': 'Metode Pembayaran', 'color': Colors.orange[50], 'iconColor': Colors.orange[700]},
      {'icon': Icons.help_outline, 'title': 'Pusat Bantuan', 'color': Colors.teal[50], 'iconColor': Colors.teal[700]},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0), // Jarak margin tepi layar
      child: Column(
        children: [
          // Kartu menu utama akun
          Container(
            decoration: BoxDecoration(
              color: Colors.white, // Latar belakang kartu putih
              borderRadius: BorderRadius.circular(16), // Sudut bulat kartu menu
              border: Border.all(color: const Color(0xFFEEEEEE)), // Garis pembatas luar abu-abu
            ),
            child: Column(
              children: items.map((item) {
                final isLast = item == items.last; // Memeriksa baris terakhir list
                return Column(
                  children: [
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(6), // Padding dalam wadah bulat ikon
                        decoration: BoxDecoration(color: item['color'] as Color, shape: BoxShape.circle), // Latar bulat kecil berwarna lembut
                        child: Icon(item['icon'] as IconData, color: item['iconColor'] as Color, size: 18), // Visual ikon berwarna senada
                      ),
                      title: Text(item['title'] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF2C3E50))), // Judul menu
                      trailing: const Icon(Icons.chevron_right, size: 18, color: Colors.grey), // Petunjuk arah navigasi
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Membuka halaman ${item['title']}'))), // Notifikasi toast uji coba
                    ),
                    if (!isLast) const Divider(height: 1, indent: 56, endIndent: 16), // Garis pembatas horizontal tipis (indentasi ikon)
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16), // Spasi pemisah vertikal
          
          // Kartu tombol Keluar (Logout)
          Container(
            decoration: BoxDecoration(
              color: Colors.white, // Latar belakang kartu putih
              borderRadius: BorderRadius.circular(16), // Sudut bulat kartu
              border: Border.all(color: const Color(0xFFEEEEEE)), // Garis pembatas luar abu-abu
            ),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(6), // Jarak di dalam bulat merah
                decoration: const BoxDecoration(color: Color(0xFFFFEBEE), shape: BoxShape.circle), // Bulatan berwarna merah lembut
                child: const Icon(Icons.logout, color: Color(0xFFC62828), size: 18), // Visual ikon logout merah
              ),
              title: const Text('Keluar dari Aplikasi', style: TextStyle(color: Color(0xFFC62828), fontWeight: FontWeight.bold, fontSize: 14)), // Teks logout merah
              trailing: const Icon(Icons.chevron_right, size: 18, color: Color(0xFFC62828)), // Panah kanan merah
              onTap: () => _showLogoutDialog(context), // Jalankan konfirmasi keluar akun
            ),
          ),
        ],
      ),
    );
  }

  // Memunculkan kotak dialog konfirmasi log out/keluar aplikasi
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context, // Informasi rute layar saat ini
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // Sudut melengkung dialog 16px
          title: const Text('Keluar dari Akun', style: TextStyle(fontWeight: FontWeight.bold)), // Judul kotak dialog
          content: const Text('Apakah Anda yakin ingin keluar dari aplikasi Pharmacare?'), // Teks pertanyaan konfirmasi
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')), // Batalkan log out dan tutup dialog
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog pop-up konfirmasi
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomePage()), // Navigasi ke halaman Welcome/Masuk awal
                  (route) => false, // Bersihkan seluruh riwayat tumpukan navigasi sebelumnya
                );
              },
              child: const Text('Keluar', style: TextStyle(color: Color(0xFFC62828), fontWeight: FontWeight.bold)), // Tombol eksekusi keluar akun merah
            ),
          ],
        );
      },
    );
  }
}
