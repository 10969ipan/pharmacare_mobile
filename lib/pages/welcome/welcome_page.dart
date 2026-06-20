import 'package:flutter/material.dart';
import '../login/login_page.dart';
import '../registrasi/registrasi_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Color(0xFFF2F7FD)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),
              
              Center(
                child: Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E88E5).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.health_and_safety_outlined,
                    size: 48,
                    color: Color(0xFF1E88E5),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              const Text(
                'Pharmacare',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                  color: Color(0xFF1E88E5),
                ),
              ),
              const SizedBox(height: 16),
              
              const Text(
                "Selamat Datang",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Beli berbagai macam obat dan suplemen harian Anda dengan mudah hanya dalam satu aplikasi terpercaya.",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              
              const Spacer(flex: 3),
              
              SizedBox(
                height: 54,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage())),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E88E5),
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shadowColor: const Color(0xFF1E88E5).withValues(alpha: 0.3),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text("Masuk", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 14),
              
              SizedBox(
                height: 54,
                child: OutlinedButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage())),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF1E88E5), width: 1.8),
                    foregroundColor: const Color(0xFF1E88E5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text("Registrasi", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    ),
  );
}
