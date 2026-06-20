import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';

// Halaman Konfirmasi Pesanan, Alamat, dan Metode Pembayaran
class CheckoutConfirmPage extends StatefulWidget {
  const CheckoutConfirmPage({super.key});

  @override
  State<CheckoutConfirmPage> createState() => _CheckoutConfirmPageState();
}

class _CheckoutConfirmPageState extends State<CheckoutConfirmPage> {
  int _selectedAddressIdx = 0; // Indeks alamat pengiriman terpilih secara lokal
  int _selectedPaymentIdx = 0; // Indeks metode pembayaran terpilih secara lokal

  // Mock daftar alamat pengiriman yang dapat dipilih pengguna
  final List<Map<String, String>> _daftarAlamat = [
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

  // Mock daftar opsi metode pembayaran yang didukung
  final List<Map<String, dynamic>> _metodePembayaran = [
    {'name': 'GoPay E-Wallet', 'icon': Icons.wallet, 'label': 'Saldo Aktif'},
    {'name': 'Virtual Account Mandiri', 'icon': Icons.account_balance, 'label': 'Transfer VA'},
    {'name': 'Kartu Kredit Visa', 'icon': Icons.credit_card, 'label': 'Visa/Mastercard'},
    {'name': 'Bayar di Tempat (COD)', 'icon': Icons.local_shipping, 'label': 'Tunai saat tiba'},
  ];

  // Helper untuk mengubah integer nominal angka menjadi String terformat Rupiah
  String _formatRupiah(int nominal) {
    final buffer = StringBuffer(); // Tempat perakitan karakter format
    final nomStr = nominal.toString(); // Ubah angka nominal ke teks
    int count = 0; // Penghitung digit ribuan
    for (int i = nomStr.length - 1; i >= 0; i--) {
      buffer.write(nomStr[i]); // Tulis karakter angka
      count++; // Tambah counter digit
      if (count % 3 == 0 && i != 0) buffer.write('.'); // Sisipkan tanda titik pemisah ribuan
    }
    return 'Rp ${buffer.toString().split('').reversed.join('')}'; // Balik teks rupiah
  }

  // Menangani proses finalisasi pemesanan dan checkout
  void _confirmCheckout(BuildContext context, CartProvider cartProvider) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // Bentuk bulat dialog
        title: const Text('Pesanan Berhasil'), // Judul dialog
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Terima kasih! Pesanan Anda telah dikonfirmasi.', style: TextStyle(fontWeight: FontWeight.bold)), // Isi pesan sukses
            const SizedBox(height: 12), // Jarak spasi vertikal
            Text('Alamat: ${_daftarAlamat[_selectedAddressIdx]['label']}', style: const TextStyle(fontSize: 13, color: Colors.grey)), // Informasi alamat terpilih
            Text('Metode: ${_metodePembayaran[_selectedPaymentIdx]['name']}', style: const TextStyle(fontSize: 13, color: Colors.grey)), // Informasi pembayaran terpilih
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx); // Menutup dialog pesan sukses
              cartProvider.checkoutCart(); // Melakukan checkout dan mengosongkan isi keranjang belanja
              Navigator.pop(context); // Kembali ke halaman Keranjang (yang sudah kosong)
            },
            child: const Text('Selesai', style: TextStyle(fontWeight: FontWeight.bold)), // Label tombol penyelesai
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context); // Akses data cart provider secara reactive
    
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA), // Latar belakang abu-abu terang
      appBar: AppBar(
        backgroundColor: Colors.blue[900], // Latar belakang appBar biru tua
        title: const Text('Konfirmasi Pesanan', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)), // Judul halaman
        iconTheme: const IconThemeData(color: Colors.white), // Tombol back warna putih
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Padding jarak isi halaman
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Isi meluas penuh secara horizontal
          children: [
            // Bagian Alamat Pengiriman
            const Text('Alamat Pengiriman', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)), // Judul section alamat
            const SizedBox(height: 8), // Jarak spasi vertikal
            ...List.generate(_daftarAlamat.length, (idx) {
              final item = _daftarAlamat[idx];
              final isSelected = _selectedAddressIdx == idx;
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: isSelected ? const Color(0xFF1E88E5) : Colors.grey[200]!, width: isSelected ? 1.5 : 1), // Border biru bila terpilih
                ),
                margin: const EdgeInsets.only(bottom: 10), // Jarak spasi bawah
                child: InkWell(
                  onTap: () => setState(() => _selectedAddressIdx = idx), // Pilih alamat ini ketika di-tap
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0), // Padding kartu alamat
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          child: Icon(
                            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                            color: isSelected ? const Color(0xFF1E88E5) : Colors.grey[400],
                            size: 22,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri informasi alamat
                            children: [
                              Text(item['label']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), // Nama label tempat
                              const SizedBox(height: 4), // Jarak vertikal kecil
                              Text(item['penerima']!, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)), // Penerima alamat
                              const SizedBox(height: 2), // Jarak vertikal kecil
                              Text(item['alamat']!, style: TextStyle(fontSize: 12, color: Colors.grey[600], height: 1.4)), // Alamat rinci
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 16), // Jarak spasi vertikal antar section
            
            // Bagian Metode Pembayaran
            const Text('Pilih Metode Pembayaran', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)), // Judul section pembayaran
            const SizedBox(height: 8), // Jarak spasi vertikal
            ...List.generate(_metodePembayaran.length, (idx) {
              final item = _metodePembayaran[idx];
              final isSelected = _selectedPaymentIdx == idx;
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: isSelected ? Colors.green : Colors.grey[200]!, width: isSelected ? 1.5 : 1), // Border hijau bila terpilih
                ),
                margin: const EdgeInsets.only(bottom: 8), // Jarak spasi kartu
                child: ListTile(
                  leading: Icon(item['icon'] as IconData, color: isSelected ? Colors.green : Colors.blue[900]), // Ikon metode pembayaran
                  title: Text(item['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), // Nama opsi metode pembayaran
                  subtitle: Text(item['label'] as String, style: TextStyle(color: Colors.grey[500], fontSize: 11)), // Subketerangan singkat metode pembayaran
                  trailing: Icon(
                    isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                    color: isSelected ? Colors.green : Colors.grey[400],
                    size: 22,
                  ),
                  onTap: () => setState(() => _selectedPaymentIdx = idx), // Pilih metode pembayaran ini bila di-tap
                ),
              );
            }),
            const SizedBox(height: 16), // Jarak spasi vertikal antar section
            
            // Bagian Ringkasan Pesanan
            const Text('Ringkasan Pesanan', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)), // Judul section ringkasan
            const SizedBox(height: 8), // Jarak spasi vertikal
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Sudut melengkung kartu ringkasan
              child: Padding(
                padding: const EdgeInsets.all(16.0), // Jarak padding dalam kartu
                child: Column(
                  children: [
                    ...cartProvider.items.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0), // Jarak antar baris detail obat
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Sejajarkan nama kiri dan harga total kanan
                        children: [
                          Expanded(child: Text('${item.judul} (x${item.quantity})', style: const TextStyle(fontSize: 13))), // Nama obat dan kuantitas
                          Text(_formatRupiah(item.totalNumericPrice), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)), // Harga total item
                        ],
                      ),
                    )),
                    const Divider(height: 24), // Garis pembatas putus-putus horizontal
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Sejajarkan label total dan nominal
                      children: [
                        const Text('Total Pembayaran', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), // Label total tagihan akhir
                        Text(cartProvider.totalPriceFormatted, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue[900])), // Nilai nominal tagihan terformat
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24), // Spasi sebelum tombol konfirmasi pesanan
            
            // Tombol Konfirmasi Pembayaran/Pemesanan
            SizedBox(
              height: 50, // Tinggi tetap tombol konfirmasi
              child: ElevatedButton(
                onPressed: () => _confirmCheckout(context, cartProvider), // Jalankan fungsi konfirmasi pesanan
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Warna tombol hijau sukses
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0, // Sudut bulat 12px tanpa bayangan
                ),
                child: const Text('Konfirmasi & Bayar', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)), // Label teks tombol
              ),
            ),
          ],
        ),
      ),
    );
  }
}
