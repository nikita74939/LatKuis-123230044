// Mengimpor package Flutter Material Design dari pub.dev (package manager Flutter)
// Wajib diimpor di setiap file Flutter yang menggunakan widget UI
// Menyediakan widget dasar seperti: StatelessWidget, TextField, InputDecoration, dll.
import 'package:flutter/material.dart';

// Mengimpor package google_fonts dari pub.dev
// Memungkinkan kita menggunakan ratusan font dari Google secara langsung
// Contoh font yang tersedia: Poppins, Roboto, Lato, Montserrat, dll.
// Cara install: tambahkan "google_fonts: ^versi" di file pubspec.yaml
import 'package:google_fonts/google_fonts.dart';

// =====================================================
// CLASS MyTextField
// =====================================================
// Ini adalah Custom Widget — widget buatan sendiri yang dibungkus agar bisa dipakai ulang
// Keuntungan membuat custom widget:
//   ✅ Tidak perlu menulis kode yang sama berulang kali
//   ✅ Cukup panggil MyTextField() di mana saja dengan parameter berbeda
//   ✅ Jika ingin mengubah tampilan, cukup ubah di satu tempat ini saja
//
// StatelessWidget = widget yang TIDAK memiliki state/kondisi internal
// Artinya tampilan widget ini HANYA bergantung pada data yang dikirim dari luar (properti)
// Widget ini tidak bisa mengubah tampilannya sendiri tanpa data baru dari luar
class MyTextField extends StatelessWidget {

  // =====================================================
  // DEKLARASI PROPERTI
  // Properti = data yang dikirim dari luar ke dalam widget ini
  // Semua dideklarasikan dengan "final" → nilainya tidak bisa diubah setelah widget dibuat
  // =====================================================

  // TextEditingController = objek pengendali TextField
  // Fungsinya:
  //   → Membaca teks yang diketik user: controller.text
  //   → Menghapus isi TextField: controller.clear()
  //   → Mengisi TextField dari kode: controller.text = "isi baru"
  // Controller dibuat di luar widget ini, lalu "dikirim masuk" lewat properti ini
  final TextEditingController controller;

  // String = tipe data teks
  // hintText = teks abu-abu yang muncul di dalam kotak input saat masih kosong
  // Contoh: "Masukkan email Anda" atau "Password minimal 8 karakter"
  // Akan otomatis menghilang saat user mulai mengetik
  final String hintText;

  // bool = tipe data boolean, hanya bisa bernilai true atau false
  // obsecureText mengontrol apakah teks yang diketik disembunyikan atau tidak:
  //   → true  : teks disembunyikan dengan "••••••" (untuk kolom password)
  //   → false : teks tampil normal seperti biasa (untuk email, username, dll.)
  // Catatan: ada typo di nama ini, seharusnya "obscureText" (tanpa huruf 'e' setelah 'obs')
  //          namun karena ini nama properti buatan sendiri, Flutter tetap menerimanya
  final bool obsecureText;

  // =====================================================
  // CONSTRUCTOR
  // Constructor = cara membuat/menginstansiasi widget ini
  // Dipanggil saat kita menulis: MyTextField(controller: ..., hintText: ..., obsecureText: ...)
  // =====================================================

  // "const" = widget ini bisa dibuat saat compile time jika semua nilai sudah diketahui
  //           ini membuat performa lebih baik karena Flutter tidak perlu membuatnya ulang
  // "super.key" = meneruskan parameter key ke class induk (StatelessWidget)
  //              key digunakan Flutter untuk mengidentifikasi widget secara unik di widget tree
  // "required" = parameter WAJIB diisi, jika tidak diisi maka akan error saat compile
  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obsecureText,
  });

  // =====================================================
  // METHOD BUILD
  // Ini adalah method wajib yang harus ada di setiap widget Flutter
  // Flutter memanggil method ini setiap kali widget perlu digambar/dirender ke layar
  // Harus mengembalikan (return) sebuah Widget
  // "context" = informasi tentang posisi widget ini di dalam widget tree
  //             bisa digunakan untuk mengakses tema, ukuran layar, navigator, dll.
  // =====================================================
  @override
  Widget build(BuildContext context) {

    // TextField = widget input teks bawaan Flutter
    // Menampilkan kotak yang bisa diketik oleh pengguna
    // Ini adalah widget yang akan benar-benar terlihat dan bisa diinteraksi di layar
    return TextField(

      // Menghubungkan controller ke TextField ini
      // Tanpa ini, kita tidak bisa membaca atau mengontrol isi TextField dari luar
      controller: controller,

      // Meneruskan nilai obsecureText ke parameter obscureText milik TextField
      // Perhatikan: nama properti kita "obsecureText" (typo) tapi parameter Flutter "obscureText" (benar)
      // Flutter menggunakan nilai ini untuk memutuskan apakah teks ditampilkan atau disembunyikan
      obscureText: obsecureText,

      // InputDecoration = class khusus untuk mengatur seluruh tampilan visual TextField
      // Mengontrol: border, hint, label, prefix icon, suffix icon, warna background, dll.
      decoration: InputDecoration(

        // Mengatur tampilan garis tepi (border) di sekeliling TextField
        // OutlineInputBorder = border berbentuk persegi panjang mengelilingi seluruh TextField
        // (alternatif lain: UnderlineInputBorder = hanya garis bawah)
        border: OutlineInputBorder(

          // BorderRadius.circular(20) = membuat keempat sudut border menjadi melengkung 20px
          // Semakin besar angka → semakin melengkung (misal: 50 akan terlihat seperti pill/kapsul)
          // Semakin kecil angka → semakin kotak (misal: 0 = sudut lancip sempurna)
          borderRadius: BorderRadius.circular(20),
        ),

        // Teks placeholder yang ditampilkan di dalam TextField saat masih kosong
        // Nilai diambil dari properti hintText yang dikirim dari luar widget
        hintText: hintText,

        // Mengatur gaya visual dari teks hint (placeholder)
        // GoogleFonts.poppins() = menggunakan font Poppins dari Google
        // fontSize: 16 = ukuran huruf hint text adalah 16 logical pixel
        // Bisa tambahkan parameter lain seperti: color, fontWeight, fontStyle, dll.
        hintStyle: GoogleFonts.poppins(fontSize: 16),
      ),
    );
  }
}