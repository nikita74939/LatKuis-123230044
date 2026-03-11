// Mengimpor package Flutter Material Design
// Material Design adalah sistem desain dari Google yang menyediakan widget-widget UI siap pakai
import 'package:flutter/material.dart';

// Mengimpor package Google Fonts untuk menggunakan font dari Google
// Ini memungkinkan kita memakai font seperti Poppins, Roboto, dll.
import 'package:google_fonts/google_fonts.dart';

// Mengimpor model MovieModel dari folder models
// Model adalah blueprint/cetakan data — di sini berisi info film seperti judul, genre, rating, dll.
import '../models/movie_model.dart';

// Mendefinisikan class MovieTile sebagai StatelessWidget
// StatelessWidget = widget yang TIDAK bisa berubah sendiri (tidak punya state/kondisi internal)
// Widget ini bertugas menampilkan satu item film dalam bentuk kartu/tile
class MovieTile extends StatelessWidget {
  // =====================================================
  // PROPERTI / PARAMETER WIDGET
  // Ini adalah data yang harus dikirim dari luar ke widget ini
  // =====================================================

  // Data film yang akan ditampilkan (judul, genre, rating, dll.)
  final MovieModel movie;

  // Fungsi yang dipanggil ketika tile film ditekan (navigasi ke halaman detail)
  // "void Function()?" artinya fungsi tanpa parameter, boleh null (tanda tanya)
  final void Function()? onTap;

  // Fungsi yang dipanggil ketika tombol bookmark ditekan
  final void Function()? onBookmarkTap;

  // Boolean (true/false) apakah film ini sudah disimpan/dibookmark atau belum
  final bool isSaved;

  // Constructor: cara membuat/menggunakan widget MovieTile
  // "super.key" digunakan Flutter untuk mengidentifikasi widget secara unik
  // "required" berarti parameter WAJIB diisi saat menggunakan widget ini
  const MovieTile({
    super.key,
    required this.movie,
    required this.onTap,
    required this.onBookmarkTap,
    required this.isSaved,
  });

