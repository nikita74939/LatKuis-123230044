// Mengimpor package Flutter Material Design
// Diperlukan untuk widget-widget dasar seperti Scaffold, AppBar, Column, dll.
import 'package:flutter/material.dart';

// Mengimpor package Google Fonts untuk menggunakan font Poppins
import 'package:google_fonts/google_fonts.dart';

// Mengimpor MovieModel — blueprint data film yang akan ditampilkan di halaman ini
import '../models/movie_model.dart';

// Mengimpor package url_launcher untuk membuka URL di browser eksternal
// Harus ditambahkan di pubspec.yaml terlebih dahulu: url_launcher: ^6.x.x
import 'package:url_launcher/url_launcher.dart';

// =====================================================
// DetailPage adalah StatefulWidget
// StatefulWidget = widget yang BISA berubah tampilannya
// (berbeda dengan StatelessWidget yang statis)
//
// Dipakai StatefulWidget di sini karena:
// - Ada operasi async (Future) yang membutuhkan state
// - Kemungkinan ada interaksi yang memerlukan rebuild di masa depan
// =====================================================
class DetailPage extends StatefulWidget {
  // Data film yang dikirim dari halaman sebelumnya (halaman list film)
  // Widget ini membutuhkan MovieModel untuk menampilkan semua detailnya
  final MovieModel movie;

  // Constructor: menerima data film yang wajib dikirim saat buka halaman ini
  const DetailPage({super.key, required this.movie});

  // createState() = method wajib StatefulWidget
  // Tugasnya: membuat objek State yang akan mengelola logika & tampilan halaman ini
  @override
  State<DetailPage> createState() => _DetailPageState();
}

// =====================================================
// _DetailPageState adalah State dari DetailPage
// Tanda underscore "_" di depan = PRIVATE (hanya bisa diakses di file ini)
// Di sinilah logika dan tampilan sesungguhnya ditulis
// =====================================================
class _DetailPageState extends State<DetailPage> {

  // =====================================================
  // METHOD: navigateToWikipedia
  // Fungsi untuk membuka URL Wikipedia film di browser eksternal
  //
  // "Future<void>" = fungsi ini berjalan secara ASYNCHRONOUS
  // Artinya: Flutter tidak perlu menunggu fungsi ini selesai
  // sebelum menjalankan kode lain (tidak memblokir UI)
  //
  // "async" = menandai fungsi ini sebagai asynchronous
  // =====================================================
  Future<void> navigateToWikipedia() async {

    // Uri.parse() = mengubah String URL menjadi objek Uri
    // Uri adalah format URL yang dimengerti Flutter/Dart
    // widget.movie = cara mengakses data dari StatefulWidget induk (DetailPage)
    final Uri url = Uri.parse(widget.movie.movieUrl);

    // "await" = tunggu proses ini selesai sebelum lanjut ke baris berikutnya
    // launchUrl() = fungsi dari package url_launcher untuk membuka URL
    // LaunchMode.externalApplication = buka di browser bawaan HP (bukan in-app)
    // Tanda "!" di depan = operator NOT (membalik true/false)
    // Jadi: "jika GAGAL membuka URL → lempar error"
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {

      // Jika URL tidak bisa dibuka, lempar Exception dengan pesan error
      // Ini membantu developer mengetahui ada masalah saat debugging
      throw Exception('Could not launch $url');
    }
  }

