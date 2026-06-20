import 'package:flutter/material.dart';
import '../login/login_page.dart';
import '../registrasi/registrasi_page.dart';

// Halaman Pembuka/Selamat Datang (Welcome Screen) Aplikasi
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      // Gradasi latar belakang yang sangat halus dan premium untuk kesan modern
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Color(0xFFF2F7FD)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0), // Padding yang lebih longgar
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Meluaskan isi secara horizontal penuh
            children: [
              const Spacer(flex: 2), // Pendorong atas dengan flex lebih tinggi
              
              // Ikon medis minimalis melayang untuk memperkuat tema aplikasi
              Center(
                child: Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E88E5).withValues(alpha: 0.1), // Lingkaran biru transparan halus
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.health_and_safety_outlined,
                    size: 48,
                    color: Color(0xFF1E88E5), // Ikon kesehatan biru primer
                  ),
                ),
              ),
              const SizedBox(height: 24), // Jarak di bawah ikon
              
              // Brand Logo Teks Minimalis
              const Text(
                'Pharmacare',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w900, // Teks super tebal modern
                  letterSpacing: 1.5,
                  color: Color(0xFF1E88E5), // Biru primer yang sinkron dengan tombol
                ),
              ),
              const SizedBox(height: 16), // Jarak pemisah
              
              // Teks Sapaan Utama
              const Text(
                "Selamat Datang",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10), // Jarak subjudul
              
              // Subjudul Deskripsi Aplikasi yang bersih dan rapi
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Beli berbagai macam obat dan suplemen harian Anda dengan mudah hanya dalam satu aplikasi terpercaya.",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    height: 1.6, // Spasi baris tinggi ala desain modern
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              
              const Spacer(flex: 3), // Pendorong bawah yang lebih fleksibel
              
              // Tombol Masuk (Login) - Utama (Solid Blue Pill)
              SizedBox(
                height: 54, // Tinggi lebih tebal untuk kenyamanan sentuh
                child: ElevatedButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage())), // Navigasi ke halaman Login
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E88E5), // Biru primer
                    foregroundColor: Colors.white,
                    elevation: 4, // Bayangan halus
                    shadowColor: const Color(0xFF1E88E5).withValues(alpha: 0.3), // Bayangan biru
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), // Tombol bentuk pil (pill shape)
                  ),
                  child: const Text("Masuk", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 14), // Jarak antar tombol
              
              // Tombol Pendaftaran (Registrasi) - Sekunder (Clean Outlined Pill)
              SizedBox(
                height: 54,
                child: OutlinedButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage())), // Navigasi ke halaman Registrasi
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF1E88E5), width: 1.8), // Border biru agak tebal
                    foregroundColor: const Color(0xFF1E88E5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), // Tombol bentuk pil
                  ),
                  child: const Text("Registrasi", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16), // Jarak margin bawah
            ],
          ),
        ),
      ),
    ),
  );
}
