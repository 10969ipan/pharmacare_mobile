import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nama = TextEditingController(), _email = TextEditingController(), _phone = TextEditingController(), _pass = TextEditingController();

  @override
  void dispose() {
    for (var c in [_nama, _email, _phone, _pass]) {
      c.dispose();
    }
    super.dispose();
  }

  void _handleRegister() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Registrasi Berhasil! Silakan Login.'),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
    ));
    Navigator.pop(context);
  }

  Widget _field(TextEditingController c, String lbl, String hint, IconData icon, {bool obscure = false, TextInputType type = TextInputType.text}) => TextField(
    controller: c,
    obscureText: obscure,
    keyboardType: type,
    decoration: InputDecoration(
      labelText: lbl,
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.green),
      filled: true, fillColor: Colors.grey[50],
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.green, width: 2)),
    ),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      title: const Text('Registrasi', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
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
            const Text('Buat Akun Baru', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50)), textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text('Lengkapi data diri Anda untuk memulai perjalanan sehat', style: TextStyle(fontSize: 13, color: Colors.grey[600]), textAlign: TextAlign.center),
            const SizedBox(height: 24),
            _field(_nama, "Nama Lengkap", "Contoh: Budi Santoso", Icons.account_circle_outlined),
            const SizedBox(height: 16),
            _field(_email, "Email", "Contoh: budi@email.com", Icons.email_outlined, type: TextInputType.emailAddress),
            const SizedBox(height: 16),
            _field(_phone, "No. Hp", "Contoh: 08123456789", Icons.phone_outlined, type: TextInputType.phone),
            const SizedBox(height: 16),
            _field(_pass, "Password", "Masukkan password minimal 6 karakter", Icons.lock_outline, obscure: true),
            const SizedBox(height: 32),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _handleRegister,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0,
                ),
                child: const Text("Daftar", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sudah memiliki akun? ", style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text("Login Di Sini", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13)),
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
