// Mengimpor package Flutter Material Design
// "foundation.dart" sebenarnya sudah cukup untuk ChangeNotifier,
// tapi material.dart mencakup semuanya termasuk foundation
import 'package:flutter/material.dart';

// Mengimpor MovieModel dari file movie_model.dart di folder yang sama
// MovieModel adalah blueprint/cetakan data film (judul, genre, rating, dll.)
// Tanda tanpa ".." berarti file berada di folder yang SAMA dengan file ini
import 'movie_model.dart';

// =====================================================
// WatchlistModel adalah "otak" dari fitur watchlist
//
// Ia mewarisi (extends) ChangeNotifier:
// ChangeNotifier = kelas dari Flutter yang punya kemampuan
// untuk MEMBERITAHU widget lain ketika data berubah
//
// Analogi: seperti speaker pengumuman — ketika data berubah,
// ia "berteriak" ke semua widget yang mendengarkan,
// lalu widget tersebut otomatis rebuild/refresh tampilannya
// =====================================================
class WatchlistModel extends ChangeNotifier {

  // =====================================================
  // DATA / STATE
  // =====================================================

  // List private berisi film-film yang sudah disimpan ke watchlist
  // Tanda underscore "_" di depan nama = PRIVATE
  // artinya variabel ini HANYA bisa diakses dari dalam class ini
  // tidak bisa langsung diubah dari luar class
  final List<MovieModel> _savedMovies = [];

  // GETTER: cara aman untuk mengakses _savedMovies dari luar class
  // Widget lain bisa MEMBACA daftar film, tapi tidak bisa langsung MENGUBAHNYA
  // Ini adalah prinsip enkapsulasi — data dilindungi, hanya bisa diubah lewat method resmi
  //
  // Analogi: seperti etalase toko — pelanggan bisa LIHAT barang,
  // tapi tidak bisa langsung ambil sendiri tanpa melalui kasir
  List<MovieModel> get savedMovies => _savedMovies;

  // =====================================================
  // METHOD / FUNGSI
  // =====================================================

  // toggleWatchlist = fungsi untuk menambah ATAU menghapus film dari watchlist
  // "toggle" artinya bolak-balik: jika sudah ada → hapus, jika belum ada → tambah
  //
  // Parameter: movie = film yang ingin ditambah/dihapus
  void toggleWatchlist(MovieModel movie) {

    // Mengecek apakah film ini sudah ada di dalam list _savedMovies
    // .contains() = method bawaan List untuk mengecek keberadaan suatu item
    // Mengembalikan true jika ada, false jika tidak ada
    if (_savedMovies.contains(movie)) {

      // Jika film SUDAH ADA di watchlist → HAPUS dari list
      // .remove() = menghapus item pertama yang cocok dari List
      _savedMovies.remove(movie);

    } else {

      // Jika film BELUM ADA di watchlist → TAMBAHKAN ke list
      // .add() = menambahkan item baru ke akhir List
      _savedMovies.add(movie);
    }

    // SANGAT PENTING: memberitahu semua widget yang "mendengarkan" model ini
    // bahwa data sudah berubah → mereka akan otomatis rebuild/refresh tampilan
    //
    // Tanpa notifyListeners(), tampilan TIDAK AKAN berubah meskipun data sudah berubah!
    // Analoginya: setelah update data, kita "pencet bel" supaya semua widget tahu
    notifyListeners();
  }

  // isSaved = fungsi untuk mengecek apakah sebuah film sudah ada di watchlist
  // Mengembalikan true (sudah disimpan) atau false (belum disimpan)
  //
  // Fungsi ini biasanya dipakai untuk:
  // - Menentukan warna ikon bookmark (kuning = sudah, abu = belum)
  // - Menentukan ikon bookmark (penuh = sudah, outline = belum)
  bool isSaved(MovieModel movie) {

    // .contains() mengecek apakah movie ada di dalam _savedMovies
    // Hasilnya langsung di-return (true/false)
    return _savedMovies.contains(movie);
  }
}