import 'package:flutter/material.dart';
import '../main_page.dart';
import '../registrasi/registrasi_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController(), _pass = TextEditingController();

  @override
  void dispose() {
    for (var c in [_email, _pass]) {
      c.dispose();
    }
    super.dispose();
  }

  void _handleLogin() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MainPage()),
      (route) => false,
    );
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Login Berhasil! Selamat Datang.'),
      backgroundColor: Colors.blue,
      behavior: SnackBarBehavior.floating,
    ));
  }

  Widget _field(TextEditingController c, String lbl, String hint, IconData icon, {bool obscure = false, TextInputType type = TextInputType.text}) => TextField(
    controller: c,
    obscureText: obscure,
    keyboardType: type,
    decoration: InputDecoration(
      labelText: lbl,
      hintText: hint,
      prefixIcon: Icon(icon, color: const Color(0xFF1E88E5)),
      filled: true, fillColor: Colors.grey[50],
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF1E88E5), width: 2)),
    ),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      title: const Text('Login', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
      backgroundColor: Colors.white, elevation: 0, centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.black87),
    ),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: const Text(
                'Pharmacare',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Color(0xFF1E88E5),
                ),
              ),
            ),
            const Text('Masuk ke Akun Anda', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50)), textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text('Silakan login untuk menikmati semua layanan Pharmacare', style: TextStyle(fontSize: 13, color: Colors.grey[600]), textAlign: TextAlign.center),
            const SizedBox(height: 32),
            _field(_email, "Email", "Contoh: user@email.com", Icons.email_outlined, type: TextInputType.emailAddress),
            const SizedBox(height: 16),
            _field(_pass, "Password", "Masukkan password Anda", Icons.lock_outline, obscure: true),
            const SizedBox(height: 32),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0,
                ),
                child: const Text("Masuk", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Belum memiliki akun? ", style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage())),
                  child: const Text("Daftar Sekarang", style: TextStyle(color: Color(0xFF1E88E5), fontWeight: FontWeight.bold, fontSize: 13)),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    ),
  );
}
