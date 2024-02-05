import 'package:flutter/material.dart';
import 'package:movei_app/model/model_similar.dart';
import 'package:movei_app/pages/detail_page.dart';
Widget moviePoster({required BuildContext context, required int id}) {
  return Container(
    height: 200,
    child: FutureBuilder(
      future: fetch_similarmovies(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final movies = snapshot.data!;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to details page
                    Navigator.push(context,
                     MaterialPageRoute(builder: (context) =>
                      TopRatedDetails(movieId:movie.id)));
                  },
                  child: Container(
                    width: 150,
                    margin: EdgeInsets.only(right: 16.0), // Adjust margin as needed
                    child: movie.backdrop_path != null
                        ? Image.network(
                            'https://image.tmdb.org/t/p/w500${movie.backdrop_path}',
                            
                          )
                        : Image.network(
                            'https://image.tmdb.org/t/p/w500${movie.poster_path}',
                            
                          )
                  ),
                );

              },
            );
          }
        }
        return CircularProgressIndicator();
      },
    ),
  );
}
