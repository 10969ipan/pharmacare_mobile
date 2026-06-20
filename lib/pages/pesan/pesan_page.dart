import 'package:flutter/material.dart';

// Halaman Daftar Pesan / Chat dengan Apoteker atau Customer Service
class PesanPage extends StatelessWidget {
  const PesanPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data tiruan daftar obrolan aktif
    final daftarObrolan = [
      {
        'nama': 'Apoteker Sima',
        'peran': 'Konsultasi Obat & Dosis',
        'pesanTerakhir': 'Halo, ada yang bisa dibantu mengenai resep obat Anda?',
        'waktu': '10:30',
        'status': 'Online',
        'avatarColor': Colors.teal,
        'chatHistory': [
          {'isUser': false, 'text': 'Selamat datang di layanan konsultasi Pharmacare.'},
          {'isUser': false, 'text': 'Halo, ada yang bisa dibantu mengenai resep obat Anda?'},
        ]
      },
      {
        'nama': 'Customer Service',
        'peran': 'Layanan & Bantuan Pesanan',
        'pesanTerakhir': 'Sama-sama, pesanan Anda akan segera kami kirimkan hari ini.',
        'waktu': 'Kemarin',
        'status': 'Offline',
        'avatarColor': const Color(0xFF0D47A1),
        'chatHistory': [
          {'isUser': true, 'text': 'Halo, apakah pesanan saya sudah dikirim?'},
          {'isUser': false, 'text': 'Halo, pesanan Anda sedang dikemas dan siap dikirim.'},
          {'isUser': true, 'text': 'Terima kasih atas bantuannya!'},
          {'isUser': false, 'text': 'Sama-sama, pesanan Anda akan segera kami kirimkan hari ini.'},
        ]
      },
      {
        'nama': 'Dr. Maudy Ayunda',
        'peran': 'Konsultasi Medis Umum',
        'pesanTerakhir': 'Silakan kirim hasil pemeriksaan lab Anda di sini.',
        'waktu': '18 Juni',
        'status': 'Offline',
        'avatarColor': Colors.purple,
        'chatHistory': [
          {'isUser': false, 'text': 'Halo, silakan jelaskan keluhan medis Anda secara detail.'},
          {'isUser': false, 'text': 'Silakan kirim hasil pemeriksaan lab Anda di sini.'},
        ]
      }
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA), // Latar belakang abu-abu terang
      appBar: AppBar(
        backgroundColor: Colors.blue[900], // Warna biru tua khas Pharmacare
        title: const Text('Pesan & Konsultasi', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)), // Judul halaman
        iconTheme: const IconThemeData(color: Colors.white), // Tombol kembali berwarna putih
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16), // Padding batas luar list chat
        itemCount: daftarObrolan.length, // Total obrolan
        separatorBuilder: (_, _) => const SizedBox(height: 12), // Jarak antar kartu chat
        itemBuilder: (context, index) {
          final chat = daftarObrolan[index];
          final isOnline = chat['status'] == 'Online';
          return Card(
            elevation: 1, // Efek bayangan tipis
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Sudut melengkung kartu
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Padding internal list tile
              leading: Stack(
                children: [
                  CircleAvatar(
                    radius: 26, // Ukuran lingkaran avatar
                    backgroundColor: chat['avatarColor'] as Color, // Warna latar belakang avatar
                    child: Text(
                      (chat['nama'] as String).split(' ').last[0], // Karakter inisial huruf belakang nama
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  if (isOnline)
                    Positioned(
                      right: 0, bottom: 0, // Posisi penanda status online di sudut kanan bawah avatar
                      child: Container(
                        width: 14, height: 14,
                        decoration: BoxDecoration(
                          color: Colors.green, // Hijau menandakan online aktif
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2), // Garis putih pembatas
                        ),
                      ),
                    )
                ],
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Sejajarkan nama dan waktu di ujung kanan
                children: [
                  Text(chat['nama'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)), // Nama kontak chat
                  Text(chat['waktu'] as String, style: TextStyle(color: Colors.grey[500], fontSize: 11)), // Waktu pengiriman pesan terakhir
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0), // Spasi atas subtitle
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(chat['peran'] as String, style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.w600, fontSize: 12)), // Peran/departemen kontak
                    const SizedBox(height: 4), // Jarak vertikal kecil
                    Text(
                      chat['pesanTerakhir'] as String, // Cuplikan teks pesan terakhir
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      maxLines: 1, overflow: TextOverflow.ellipsis, // Batasi teks panjang dengan titik-titik
                    ),
                  ],
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailChatPage(
                    nama: chat['nama'] as String,
                    peran: chat['peran'] as String,
                    history: chat['chatHistory'] as List<Map<String, dynamic>>,
                  ),
                ),
              ), // Aksi membuka ruang percakapan detail
            ),
          );
        },
      ),
    );
  }
}

