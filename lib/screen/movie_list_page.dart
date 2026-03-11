// Import package Flutter untuk membuat UI (User Interface)
import 'package:flutter/material.dart';

// Import package Google Fonts untuk menggunakan font dari Google (contoh: Poppins)
import 'package:google_fonts/google_fonts.dart';

// Import komponen MovieTile yang kita buat sendiri untuk menampilkan satu item film
import '../components/movie_tile.dart';

// Import model MovieModel yang berisi struktur data film (judul, genre, dll)
import '../models/movie_model.dart';

// Import halaman detail film yang akan dibuka saat user klik salah satu film
import 'detail_page.dart';

// =============================================
// MovieListPage adalah halaman utama daftar film
// Menggunakan StatefulWidget karena ada data yang bisa berubah
// (yaitu daftar watchlist yang bisa ditambah/dihapus)
// =============================================
class MovieListPage extends StatefulWidget {
  // Variabel 'name' untuk menyimpan nama pengguna yang dikirim dari halaman sebelumnya
  final String name;

  // Constructor: cara membuat objek MovieListPage
  // 'super.key' untuk identifikasi unik widget (standar Flutter)
  // 'required this.name' artinya parameter 'name' WAJIB diisi saat memanggil halaman ini
  const MovieListPage({super.key, required this.name});

  // Setiap StatefulWidget wajib punya method createState()
  // Method ini menghubungkan widget dengan State-nya (_MovieListPageState)
  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

// =============================================
// _MovieListPageState adalah "otak" dari MovieListPage
// Semua logika dan tampilan yang bisa berubah ada di sini
// Tanda '_' di depan artinya class ini bersifat private (hanya bisa dipakai di file ini)
// =============================================
class _MovieListPageState extends State<MovieListPage> {

  // List kosong untuk menyimpan film-film yang sudah di-bookmark oleh user
  // Tipe datanya List<MovieModel> artinya isinya adalah objek-objek MovieModel
  List<MovieModel> myWatchlist = [];

  // =============================================
  // Fungsi untuk berpindah ke halaman DetailPage
  // Parameter 'index' adalah posisi film di dalam movieList (0, 1, 2, dst)
  // =============================================
  void navigateToMovieDetails(int index) {
    // Navigator.push() digunakan untuk membuka halaman baru
    // Context adalah informasi tentang posisi widget ini di dalam pohon widget Flutter
    Navigator.push(
      context,

      // MaterialPageRoute mendefinisikan halaman tujuan dan animasi perpindahannya
      MaterialPageRoute(
        // 'builder' adalah fungsi yang membangun halaman DetailPage
        // Kita kirimkan data film (movieList[index]) ke DetailPage
        builder: (context) => DetailPage(movie: movieList[index]),
      ),
    );
  }

  // =============================================
  // Method build() adalah tempat kita menggambar tampilan halaman
  // Dipanggil setiap kali ada perubahan state (misalnya saat bookmark ditambah/hapus)
  // =============================================
  @override
  Widget build(BuildContext context) {

    // Scaffold adalah kerangka dasar halaman di Flutter
    // Menyediakan struktur: AppBar (header), body (isi), dll
    return Scaffold(

      // AppBar adalah bagian header/navigasi di atas halaman
      appBar: AppBar(

        // Icon film di sisi kiri AppBar
        leading: Icon(Icons.movie),

        // Membuat background AppBar transparan (tidak berwarna)
        backgroundColor: Colors.transparent,

        // Judul di tengah AppBar
        title: Text(
          'Film Kita',
          style: GoogleFonts.poppins(
            fontSize: 18,              // Ukuran huruf 18
            fontWeight: FontWeight.bold, // Tebal
            color: Colors.black,       // Warna hitam
          ),
        ),
      ),

      // Body adalah isi utama halaman
      // SingleChildScrollView membuat konten bisa di-scroll jika melebihi layar
      body: SingleChildScrollView(
        child: Padding(
          // Padding adalah jarak antara konten dengan tepi layar
          // top: 20 (atas), left: 20 (kiri), right: 20 (kanan)
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),

          // Column menyusun widget-widget secara vertikal (dari atas ke bawah)
          child: Column(
            children: [

              // ---- BAGIAN SAPAAN (GREETING) ----
              // Menampilkan nama user yang dikirim dari halaman sebelumnya
              // '${widget.name}' cara mengakses variabel 'name' dari StatefulWidget-nya
              Text(
                'Halo, ${widget.name}!',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              // Teks subjudul di bawah sapaan
              Text(
                'Mau nonton apa hari ini..',
                style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
              ),

              // ---- BAGIAN GAMBAR ----
              // Menampilkan gambar dari folder assets
              // width: 400 untuk mengatur lebar gambar
              Image.asset('../../assets/movie_img.png', width: 400),

              // SizedBox adalah kotak kosong untuk memberi jarak antar widget
              SizedBox(height: 20),

              // ---- JUDUL SEKSI DAFTAR FILM ----
              // Align digunakan untuk mengatur posisi widget di dalam parent-nya
              // centerLeft = rata kiri tapi di tengah secara vertikal
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Daftar Film',
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade900, // Abu-abu gelap
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // ---- DAFTAR FILM (LIST VIEW) ----
              // ListView.builder efisien untuk menampilkan list panjang
              // Hanya membuat widget yang terlihat di layar, bukan semuanya sekaligus
              ListView.builder(
                // shrinkWrap: true agar ListView menyesuaikan tingginya dengan isi
                // (penting saat ListView ada di dalam Column/SingleChildScrollView)
                shrinkWrap: true,

                // Jumlah item = jumlah film di movieList
                itemCount: movieList.length,

                // itemBuilder dipanggil untuk setiap item, menghasilkan widget MovieTile
                // 'index' adalah nomor urut item saat ini (mulai dari 0)
                itemBuilder: (context, index) => MovieTile(
                  // Data film yang ditampilkan di tile ini
                  movie: movieList[index],

                  // Cek apakah film ini sudah ada di watchlist atau belum
                  // Hasilnya boolean: true = sudah disimpan, false = belum
                  isSaved: myWatchlist.contains(movieList[index]),

                  // onTap: fungsi yang dijalankan saat user mengetuk tile film
                  // Akan membuka halaman detail film
                  onTap: () {
                    navigateToMovieDetails(index);
                  },

                  // onBookmarkTap: fungsi saat user mengetuk ikon bookmark
                  onBookmarkTap: () {
                    // setState() memberitahu Flutter bahwa ada data yang berubah
                    // Flutter akan memanggil ulang build() untuk memperbarui tampilan
                    setState(() {
                      // Jika film sudah ada di watchlist → hapus (toggle off)
                      if (myWatchlist.contains(movieList[index])) {
                        myWatchlist.remove(movieList[index]);
                      } else {
                        // Jika film belum ada di watchlist → tambahkan (toggle on)
                        myWatchlist.add(movieList[index]);
                      }
                    });
                  },
                ),
              ),

              // Jarak kosong di bawah list
              const SizedBox(height: 30),

              // Teks penutup di bagian bawah halaman
              Text('udah itu doang', style: GoogleFonts.poppins(fontSize: 16)),

              // Jarak kosong paling bawah agar konten tidak terlalu mepet tepi
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}