  // build() = method yang menggambarkan tampilan halaman ini
  @override
  Widget build(BuildContext context) {

    // Scaffold = kerangka dasar halaman di Flutter
    // Menyediakan struktur: AppBar (atas), body (tengah), dll.
    return Scaffold(

      // =====================================================
      // APP BAR (bagian atas halaman)
      // =====================================================
      appBar: AppBar(
        // backgroundColor: transparent = AppBar tidak punya warna latar
        // Terlihat menyatu dengan background halaman
        backgroundColor: Colors.transparent,

        // elevation: 0 = menghilangkan bayangan di bawah AppBar
        elevation: 0,

        // foregroundColor = warna untuk ikon-ikon di AppBar (seperti tombol back)
        foregroundColor: Colors.grey.shade900,

        // Judul AppBar
        title: Text(
          'Detail Film',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),

      // =====================================================
      // BODY (konten utama halaman)
      // =====================================================
      body: Padding(
        // Padding = memberi jarak antara tepi layar dengan konten
        // only() = hanya sisi tertentu yang diberi padding
        // Kiri: 20px, Kanan: 20px, Bawah: 10px (atas tidak diberi padding)
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),

        // Column = menyusun widget secara VERTIKAL (atas ke bawah)
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // konten rata kiri

          children: [

            // =====================================================
            // AREA SCROLLABLE: Poster + Info Detail Film
            // =====================================================

            // Expanded = mengisi sisa ruang vertikal yang tersedia
            // Penting agar ListView tidak konflik dengan tombol di bawah
            Expanded(
              child: Padding(
                // Memberi jarak 20px di bawah area scrollable
                // (agar tidak terlalu mepet dengan tombol Wikipedia)
                padding: const EdgeInsets.only(bottom: 20),

                // ListView = widget yang bisa di-scroll secara vertikal
                // Dipakai karena konten mungkin lebih panjang dari layar
                child: ListView(
                  children: [

                    // ---- POSTER FILM ----
                    // Center = menempatkan widget di tengah secara horizontal
                    Center(
                      // Image.network = menampilkan gambar dari URL internet
                      // widget.movie.imgUrl = URL gambar poster dari data film
                      // width: 300 = lebar gambar 300px (tinggi menyesuaikan otomatis)
                      child: Image.network(widget.movie.imgUrl, width: 300),
                    ),

                    // Jarak 20px antara poster dan teks judul
                    const SizedBox(height: 20),

                    // ---- JUDUL + TAHUN FILM ----
                    // Text.rich = teks dengan style berbeda dalam satu baris
                    Text.rich(
                      TextSpan(
                        children: [
                          // Potongan 1: Judul film (tebal, ukuran 20)
                          TextSpan(
                            text: widget.movie.title,
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Potongan 2: Tahun dalam kurung (tipis, ukuran 20)
                          // Contoh hasil: "Inception (2010)"
                          TextSpan(
                            text: " (${widget.movie.year})",
                            style: GoogleFonts.poppins(fontSize: 20),
                          ),
                        ],
                      ),
                    ),

                    // ---- NAMA SUTRADARA ----
                    // Ditampilkan di bawah judul dengan warna abu-abu
                    Text(
                      // String interpolation: menyisipkan variabel ke dalam String
                      // Contoh hasil: "Directed by Christopher Nolan"
                      'Directed by ${widget.movie.director}',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.grey.shade500, // abu-abu sedang
                      ),
                    ),

                    // Jarak 10px sebelum sinopsis
                    const SizedBox(height: 10),

                    // ---- SINOPSIS FILM ----
                    // Menampilkan ringkasan cerita film
                    Text(
                      widget.movie.synopsis,
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),

                    // Jarak 10px sebelum genre
                    const SizedBox(height: 10),

                    // ---- GENRE FILM ----
                    // Contoh hasil: "Genre: Action, Sci-Fi, Thriller"
                    Text(
                      'Genre: ${widget.movie.genre}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500, // ketebalan sedang (antara normal & bold)
                      ),
                    ),

                    // ---- DAFTAR PEMAIN (CASTS) ----
                    // movie.casts adalah List<String> berisi nama-nama pemain
                    // .join(', ') = menggabungkan semua item list menjadi satu String
                    // dipisahkan koma dan spasi
                    // Contoh: ["DiCaprio", "Hardy"] → "DiCaprio, Hardy"
                    Text(
                      'Casts: ${widget.movie.casts.join(', ')}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    // Jarak 10px sebelum rating
                    const SizedBox(height: 10),

                    // ---- RATING FILM ----
                    // SizedBox dengan width: double.infinity = lebar penuh layar
                    SizedBox(
                      width: double.infinity,

                      // Row untuk menyusun ikon bintang dan teks rating secara horizontal
                      child: Row(
                        // MainAxisAlignment.end = semua item rata ke KANAN
                        mainAxisAlignment: MainAxisAlignment.end,

                        children: [
                          // Ikon bintang kuning
                          const Icon(Icons.star, color: Colors.amber, size: 20),

                          // Jarak 4px antara bintang dan teks
                          const SizedBox(width: 4),

                          // Teks rating, contoh: "Rated 8.8 / 10"
                          Text(
                            'Rated ${widget.movie.rating} / 10',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600, // hampir bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // =====================================================
            // TOMBOL "GO TO WIKIPEDIA"
            // Tombol ini SELALU tampil di bagian bawah halaman
            // tidak ikut ter-scroll bersama konten di atas
            // =====================================================
            ElevatedButton(
              // Fungsi yang dipanggil saat tombol ditekan
              onPressed: navigateToWikipedia,

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,  // warna latar tombol: kuning
                foregroundColor: Colors.white,  // warna teks & ikon: putih

                // minimumSize: lebar penuh layar (infinity), tinggi 60px
                minimumSize: Size(double.infinity, 60),

                // RoundedRectangleBorder dengan BorderRadius.zero =
                // tombol berbentuk KOTAK SEMPURNA (tidak ada sudut melengkung)
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),

              // Label/teks yang ditampilkan di dalam tombol
              child: Text(
                'Go to Wikipedia',
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