// Data Katalog Obat yang Tersedia di Pharmacare
List<Map<String, dynamic>> obatList = [
  {
    'judul': 'Amlodipine Besylate 10mg', // Nama produk obat hipertensi
    'harga': 'Rp 12.000', // Harga obat per strip
    'foto': 'assets/images/amlodipine.webp', // Path file gambar produk
    'kategori': 'Resep', // Kategori obat (butuh resep dokter)
    'deskripsi': 'Amlodipine adalah obat golongan antagonis kalsium yang digunakan untuk mengatasi tekanan darah tinggi (hipertensi) dan meredakan nyeri dada (angina). Obat ini bekerja dengan melemaskan dinding pembuluh darah sehingga aliran darah menjadi lebih lancar.', // Deskripsi obat
  },
  {
    'judul': 'Amoxicillin Trihydrate 500mg', // Nama produk obat antibiotik
    'harga': 'Rp 15.500', // Harga obat per strip
    'foto': 'assets/images/amoxicillin.webp', // Path file gambar produk
    'kategori': 'Resep', // Kategori obat (butuh resep dokter)
    'deskripsi': 'Amoxicillin adalah obat antibiotik untuk mengatasi berbagai infeksi bakteri, seperti infeksi saluran pernapasan, saluran kemih, dan infeksi kulit. Obat ini bekerja dengan menghambat pertumbuhan bakteri penyebab infeksi.', // Deskripsi obat
  },
  {
    'judul': 'Betadine Antiseptic Solution', // Nama produk obat antiseptik luka
    'harga': 'Rp 21.000', // Harga obat per botol
    'foto': 'assets/images/betadine.webp', // Path file gambar produk
    'kategori': 'Bebas', // Kategori obat (dijual bebas tanpa resep)
    'deskripsi': 'Betadine Antiseptic adalah cairan antiseptik luka luar yang mengandung Povidone-Iodine 10%. Digunakan untuk mencegah dan mengobati infeksi pada luka bakar, luka potong, luka gores, dan luka khitan.', // Deskripsi obat
  },
  {
    'judul': 'Cetirizine Dihydrochloride 10mg', // Nama produk obat alergi
    'harga': 'Rp 9.000', // Harga obat per strip
    'foto': 'assets/images/cetirizine.webp', // Path file gambar produk
    'kategori': 'Bebas', // Kategori obat (dijual bebas tanpa resep)
    'deskripsi': 'Cetirizine adalah obat antihistamin generasi kedua yang efektif meredakan gejala alergi seperti bersin-bersin, hidung gatal/berair, mata berair, dan gatal kulit karena biduran tanpa menyebabkan rasa kantuk berat.', // Deskripsi obat
  },
  {
    'judul': 'Enervon C Multivitamin', // Nama produk suplemen multivitamin harian
    'harga': 'Rp 35.000', // Harga obat per botol
    'foto': 'assets/images/enervon_c.webp', // Path file gambar produk
    'kategori': 'Vitamin', // Kategori suplemen multivitamin
    'deskripsi': 'Enervon-C adalah suplemen multivitamin harian yang mengandung kombinasi Vitamin C dan Vitamin B Kompleks. Sangat efektif untuk membantu menjaga daya tahan tubuh, meningkatkan metabolisme, serta memulihkan kondisi tubuh setelah sakit.', // Deskripsi obat
  },
  {
    'judul': 'Ibuprofen 400mg', // Nama produk obat pereda nyeri/demam
    'harga': 'Rp 11.500', // Harga obat per strip
    'foto': 'assets/images/ibuprofen.webp', // Path file gambar produk
    'kategori': 'Pereda Nyeri', // Kategori obat pereda nyeri
    'deskripsi': 'Ibuprofen adalah obat antiinflamasi nonsteroid (OAINS) yang berkhasiat meredakan rasa sakit derajat ringan hingga sedang, seperti sakit kepala, sakit gigi, nyeri haid, nyeri otot, serta meredakan demam dan peradangan.', // Deskripsi obat
  },
  {
    'judul': 'Paracetamol 500mg', // Nama produk obat sakit kepala/demam umum
    'harga': 'Rp 8.000', // Harga obat per strip
    'foto': 'assets/images/paracetamol.webp', // Path file gambar produk
    'kategori': 'Pereda Nyeri', // Kategori obat pereda nyeri
    'deskripsi': 'Paracetamol adalah obat analgesik (pereda nyeri) dan antipiretik (penurun demam) yang aman digunakan untuk meredakan sakit kepala, sakit gigi, nyeri otot ringan, serta menurunkan suhu tubuh saat demam.', // Deskripsi obat
  },
  {
    'judul': 'Salbutamol Inhaler 100mcg', // Nama produk alat inhalasi asma
    'harga': 'Rp 65.000', // Harga produk per inhaler
    'foto': 'assets/images/salbutamol.webp', // Path file gambar produk
    'kategori': 'Resep', // Kategori obat (butuh resep dokter)
    'deskripsi': 'Salbutamol Inhaler adalah obat bronkodilator kerja cepat untuk meredakan serangan sesak napas pada penderita asma atau penyakit paru obstruktif kronis (PPOK). Bekerja dengan melebarkan saluran pernapasan agar udara mengalir lancar.', // Deskripsi obat
  },
  {
    'judul': 'Sangobion Kapsul', // Nama produk suplemen penambah darah/zat besi
    'harga': 'Rp 18.000', // Harga obat per strip
    'foto': 'assets/images/sangobion.webp', // Path file gambar produk
    'kategori': 'Vitamin', // Kategori suplemen multivitamin
    'deskripsi': 'Sangobion adalah suplemen zat besi dan vitamin penambah darah yang diformulasikan khusus untuk mengatasi anemia akibat kekurangan zat besi. Membantu pembentukan sel darah merah dan memulihkan vitalitas tubuh.', // Deskripsi obat
  },
  {
    'judul': 'Tolak Angin Cair', // Nama produk obat herbal masuk angin cair
    'harga': 'Rp 24.500', // Harga obat per box isi 5
    'foto': 'assets/images/tolak_angin.webp', // Path file gambar produk
    'kategori': 'Herbal', // Kategori obat tradisional/herbal
    'deskripsi': 'Tolak Angin Cair adalah obat herbal terstandar yang diformulasikan dari ekstrak bahan alami berkhasiat untuk mengatasi gejala masuk angin, perut kembung, mual, pegal-pegal, meriang, dan kelelahan perjalanan.', // Deskripsi obat
  },
];
