import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/movie_tile.dart';
import '../models/movie_model.dart';
import 'detail_page.dart';

class MovieListPage extends StatefulWidget {
  final String name;
  const MovieListPage({super.key, required this.name});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  List<MovieModel> myWatchlist = [];

  // lets gooo ke detail page
  void navigateToMovieDetails(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(movie: movieList[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.movie),
        backgroundColor: Colors.transparent,
        title: Text(
          'Film Kita',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
              // greeting
              Text(
                'Halo, ${widget.name}!',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              Text(
                'Mau nonton apa hari ini..',
                style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
              ),

              // image
              Image.asset('../../assets/movie_img.png', width: 400),

              SizedBox(height: 20),

              // text daftar movie
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Daftar Film',
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade900,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // list movie
              ListView.builder(
                shrinkWrap: true,
                itemCount: movieList.length,
                itemBuilder:
                    (context, index) => MovieTile(
                      movie: movieList[index],
                      isSaved: myWatchlist.contains(movieList[index]),
                      onTap: () {
                        navigateToMovieDetails(index);
                      },
                      onBookmarkTap: () {
                        setState(() {
                          if (myWatchlist.contains(movieList[index])) {
                            myWatchlist.remove(movieList[index]);
                          } else {
                            myWatchlist.add(movieList[index]);
                          }
                        });
                      },
                    ),
              ),

              const SizedBox(height: 30),

              Text('udah itu doang', style: GoogleFonts.poppins(fontSize: 16)),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
