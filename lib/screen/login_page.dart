// Mengimpor package Flutter Material Design
// Diperlukan untuk widget dasar seperti Scaffold, Column, ElevatedButton, dll.
import 'package:flutter/material.dart';

// Mengimpor Google Fonts untuk menggunakan font Poppins
import 'package:google_fonts/google_fonts.dart';

// Mengimpor widget MyTextField yang sudah dibuat sendiri (custom widget)
// Lokasinya di folder components/text_field.dart
import '../components/text_field.dart';

// Mengimpor data user (username, password, nama) dari file user.dart
// File ini kemungkinan berisi objek "user1" dengan kredensial login
import '../models/user.dart';

// Mengimpor halaman MovieListPage yang akan dibuka setelah login berhasil
import 'movie_list_page.dart';

// =====================================================
// LoginPage adalah StatefulWidget karena:
// - Ada teks error yang bisa muncul/hilang (perlu setState)
// - Ada kondisi isLoggedIn yang bisa berubah
// - Perlu merespons interaksi pengguna secara dinamis
// =====================================================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // =====================================================
  // STATE / DATA INTERNAL HALAMAN INI
  // =====================================================

  // Controller untuk field username
  // Digunakan untuk membaca teks yang diketik user di kolom username
  // userC.text = mengambil isi teks username
  final TextEditingController userC = TextEditingController();

  // Controller untuk field password
  // passC.text = mengambil isi teks password
  final TextEditingController passC = TextEditingController();

  // Boolean penanda apakah user sudah login atau belum
  // Saat ini tidak dipakai secara aktif di UI, tapi bisa berguna untuk pengembangan selanjutnya
  bool isLoggedin = false;

  // String pesan error yang ditampilkan ketika login gagal
  // Awalnya kosong ("") = tidak ada error, pesan error tidak ditampilkan
  String errorMessage = "";

  // =====================================================
  // METHOD: _login
  // Fungsi yang dipanggil saat tombol Login ditekan
  // Bertugas memvalidasi username & password yang diinput user
  // =====================================================
  void _login() {

    // setState() = memberitahu Flutter bahwa ada data yang berubah
    // Flutter akan memanggil build() ulang sehingga tampilan terupdate
    setState(() {

      // Mengecek apakah username DAN password yang diketik
      // cocok dengan data user1 yang tersimpan di file user.dart
      // "==" = operator perbandingan (apakah sama?)
      if (userC.text == user1.username && passC.text == user1.password) {

        // Jika login BERHASIL:
        // Kosongkan pesan error (jika sebelumnya ada)
        errorMessage = "";

        // Navigator.pushReplacement = berpindah ke halaman baru
        // "pushReplacement" artinya halaman LoginPage DIGANTI dengan MovieListPage
        // (tidak bisa kembali ke login dengan tombol back)
        // Berbeda dengan push biasa yang menumpuk halaman
        Navigator.pushReplacement(
          context, // informasi posisi widget di widget tree

          // MaterialPageRoute = cara berpindah halaman dengan animasi default Material
          MaterialPageRoute(
            // builder = fungsi yang membangun halaman tujuan
            // Mengirim "name" dari user1 ke MovieListPage (untuk ditampilkan sebagai sapaan)
            builder: (context) => MovieListPage(name: user1.name),
          ),
        );

      } else {

        // Jika login GAGAL:
        // Tampilkan pesan error default (sekaligus membocorkan kredensial 😄)
        errorMessage = "salah oi! sini kubisikin, un: nikita & pass: 044";

        // Validasi tambahan: cek apakah field username atau password ada yang kosong
        // Jika kosong, tampilkan pesan yang lebih spesifik
        // Catatan: kondisi ini dicek SETELAH error default diset,
        // sehingga jika kosong, pesan ini yang menimpa/mengganti pesan sebelumnya
        if (userC.text.isEmpty || passC.text.isEmpty) {
          errorMessage = "jangan dikosongin dong";
        }
      }
    });
  }

  // build() = menggambarkan tampilan halaman Login
  @override
  Widget build(BuildContext context) {

    // Scaffold = kerangka dasar halaman
    // Halaman ini tidak pakai AppBar karena desain full-screen tanpa header
    return Scaffold(

      body: Padding(
        // Padding 30px di semua sisi agar konten tidak terlalu mepet ke tepi layar
        padding: const EdgeInsets.all(30.0),

        // Column = menyusun semua widget secara vertikal (atas ke bawah)
        child: Column(

          // MainAxisAlignment.center = semua konten diposisikan di TENGAH secara vertikal
          // Sehingga form login berada di tengah-tengah layar
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            // ---- GAMBAR ILUSTRASI LOGIN ----
            // Image.asset = menampilkan gambar dari folder assets lokal (bukan dari internet)
            // File gambar harus didaftarkan di pubspec.yaml terlebih dahulu
            // width: 300 = lebar gambar 300px, tinggi menyesuaikan otomatis
            Image.asset('assets/login_img.png', width: 300),

            // Jarak 30px antara gambar dan teks judul
            const SizedBox(height: 30),

            // ---- TEKS JUDUL HALAMAN ----
            Text(
              'Login dulu ya!',
              style: GoogleFonts.poppins(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Jarak 15px antara judul dan area pesan error
            const SizedBox(height: 15),

            // ---- PESAN ERROR (KONDISIONAL) ----
            // Widget ini HANYA ditampilkan jika errorMessage tidak kosong
            // "if (kondisi) widget" = cara menampilkan widget secara kondisional di Flutter
            // Jika errorMessage == "" → widget ini tidak dirender sama sekali
            // Jika errorMessage berisi teks → widget ini muncul
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage, // teks pesan error yang akan ditampilkan
                textAlign: TextAlign.center, // teks rata tengah
                style: GoogleFonts.poppins(
                  color: Colors.redAccent,       // warna merah untuk menandai error
                  fontSize: 14,
                  fontWeight: FontWeight.w500,   // ketebalan sedang
                  fontStyle: FontStyle.italic,   // teks miring (italic)
                ),
              ),

            // Jarak 20px sebelum field username
            const SizedBox(height: 20),

            // ---- FIELD USERNAME ----
            // Menggunakan custom widget MyTextField yang sudah dibuat sebelumnya
            // controller: userC → menghubungkan field ini dengan controller username
            // hintText: 'Username' → teks placeholder
            // obsecureText: false → teks TIDAK disembunyikan (username boleh terlihat)
            MyTextField(
              controller: userC,
              hintText: 'Username',
              obsecureText: false,
            ),

            // Jarak 20px antara field username dan password
            const SizedBox(height: 20),

            // ---- FIELD PASSWORD ----
            // obsecureText: true → teks DISEMBUNYIKAN (tampil sebagai "••••••")
            MyTextField(
              controller: passC,
              hintText: 'Password',
              obsecureText: true,
            ),

            // Jarak 20px sebelum tombol login
            const SizedBox(height: 20),

            // ---- TOMBOL LOGIN ----
            ElevatedButton(
              // Memanggil fungsi _login() saat tombol ditekan
              onPressed: _login,

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,  // warna latar tombol: kuning
                foregroundColor: Colors.white,  // warna teks tombol: putih

                // Tombol selebar layar (double.infinity) dan tinggi 54px
                minimumSize: const Size(double.infinity, 54),

                // Sudut tombol melengkung 20px (pill shape)
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              // Teks yang ditampilkan di dalam tombol
              child: Text(
                'Login',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}