// Halaman Ruang Obrolan / Detail Chat Interaktif
class DetailChatPage extends StatefulWidget {
  final String nama;
  final String peran;
  final List<Map<String, dynamic>> history;

  const DetailChatPage({
    super.key,
    required this.nama,
    required this.peran,
    required this.history,
  });

  @override
  State<DetailChatPage> createState() => _DetailChatPageState();
}

class _DetailChatPageState extends State<DetailChatPage> {
  late List<Map<String, dynamic>> _messages; // List penyimpan riwayat pesan saat ini
  final _textController = TextEditingController(); // Controller input kolom teks pesan
  final _scrollController = ScrollController(); // Scroll controller otomatis scroll ke bawah

  @override
  void initState() {
    super.initState();
    _messages = List.from(widget.history); // Kloning riwayat obrolan ke lokal state
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom()); // Scroll ke bawah setelah frame pertama dirender
  }

  @override
  void dispose() {
    _textController.dispose(); // Hapus controller mencegah kebocoran memori
    _scrollController.dispose();
    super.dispose();
  }

  // Melakukan scroll list otomatis ke baris pesan terbawah secara halus
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // Mengirimkan pesan baru dari input pengguna
  void _sendMessage() {
    final text = _textController.text.trim(); // Ambil teks dan hapus spasi kosong
    if (text.isEmpty) return; // Batalkan jika teks kosong

    setState(() {
      _messages.add({'isUser': true, 'text': text}); // Tambahkan pesan user ke daftar obrolan
      _textController.clear(); // Bersihkan kolom input teks
    });
    _scrollToBottom(); // Scroll ke posisi terbawah

    // Memberikan simulasi respon otomatis apoteker/CS setelah jeda 1 detik
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        _messages.add({
          'isUser': false,
          'text': 'Terima kasih atas pesan Anda. Pesan Anda telah diterima dan akan segera ditanggapi oleh pihak ${widget.nama}.'
        }); // Respon sistem otomatis
      });
      _scrollToBottom(); // Scroll kembali ke terbawah
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Latar belakang abu-abu terang
      appBar: AppBar(
        backgroundColor: Colors.blue[900], // AppBar biru gelap
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.nama, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)), // Nama lawan chat
            Text(widget.peran, style: const TextStyle(fontSize: 11, color: Colors.white70)), // Peran pendukung
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white), // Tombol back warna putih
      ),
      body: Column(
        children: [
          // Ruang Tampilan Pesan-Pesan Terkirim
          Expanded(
            child: ListView.builder(
              controller: _scrollController, // scroll controller
              padding: const EdgeInsets.all(16.0), // Padding ruang gelembung chat
              itemCount: _messages.length, // Jumlah pesan
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['isUser'] as bool;
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft, // Gelembung kanan untuk user, kiri untuk bot/apoteker
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10), // Jarak spasi bawah antar pesan
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10), // Padding dalam gelembung pesan
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75), // Gelembung maksimal 75% lebar layar
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue[800] : Colors.white, // Biru untuk user, putih untuk pihak apotek
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(isUser ? 16 : 0), // Melengkung lancip di sisi kiri bawah jika bukan user
                        bottomRight: Radius.circular(isUser ? 0 : 16), // Melengkung lancip di sisi kanan bawah jika user
                      ),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 4, offset: const Offset(0, 2)) // Bayangan tipis melayang
                      ],
                    ),
                    child: Text(
                      msg['text'] as String, // Konten teks pesan
                      style: TextStyle(color: isUser ? Colors.white : Colors.black87, fontSize: 14, height: 1.4), // Desain teks
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Panel Penginputan Pesan di Bawah Layar
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(10), // Padding kolom masukan
              color: Colors.white, // Latar putih bersih panel input
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController, // Penghubung teks masukan
                      decoration: InputDecoration(
                        hintText: 'Tulis pesan Anda...', // Placeholder bantuan masukan teks
                        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14), // Gaya placeholder abu-abu
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), // Padding dalam input
                        filled: true, fillColor: Colors.grey[50], // Latar abu sangat halus
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none), // Input berbentuk lonjong mulus tanpa garis tepi
                      ),
                      onSubmitted: (_) => _sendMessage(), // Kirim pesan bila tombol Enter/Kirim keyboard ditekan
                    ),
                  ),
                  const SizedBox(width: 8), // Spasi kecil pemisah tombol kirim
                  CircleAvatar(
                    backgroundColor: Colors.blue[900], // Latar belakang tombol bulat biru tua
                    radius: 22,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white, size: 18), // Ikon pesawat kirim
                      onPressed: _sendMessage, // Aksi kirim pesan saat ditekan
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
