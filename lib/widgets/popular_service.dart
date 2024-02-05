import 'package:flutter/material.dart';
import 'package:movei_app/model/popular_model.dart';
import 'package:movei_app/pages/detail_page.dart';

Widget fetchPopularMovies(BuildContext buildContext) {
  return FutureBuilder<List<popular>>(
    future: PopularMovies(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }
      if (snapshot.hasError) {
        print('${snapshot.error}');
        return Center(child: Text('${snapshot.error}'));
      }

      if (snapshot.hasData) {
        final List<popular> popularMovies = snapshot.data!;

        return Container(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: popularMovies.length,
            itemBuilder: (context, index) {
              final movie = popularMovies[index];
          
              return GestureDetector(
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500/${movie.poster_path}',
                  ),
                ),
              );
            },
          ),
        );
      }
      return Container();
    },
  );
}
