import 'package:flutter/material.dart';
import '../welcome/welcome_page.dart';
import './edit_profil_page.dart';
import './alamat_page.dart';
import './metode_pembayaran_page.dart';
import './pusat_bantuan_page.dart';


class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Profil Saya', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            _buildProfileHeader(context),
            const SizedBox(height: 24),
            _buildStatsSection(),
            const SizedBox(height: 24),
            _buildProfileMenu(context),
            const SizedBox(height: 32),
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
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 6))],
            ),
            child: CircleAvatar(
              radius: 54,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: const AssetImage('assets/images/dokter.webp'),
                backgroundColor: Colors.blue[50],
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/dokter.webp',
                    fit: BoxFit.cover, width: 100, height: 100,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.account_circle, size: 90, color: Colors.blue[900]),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Irfan Arfian Kusnadi', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50))),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.email_outlined, size: 14, color: Colors.grey[500]),
              const SizedBox(width: 6),
              Text('irfan.kusnadi@email.com', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.phone_android_outlined, size: 14, color: Colors.grey[500]),
              const SizedBox(width: 6),
              Text('+62 812-3456-7890', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFEEEEEE)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatItem('150', 'Poin Sehat', Icons.stars_rounded, Colors.amber),
            _buildDivider(),
            _buildStatItem('3', 'Voucher', Icons.local_offer_rounded, Colors.green),
            _buildDivider(),
            _buildStatItem('2', 'Order Aktif', Icons.local_shipping_rounded, Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() => Container(height: 30, width: 1, color: Colors.grey[200]);

  Widget _buildStatItem(String val, String label, IconData icon, Color color) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 4),
            Text(val, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50))),
          ],
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildProfileMenu(BuildContext context) {
    final items = [
      {'icon': Icons.edit, 'title': 'Ubah Profil', 'color': Colors.blue[50], 'iconColor': Colors.blue[700]},
      {'icon': Icons.location_on, 'title': 'Alamat Pengiriman', 'color': Colors.green[50], 'iconColor': Colors.green[700]},
      {'icon': Icons.payment, 'title': 'Metode Pembayaran', 'color': Colors.orange[50], 'iconColor': Colors.orange[700]},
      {'icon': Icons.help_outline, 'title': 'Pusat Bantuan', 'color': Colors.teal[50], 'iconColor': Colors.teal[700]},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: Column(
              children: items.map((item) {
                final isLast = item == items.last;
                return Column(
                  children: [
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(color: item['color'] as Color, shape: BoxShape.circle),
                        child: Icon(item['icon'] as IconData, color: item['iconColor'] as Color, size: 18),
                      ),
                      title: Text(item['title'] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF2C3E50))),
                      trailing: const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
                      onTap: () {
                        Widget target;
                        if (item['title'] == 'Ubah Profil') {
                          target = const EditProfilPage();
                        } else if (item['title'] == 'Alamat Pengiriman') {
                          target = const AlamatPage();
                        } else if (item['title'] == 'Metode Pembayaran') {
                          target = const MetodePembayaranPage();
                        } else {
                          target = const PusatBantuanPage();
                        }
                        Navigator.push(context, MaterialPageRoute(builder: (_) => target));
                      },
                    ),
                    if (!isLast) const Divider(height: 1, indent: 56, endIndent: 16),
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(color: Color(0xFFFFEBEE), shape: BoxShape.circle),
                child: const Icon(Icons.logout, color: Color(0xFFC62828), size: 18),
              ),
              title: const Text('Keluar dari Aplikasi', style: TextStyle(color: Color(0xFFC62828), fontWeight: FontWeight.bold, fontSize: 14)),
              trailing: const Icon(Icons.chevron_right, size: 18, color: Color(0xFFC62828)),
              onTap: () => _showLogoutDialog(context),
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Keluar dari Akun', style: TextStyle(fontWeight: FontWeight.bold)),
          content: const Text('Apakah Anda yakin ingin keluar dari aplikasi Pharmacare?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomePage()),
                  (route) => false,
                );
              },
              child: const Text('Keluar', style: TextStyle(color: Color(0xFFC62828), fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }
}
