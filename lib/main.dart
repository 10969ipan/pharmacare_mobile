import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme.dart';
import 'pages/welcome/welcome_page.dart';
import 'providers/cart_provider.dart';

void main() {
  runApp(const PharmacareApp());
}

class PharmacareApp extends StatelessWidget {
  const PharmacareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: MaterialApp(
        title: 'Pharmacare',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const WelcomePage(),
      ),
    );
  }
}
