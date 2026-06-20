import 'package:flutter/material.dart';
import '../welcome/welcome_page.dart';

// Halaman Profil Pengguna
class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900], // Latar belakang AppBar biru tua
        title: const Text('Profil Saya', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)), // Judul halaman
        centerTitle: true, // Pusatkan teks judul di tengah
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24), // Jarak spasi vertikal atas
            _buildProfileHeader(context), // Render bagian kartu header informasi profil
            const SizedBox(height: 24), // Jarak pemisah vertikal
            _buildProfileMenu(context), // Render barisan item menu profil
          ],
        ),
      ),
    );
  }

  // Membuat bagian visual foto profil, nama, email, dan no hp
  Widget _buildProfileHeader(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4), // Jarak di luar avatar untuk lingkaran terluar
            decoration: BoxDecoration(color: Colors.blue[900], shape: BoxShape.circle), // Latar bulat biru tua pembungkus foto
            child: CircleAvatar(
              radius: 60, // Ukuran radius avatar
              backgroundImage: const AssetImage('assets/images/dokter.webp'), // Gambar profile default
              backgroundColor: Colors.blue[50], // Latar belakang jika gambar loading
              child: ClipOval(
                child: Image.asset(
                  'assets/images/dokter.webp', // Memuat berkas gambar
                  fit: BoxFit.cover, width: 120, height: 120, // Pemotongan pas di lingkaran
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.account_circle, size: 100, color: Colors.blue[900]), // Ikon cadangan jika asset error
                ),
              ),
            ),
          ),
          const SizedBox(height: 16), // Jarak vertikal di bawah avatar
          const Text('Irfan Arfian Kusnadi', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), // Nama lengkap pengguna
          const SizedBox(height: 4), // Jarak spasi vertikal
          Text('irfan.kusnadi@email.com', style: TextStyle(fontSize: 15, color: Colors.grey[600])), // Alamat email pengguna
          const SizedBox(height: 2), // Jarak spasi vertikal
          Text('+62 812-3456-7890', style: TextStyle(fontSize: 15, color: Colors.grey[600])), // Nomor HP aktif pengguna
        ],
      ),
    );
  }

  // Membangun daftar pilihan menu navigasi internal akun profil
  Widget _buildProfileMenu(BuildContext context) {
    final menuItems = [
      {'icon': Icons.edit, 'title': 'Ubah Profil'},
      {'icon': Icons.location_on, 'title': 'Alamat Pengiriman'},
      {'icon': Icons.payment, 'title': 'Metode Pembayaran'},
      {'icon': Icons.help_outline, 'title': 'Pusat Bantuan'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Jarak margin kiri-kanan list
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Sudut bulat kartu menu
            elevation: 2, // Efek bayangan kartu menu
            child: Column(
              children: menuItems.map((item) {
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(item['icon'] as IconData, color: Colors.blue[900]), // Ikon utama menu di kiri
                      title: Text(item['title'] as String, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)), // Judul menu
                      trailing: const Icon(Icons.chevron_right), // Ikon panah kanan petunjuk aksi
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Membuka halaman ${item['title']}'))), // Notifikasi toast uji coba
                    ),
                    if (item != menuItems.last) const Divider(height: 1), // Berikan garis pembatas jika bukan menu terakhir
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16), // Jarak vertikal pemisah
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Sudut bulat kartu logout
            elevation: 2, // Bayangan kartu
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red), // Ikon keluar berwarna merah
              title: const Text('Keluar', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16)), // Teks merah logout
              trailing: const Icon(Icons.chevron_right, color: Colors.red), // Panah kanan merah
              onTap: () => _showLogoutDialog(context), // Tampilkan konfirmasi keluar akun
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
          title: const Text('Keluar dari Akun'), // Judul kotak dialog
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
              child: const Text('Keluar', style: TextStyle(color: Colors.red)), // Tombol eksekusi keluar akun merah
            ),
          ],
        );
      },
    );
  }
}
