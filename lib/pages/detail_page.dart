import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movei_app/model/detail_movies.dart';
import 'package:movei_app/model/movie_person_model.dart';
import 'package:movei_app/pages/cast_details.dart';
import 'package:movei_app/pages/crew_details.dart';
import 'package:movei_app/state/movie_cart.dart';
import 'package:movei_app/state/notifier.dart';
import 'package:movei_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class TopRatedDetails extends StatefulWidget {
  final int movieId;

  TopRatedDetails({Key? key, required this.movieId}) : super(key: key);

  @override
  State<TopRatedDetails> createState() => _TopRatedDetailsState();
}

class _TopRatedDetailsState extends State<TopRatedDetails> {
  double _getTextSize(double screenWidth) {
    // Adjust these values based on your design preferences
    if (screenWidth < 600) {
      return 16.0; // Small screen size
    } else if (screenWidth < 1200) {
      return 17.0; // Medium screen size
    } else {
      return 18.0; // Large screen size
    }
  }
  

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
      saved savedInstance = Provider.of<saved>(context);
      // ignore: no_leading_underscores_for_local_identifiers
      void _showSnackbar(String message) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

    return Scaffold(
      backgroundColor: Colors.black12,
      body: FutureBuilder<List<dynamic>>(
        future: Future.wait([fetch_moviesdetails(widget.movieId), fetch_castdetails(widget.movieId)]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final Detailsmovies? movieDetails = snapshot.data![0] as Detailsmovies?;
            final castname = snapshot.data![1] as persondetails?;

            if (movieDetails != null) {
               bool isFavorite = savedInstance.isMovieSaved(movieDetails.id);
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 250,
                      child: Image.network(
                        movieDetails.backfropPath(),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          
                            children: [
                              
                              Expanded(
                                child: Text(
                                  movieDetails.title,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8,),
                          IconButton(
  onPressed: () {
    bool isFavorite = savedInstance.isMovieSaved(movieDetails.id);
    if (isFavorite) {
      // If the movie is already a favorite, remove it
      Provider.of<saved>(context, listen: false).removeSavedMovie(movieDetails.id);
      _showSnackbar('Movie removed from favorites');
    } else {
      // If the movie is not a favorite, add it
      Movieitem movieitem = Movieitem(
        movieid: movieDetails.id,
        title: movieDetails.title,
        posterpath: movieDetails.backdropPath,
      );
      Provider.of<saved>(context, listen: false).addSavedMovie(movieitem);
      _showSnackbar('Movie added to favorites');
    }
  },
  color: savedInstance.isMovieSaved(movieDetails.id) ? Colors.red : Colors.grey,
  icon: const Icon(
    Icons.favorite,
    size: 25,
   // color: Colors.white,
  ),
)


                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber[400]),
                              const SizedBox(width: 4,),
                              Text(
                                '${movieDetails.rating.roundToDouble()}',
                                style: GoogleFonts.poppins(color: Colors.white, fontSize: _getTextSize(screenWidth)),
                              ),
                            ],
                          ),
                          Text(
                            'Released on ${movieDetails.releasedate}',
                            style: GoogleFonts.poppins(color: Colors.grey, fontSize: _getTextSize(screenWidth)),
                          ),
                          Text(
                            'Language: ${movieDetails.language}',
                            style: GoogleFonts.poppins(color: Colors.grey, fontSize: _getTextSize(screenWidth)),
                          ),
                          Text(
                            'Genres: ${movieDetails.genre.map((genre) => genre.name).join(', ') ?? ''}',
                            style: GoogleFonts.poppins(color: Colors.white, fontSize: _getTextSize(screenWidth)),
                          ),
                          Text(
                            'Production Companies: ${movieDetails.productiondetails.map((company) => company.countryname).join(', ') ?? ''}',
                            style: GoogleFonts.poppins(color: Colors.white, fontSize: _getTextSize(screenWidth)),
                          ),
                          Text(
                            'Production Companies Names: ${movieDetails.productiondetails.map((company) => company.productioncompanyname).join(', ') ?? ''}',
                            style: GoogleFonts.poppins(color: Colors.white, fontSize: _getTextSize(screenWidth)),
                          ),
                          const SizedBox(height: 16),
                          Text('Overview',
                          style: GoogleFonts.poppins(fontSize: _getTextSize(screenWidth), 
                            color: Colors.white),
                          
                          
                          
                          ),  

                          Text(
                            movieDetails.overview,
                            style: GoogleFonts.poppins(fontSize: _getTextSize(screenWidth), 
                            color: Colors.white),
                          ),

                          // Cast name
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => cast_details(id: castname!.id),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: RichText(
                                text: TextSpan(
                                  text: 'Stars: ' + (castname?.cast.take(7)?.map((person) => person.name).join(', ') ?? ''),
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: _getTextSize(screenWidth),
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '......more',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: _getTextSize(screenWidth),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Crew details
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => crew_details(id: castname!.crewmwembers![0].id),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: RichText(
                                text: TextSpan(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  text: 'Crew: ' + (castname?.crewmwembers.take(2)?.map((person) => person.name).join(', ') ?? ''),
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: _getTextSize(screenWidth),
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '......more',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: _getTextSize(screenWidth),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Similar Movies
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                'Similar Movies',
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              moviePoster(context: context, id: widget.movieId),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('Movie details are null'),
              );
            }
          } else {
            return const Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}