  // Method build() adalah inti dari widget — di sinilah tampilan visual dibuat
  // "context" berisi informasi tentang posisi widget di dalam pohon widget Flutter
  @override
  Widget build(BuildContext context) {
    // Container = kotak pembungkus yang bisa dikustomisasi (warna, padding, margin, dll.)
    return Container(
      // BoxDecoration = mengatur penampilan visual Container
      decoration: BoxDecoration(
        // Warna latar belakang kartu: kuning muda semi-transparan
        // fromARGB(alpha, red, green, blue) — alpha 131 berarti sekitar 50% transparan
        color: const Color.fromARGB(131, 255, 229, 127),

        // Membuat sudut container menjadi melengkung (rounded corner) sebesar 20 pixel
        borderRadius: BorderRadius.circular(20),
      ),

      // Padding = jarak antara tepi container dengan konten di dalamnya (semua sisi 20px)
      padding: const EdgeInsets.all(20),

      // Margin = jarak antara container ini dengan widget lain di luar (atas-bawah 10px)
      margin: const EdgeInsets.symmetric(vertical: 10),

      // Row = menyusun widget-widget secara HORIZONTAL (kiri ke kanan)
      child: Row(
        // crossAxisAlignment mengatur perataan secara VERTIKAL dalam Row
        // CrossAxisAlignment.start = semua item rata ke atas
        crossAxisAlignment: CrossAxisAlignment.start,

        // children = daftar widget yang akan ditampilkan di dalam Row
        children: [
          // =====================================================
          // AREA 1: Poster & Info Film (bisa diklik untuk ke halaman detail)
          // =====================================================

          // Expanded = widget yang mengambil sisa ruang yang tersedia secara horizontal
          // Ini membuat area poster+info mengisi ruang sebanyak mungkin, menyisakan ruang untuk tombol bookmark
          Expanded(
            child: GestureDetector(
              // GestureDetector = mendeteksi sentuhan/gesture dari pengguna
              
              // HitTestBehavior.opaque = area kosong dalam GestureDetector pun bisa diklik
              // Tanpa ini, hanya widget yang terlihat saja yang bisa diklik
              behavior: HitTestBehavior.opaque,

              // onTap = fungsi yang dipanggil ketika area ini ditekan sekali
              onTap: onTap,

              // Row lagi untuk menyusun poster (gambar) dan info film secara horizontal
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  // ---- GAMBAR POSTER FILM ----
                  // ClipRRect = memotong widget di dalamnya mengikuti bentuk rounded rectangle
                  // Digunakan agar gambar punya sudut melengkung
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12), // sudut melengkung 12px

                    // Image.network = menampilkan gambar dari URL internet
                    child: Image.network(
                      movie.imgUrl, // URL gambar poster film

                      height: 120, // tinggi gambar 120px
                      width: 80,   // lebar gambar 80px

                      // BoxFit.cover = gambar akan mengisi seluruh kotak, dipotong jika perlu
                      // (tidak akan stretch/melar, tapi sebagian gambar mungkin terpotong)
                      fit: BoxFit.cover,
                    ),
                  ),

                  // SizedBox = kotak kosong sebagai jarak/spasi antar widget (seperti margin)
                  // Di sini memberi jarak 16px antara poster dan teks info
                  const SizedBox(width: 16),

                  // ---- INFO FILM (Judul, Genre, Rating) ----
                  // Expanded lagi agar kolom info mengambil sisa ruang horizontal
                  Expanded(
                    child: SizedBox(
                      height: 120, // tinggi sama dengan poster agar sejajar

                      // Column = menyusun widget secara VERTIKAL (atas ke bawah)
                      child: Column(
                        // MainAxisAlignment.spaceBetween = memberi jarak merata antara item
                        // Item pertama di atas, item terakhir di bawah, sisanya di tengah
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        crossAxisAlignment: CrossAxisAlignment.start, // rata kiri

                        children: [
                          // Column dalam untuk mengelompokkan judul dan genre
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              // ---- JUDUL + TAHUN FILM ----
                              // Text.rich = teks yang bisa memiliki style berbeda dalam satu baris
                              // TextSpan = potongan teks dengan style masing-masing
                              Text.rich(
                                TextSpan(
                                  children: [
                                    // Potongan pertama: Judul film (tebal/bold)
                                    TextSpan(
                                      text: movie.title,
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,             // ukuran huruf 16px
                                        fontWeight: FontWeight.bold, // tebal
                                        color: Colors.black,      // warna hitam
                                      ),
                                    ),

                                    // Potongan kedua: Tahun dalam tanda kurung — tampil lebih kecil & abu
                                    TextSpan(
                                      text: " (${movie.year})", // contoh: " (2023)"
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.grey.shade900, // abu sangat gelap
                                      ),
                                    ),
                                  ],
                                ),
                                maxLines: 2,                    // maksimal 2 baris
                                overflow: TextOverflow.ellipsis, // jika lebih dari 2 baris, tampilkan "..."
                              ),

                              // Jarak 6px antara judul dan genre
                              const SizedBox(height: 6),

                              // ---- GENRE FILM ----
                              Text(
                                movie.genre, // contoh: "Action, Drama"
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey.shade700, // warna abu-abu sedang
                                ),
                              ),
                            ],
                          ),

                          // ---- RATING FILM (bintang + angka) ----
                          Row(
                            children: [
                              // Icon bintang kuning dari Material Icons
                              const Icon(
                                Icons.star,
                                color: Colors.amber, // warna kuning keemasan
                                size: 16,            // ukuran ikon 16px
                              ),

                              // Jarak 4px antara ikon bintang dan teks rating
                              const SizedBox(width: 4),

                              // Teks rating, contoh: "8.5 / 10"
                              Text(
                                '${movie.rating} / 10',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: Colors.grey.shade900,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Jarak 10px antara area info dan tombol bookmark
          const SizedBox(width: 10),

          // =====================================================
          // AREA 2: TOMBOL BOOKMARK
          // Dipisah dari GestureDetector agar klik bookmark tidak
          // memicu navigasi ke halaman detail film
          // =====================================================
          IconButton(
            // Fungsi yang dipanggil saat tombol bookmark ditekan
            onPressed: onBookmarkTap,

            // constraints: BoxConstraints() = menghapus ukuran minimum default IconButton
            // Secara default IconButton punya ukuran minimum 48x48px,
            // ini menghapusnya agar tombol tidak memakan ruang berlebihan
            constraints: const BoxConstraints(),

            // EdgeInsets.zero = menghapus padding bawaan IconButton
            padding: EdgeInsets.zero,

            // Ikon yang ditampilkan bergantung pada status isSaved:
            // - isSaved == true  → ikon bookmark penuh (sudah disimpan)
            // - isSaved == false → ikon bookmark outline (belum disimpan)
            icon: Icon(
              isSaved ? Icons.bookmark : Icons.bookmark_outline,

              // Warna ikon juga berubah sesuai status:
              // - Sudah disimpan → kuning (amber)
              // - Belum disimpan → abu-abu
              color: isSaved ? Colors.amber : Colors.grey.shade600,

              size: 28, // ukuran ikon 28px
            ),
          ),
        ],
      ),
    );
  }
}