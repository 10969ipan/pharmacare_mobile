import 'package:flutter/material.dart';

// Model data untuk item obat di dalam keranjang
class CartItem {
  final String judul; // Nama obat
  final String harga; // Harga obat format String (e.g., Rp 12.000)
  final String foto; // Lokasi asset gambar obat
  int quantity; // Jumlah obat yang dipesan

  CartItem({
    required this.judul,
    required this.harga,
    required this.foto,
    this.quantity = 1, // Kuantitas default adalah 1
  });

  // Mengubah harga String menjadi nilai integer angka (menghapus huruf non-digit)
  int get numericPrice => int.parse(harga.replaceAll(RegExp(r'[^0-9]'), ''));

  // Menghitung total harga produk berdasarkan kuantitas
  int get totalNumericPrice => numericPrice * quantity;
}

// Provider untuk mengelola status keranjang belanja dan transaksi pesanan
class CartProvider with ChangeNotifier {
  final List<CartItem> _items = []; // List penyimpan item di keranjang belanja
  final List<Map<String, dynamic>> _orders = [ // List riwayat transaksi pemesanan awal (mock data)
    {
      'id': 'TRX-98271A',
      'tanggal': '20 Juni 2026',
      'obat': 'Paracetamol 500mg (2x), Enervon C (1x)',
      'total': 'Rp 51.000',
      'status': 'Diproses',
      'color': Colors.orange,
      'isCompleted': false,
    },
    {
      'id': 'TRX-98255B',
      'tanggal': '19 Juni 2026',
      'obat': 'Betadine Antiseptic (1x)',
      'total': 'Rp 21.000',
      'status': 'Dikirim',
      'color': Colors.blue,
      'isCompleted': false,
    },
    {
      'id': 'TRX-97811X',
      'tanggal': '10 Juni 2026',
      'obat': 'Tolak Angin Cair (2x), Ibuprofen 400mg (1x)',
      'total': 'Rp 60.500',
      'status': 'Selesai',
      'color': Colors.green,
      'isCompleted': true,
    },
    {
      'id': 'TRX-96200Y',
      'tanggal': '01 Juni 2026',
      'obat': 'Amoxicillin 500mg (1x)',
      'total': 'Rp 15.500',
      'status': 'Selesai',
      'color': Colors.green,
      'isCompleted': true,
    },
  ];

  List<CartItem> get items => _items; // Getter untuk mengambil list item keranjang
  List<Map<String, dynamic>> get orders => _orders; // Getter untuk mengambil riwayat pesanan

  // Menghitung jumlah total item barang yang ada di keranjang
  int get totalItemsCount => _items.fold(0, (sum, item) => sum + item.quantity);

  // Menghitung total nilai harga seluruh belanjaan
  int get totalNumericPrice => _items.fold(0, (sum, item) => sum + item.totalNumericPrice);

  // Mengubah total harga numerik menjadi String terformat rupiah (e.g., Rp 50.000)
  String get totalPriceFormatted {
    final total = totalNumericPrice; // Ambil nilai harga total
    final buffer = StringBuffer(); // Tempat perakitan karakter format
    final totalStr = total.toString(); // Ubah angka total ke teks
    int count = 0; // Penghitung digit ribuan
    
    // Perulangan mundur untuk menyisipkan tanda titik setiap 3 digit
    for (int i = totalStr.length - 1; i >= 0; i--) {
      buffer.write(totalStr[i]); // Tulis karakter angka
      count++; // Tambah counter digit
      if (count % 3 == 0 && i != 0) buffer.write('.'); // Sisipkan tanda titik pemisah ribuan
    }
    return 'Rp ${buffer.toString().split('').reversed.join('')}'; // Balik teks dan tambahkan prefiks Rp
  }

  // Menambahkan produk obat baru ke dalam keranjang
  void addToCart(Map<String, dynamic> obat) {
    final index = _items.indexWhere((item) => item.judul == obat['judul']); // Cari indeks produk yang sama
    if (index >= 0) {
      _items[index].quantity += 1; // Jika produk sudah ada, tambah jumlahnya
    } else {
      _items.add(CartItem(judul: obat['judul'], harga: obat['harga'], foto: obat['foto'])); // Jika belum ada, buat item baru
    }
    notifyListeners(); // Mengabari seluruh UI untuk memperbarui tampilan
  }

  // Menambah jumlah kuantitas produk obat tertentu sebanyak 1
  void incrementQuantity(String judul) {
    final index = _items.indexWhere((item) => item.judul == judul); // Cari indeks item produk
    if (index >= 0) {
      _items[index].quantity += 1; // Naikkan kuantitas
      notifyListeners(); // Perbarui pendengar data
    }
  }

  // Mengurangi jumlah kuantitas produk obat tertentu sebanyak 1
  void decrementQuantity(String judul) {
    final index = _items.indexWhere((item) => item.judul == judul); // Cari indeks item produk
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity -= 1; // Jika lebih dari 1, kurangi kuantitas
      } else {
        _items.removeAt(index); // Jika kuantitas tinggal 1, hapus item dari list
      }
      notifyListeners(); // Perbarui pendengar data
    }
  }

  // Menghapus item obat tertentu dari daftar keranjang belanja
  void removeItem(String judul) {
    _items.removeWhere((item) => item.judul == judul); // Cari dan hapus item produk
    notifyListeners(); // Perbarui pendengar data
  }

  // Mengosongkan isi seluruh keranjang belanjaan
  void clearCart() {
    _items.clear(); // Hapus seluruh data item belanjaan
    notifyListeners(); // Perbarui pendengar data
  }

  // Melakukan Checkout pesanan dari keranjang belanja ke riwayat transaksi
  void checkoutCart() {
    if (_items.isEmpty) return; // Batalkan aksi jika keranjang masih kosong

    final now = DateTime.now(); // Ambil tanggal hari ini
    final months = ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember']; // Nama bulan
    final date = '${now.day} ${months[now.month - 1]} ${now.year}'; // Merakit tanggal terformat
    final names = _items.map((item) => '${item.judul} (${item.quantity}x)').join(', '); // Merakit list nama produk
    final trxId = 'TRX-${(now.millisecondsSinceEpoch % 100000).toString().padLeft(5, '0')}Z'; // Membuat ID Transaksi unik acak

    _orders.insert(0, { // Memasukkan catatan order baru ke urutan teratas
      'id': trxId,
      'tanggal': date,
      'obat': names,
      'total': totalPriceFormatted,
      'status': 'Diproses',
      'color': Colors.orange,
      'isCompleted': false,
    });

    _items.clear(); // Kosongkan isi keranjang belanjaan setelah checkout sukses
    notifyListeners(); // Perbarui pendengar data
  }
}
