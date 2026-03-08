import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/movie_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  final MovieModel movie;
  const DetailPage({super.key, required this.movie});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // ke wikii
  Future<void> navigateToWikipedia() async {
    final Uri url = Uri.parse(widget.movie.movieUrl);

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey.shade900,
        title: Text(
          'Detail Film',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ListView(
                  children: [
                    // image
                    Center(
                      child: Image.network(widget.movie.imgUrl, width: 300),
                    ),

                    const SizedBox(height: 20),

                    // title (year)
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: widget.movie.title,
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: " (${widget.movie.year})",
                            style: GoogleFonts.poppins(fontSize: 20),
                          ),
                        ],
                      ),
                    ),

                    // const SizedBox(height: 20),

                    // directed by ..
                    Text(
                      'Directed by ${widget.movie.director}',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.grey.shade500,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // synopsis
                    Text(
                      widget.movie.synopsis,
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),

                    const SizedBox(height: 10),

                    // Genre:
                    Text(
                      'Genre: ${widget.movie.genre}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    // Casts:
                    Text(
                      'Casts: ${widget.movie.casts.join(', ')}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // rate
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            'Rated ${widget.movie.rating} / 10',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // go to wiki
            ElevatedButton(
              onPressed: navigateToWikipedia,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 60),

                shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.zero,
                ),
              ),
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
