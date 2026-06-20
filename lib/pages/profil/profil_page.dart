import 'package:flutter/material.dart';
import '../welcome/welcome_page.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text(
          'Profil Saya',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            _buildProfileHeader(context),
            const SizedBox(height: 24),
            _buildProfileMenu(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.blue[900],
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: 60,
              backgroundImage: const AssetImage('assets/images/dokter.webp'),
              backgroundColor: Colors.blue[50],
              child: ClipOval(
                child: Image.asset(
                  'assets/images/dokter.webp',
                  fit: BoxFit.cover,
                  width: 120,
                  height: 120,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.account_circle, size: 100, color: Colors.blue[900]);
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Irfan Arfian Kusnadi',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'irfan.kusnadi@email.com',
            style: TextStyle(fontSize: 15, color: Colors.grey[600]),
          ),
          const SizedBox(height: 2),
          Text(
            '+62 812-3456-7890',
            style: TextStyle(fontSize: 15, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileMenu(BuildContext context) {
    final menuItems = [
      {'icon': Icons.edit, 'title': 'Ubah Profil'},
      {'icon': Icons.location_on, 'title': 'Alamat Pengiriman'},
      {'icon': Icons.payment, 'title': 'Metode Pembayaran'},
      {'icon': Icons.help_outline, 'title': 'Pusat Bantuan'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: Column(
              children: menuItems.map((item) {
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(item['icon'] as IconData, color: Colors.blue[900]),
                      title: Text(
                        item['title'] as String,
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Membuka halaman ${item['title']}')),
                        );
                      },
                    ),
                    if (item != menuItems.last) const Divider(height: 1),
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Keluar',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.red),
              onTap: () {
                _showLogoutDialog(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Keluar dari Akun'),
          content: const Text('Apakah Anda yakin ingin keluar dari aplikasi Pharmacare?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // close dialog
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomePage()),
                  (route) => false,
                );
              },
              child: const Text('Keluar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
