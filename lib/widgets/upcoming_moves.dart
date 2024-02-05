import 'package:flutter/material.dart';
import 'package:movei_app/model/now_playing.dart';
import 'package:movei_app/pages/detail_page.dart';

Widget upcoming(BuildContext buildContext) {
  return FutureBuilder(
    future: fetchUpcomingMovies(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final comingMovies = snapshot.data as List<UpcomingMovie>;
          return Container(
           
            height: 250, // Set the desired height
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: comingMovies.length,
              itemBuilder: (context, index) {
                final movie = comingMovies[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TopRatedDetails(
                            movieId: movie.id,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      }

      return Container();
    },
  );
}
