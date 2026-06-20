import 'package:flutter/material.dart';

class PesanPage extends StatelessWidget {
  const PesanPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Pesan & Konsultasi', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: daftarObrolan.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final chat = daftarObrolan[index];
          final isOnline = chat['status'] == 'Online';
          return Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Stack(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: chat['avatarColor'] as Color,
                    child: Text(
                      (chat['nama'] as String).split(' ').last[0],
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  if (isOnline)
                    Positioned(
                      right: 0, bottom: 0,
                      child: Container(
                        width: 14, height: 14,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    )
                ],
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(chat['nama'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text(chat['waktu'] as String, style: TextStyle(color: Colors.grey[500], fontSize: 11)),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(chat['peran'] as String, style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.w600, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text(
                      chat['pesanTerakhir'] as String,
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      maxLines: 1, overflow: TextOverflow.ellipsis,
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
              ),
            ),
          );
        },
      ),
    );
  }
}

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
  late List<Map<String, dynamic>> _messages;
  final _textController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _messages = List.from(widget.history);
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

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

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'isUser': true, 'text': text});
      _textController.clear();
    });
    _scrollToBottom();

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        _messages.add({
          'isUser': false,
          'text': 'Terima kasih atas pesan Anda. Pesan Anda telah diterima dan akan segera ditanggapi oleh pihak ${widget.nama}.'
        });
      });
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.nama, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
            Text(widget.peran, style: const TextStyle(fontSize: 11, color: Colors.white70)),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['isUser'] as bool;
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue[800] : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(isUser ? 16 : 0),
                        bottomRight: Radius.circular(isUser ? 0 : 16),
                      ),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 4, offset: const Offset(0, 2))
                      ],
                    ),
                    child: Text(
                      msg['text'] as String,
                      style: TextStyle(color: isUser ? Colors.white : Colors.black87, fontSize: 14, height: 1.4),
                    ),
                  ),
                );
              },
            ),
          ),
          
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(10),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Tulis pesan Anda...',
                        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        filled: true, fillColor: Colors.grey[50],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: Colors.blue[900],
                    radius: 22,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white, size: 18),
                      onPressed: _sendMessage,
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
