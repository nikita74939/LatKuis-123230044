// =====================================================
// CLASS USER — Blueprint/Cetakan untuk data pengguna
// =====================================================
// "class" adalah cara membuat blueprint/cetakan objek di Dart
// Bayangkan class seperti "formulir kosong" yang mendefinisikan
// informasi apa saja yang dimiliki seorang User
class User {

  // =====================================================
  // PROPERTI / ATRIBUT
  // Ini adalah data yang dimiliki setiap objek User
  // Tidak pakai "final" → artinya nilai-nilai ini BISA diubah setelah objek dibuat
  // =====================================================

  // Menyimpan username pengguna
  // Tipe data String = teks (huruf, angka, simbol)
  // Contoh: 'nikita', 'john_doe', 'user123'
  String username;

  // Menyimpan password pengguna
  // Contoh: '044', 'abc123', 'rahasia'
  String password;

  // Menyimpan nama lengkap pengguna
  // Contoh: 'Nikita', 'John Doe'
  String name;

  // =====================================================
  // CONSTRUCTOR
  // Fungsi khusus yang dipanggil saat membuat objek User baru
  // Nama constructor HARUS sama dengan nama class-nya (User)
  // =====================================================
  // Kurung kurawal {} = named parameters (parameter dengan nama)
  // Keuntungan named parameters: urutan boleh ditukar saat memanggil,
  // dan lebih mudah dibaca karena tertulis nama parameternya
  // "required" = parameter WAJIB diisi, tidak boleh dilewati
  User({required this.username, required this.password, required this.name});
  //         ↑                        ↑                       ↑
  //   "this.username" artinya nilai yang dikirim langsung disimpan
  //   ke properti username milik class ini (begitu juga yang lain)
}


// =====================================================
// MEMBUAT OBJEK / INSTANCE DARI CLASS USER
// =====================================================
// Ini adalah cara "mencetak" formulir User yang sudah diisi dengan data nyata
// "User(...)" = memanggil constructor class User
// "user1" = nama variabel yang menyimpan objek User ini
// Tidak pakai "final" → artinya variabel user1 bisa diganti objek lain nantinya
User user1 = User(
  username: 'nikita',  // mengisi properti username dengan teks 'nikita'
  password: '044',     // mengisi properti password dengan teks '044'
  name: 'Nikita',      // mengisi properti name dengan teks 'Nikita'
);