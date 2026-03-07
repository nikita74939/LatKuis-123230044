import 'package:flutter/material.dart';
import 'movie_model.dart';

class WatchlistModel extends ChangeNotifier {
  final List<MovieModel> _savedMovies = [];
  List<MovieModel> get savedMovies => _savedMovies;

  // toggle tambah/hapus
  void toggleWatchlist(MovieModel movie) {
    if (_savedMovies.contains(movie)) {
      _savedMovies.remove(movie);
    } else {
      _savedMovies.add(movie);
    }
    
    notifyListeners();
  }

  // cek cek
  bool isSaved(MovieModel movie) {
    return _savedMovies.contains(movie);
  }
}