import 'package:flutter/material.dart';

class CartItem {
  final String judul;
  final String harga;
  final String foto;
  int quantity;

  CartItem({
    required this.judul,
    required this.harga,
    required this.foto,
    this.quantity = 1,
  });

  int get numericPrice => int.parse(harga.replaceAll(RegExp(r'[^0-9]'), ''));

  int get totalNumericPrice => numericPrice * quantity;
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];
  final List<Map<String, dynamic>> _orders = [
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

  List<CartItem> get items => _items;
  List<Map<String, dynamic>> get orders => _orders;

  int get totalItemsCount => _items.fold(0, (sum, item) => sum + item.quantity);

  int get totalNumericPrice => _items.fold(0, (sum, item) => sum + item.totalNumericPrice);

  String get totalPriceFormatted {
    final total = totalNumericPrice;
    final buffer = StringBuffer();
    final totalStr = total.toString();
    int count = 0;
    
    for (int i = totalStr.length - 1; i >= 0; i--) {
      buffer.write(totalStr[i]);
      count++;
      if (count % 3 == 0 && i != 0) buffer.write('.');
    }
    return 'Rp ${buffer.toString().split('').reversed.join('')}';
  }

  void addToCart(Map<String, dynamic> obat) {
    final index = _items.indexWhere((item) => item.judul == obat['judul']);
    if (index >= 0) {
      _items[index].quantity += 1;
    } else {
      _items.add(CartItem(judul: obat['judul'], harga: obat['harga'], foto: obat['foto']));
    }
    notifyListeners();
  }

  void incrementQuantity(String judul) {
    final index = _items.indexWhere((item) => item.judul == judul);
    if (index >= 0) {
      _items[index].quantity += 1;
      notifyListeners();
    }
  }

  void decrementQuantity(String judul) {
    final index = _items.indexWhere((item) => item.judul == judul);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity -= 1;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void removeItem(String judul) {
    _items.removeWhere((item) => item.judul == judul);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  void checkoutCart() {
    if (_items.isEmpty) return;

    final now = DateTime.now();
    final months = ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
    final date = '${now.day} ${months[now.month - 1]} ${now.year}';
    final names = _items.map((item) => '${item.judul} (${item.quantity}x)').join(', ');
    final trxId = 'TRX-${(now.millisecondsSinceEpoch % 100000).toString().padLeft(5, '0')}Z';

    _orders.insert(0, {
      'id': trxId,
      'tanggal': date,
      'obat': names,
      'total': totalPriceFormatted,
      'status': 'Diproses',
      'color': Colors.orange,
      'isCompleted': false,
    });

    _items.clear();
    notifyListeners();
  }
}
