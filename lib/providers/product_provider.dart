import 'package:flutter/foundation.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [
    Product(id: '1', name: 'Paracetamol 500mg', imageUrl: '', price: 15000),
    Product(id: '2', name: 'Amoxicillin 250mg', imageUrl: '', price: 25000, isControlledSubstance: true),
    Product(id: '3', name: 'Vitamin C 1000mg', imageUrl: '', price: 35000),
    Product(id: '4', name: 'Ibuprofen 400mg', imageUrl: '', price: 18000),
    Product(id: '5', name: 'Cough Syrup 100ml', imageUrl: '', price: 45000),
    Product(id: '6', name: 'Alprazolam 1mg', imageUrl: '', price: 150000, isControlledSubstance: true),
  ];

  List<Product> get products => [..._products];

  // Additional methods like fetchProducts() will be added here
}
