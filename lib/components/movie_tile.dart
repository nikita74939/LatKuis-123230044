import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latkuis/models/movie_model.dart';

class MovieTile extends StatelessWidget {
  final MovieModel movie;
  final void Function()? onTap;
  final void Function()? onBookmarkTap;
  final bool isSaved;

  const MovieTile({
    super.key,
    required this.movie,
    required this.onTap,
    required this.onBookmarkTap,
    required this.isSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(131, 255, 229, 127),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AREA 1: Poster & Info (Klik untuk ke Detail)
          Expanded(
            child: GestureDetector(
              behavior:
                  HitTestBehavior.opaque, 
              onTap: onTap,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // poster
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      movie.imgUrl,
                      height: 120,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(width: 16),

                  // info movie
                  Expanded(
                    child: SizedBox(
                      height: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // title + year
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: movie.title,
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " (${movie.year})",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.grey.shade900,
                                      ),
                                    ),
                                  ],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              const SizedBox(height: 6),

                              // genre
                              Text(
                                movie.genre,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),

                          // rating
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
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

          const SizedBox(width: 10),

          // AREA 2: Tombol Bookmark (Terpisah dari area detail)
          IconButton(
            onPressed: onBookmarkTap,
            constraints: const BoxConstraints(), 
            padding: EdgeInsets.zero,
            icon: Icon(
              isSaved ? Icons.bookmark : Icons.bookmark_outline,
              color: isSaved ? Colors.amber : Colors.grey.shade600,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
