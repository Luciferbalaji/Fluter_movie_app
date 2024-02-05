import 'package:flutter/material.dart';
import 'package:movei_app/model/model_rated_page.dart';
import 'package:movei_app/pages/detail_page.dart';

Widget toprated(BuildContext context) {
 return  FutureBuilder(
          future: fetchTopRatedMovies(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (snapshot.hasData) {
                return 
                    Container(
                      height: 250, // Set the desired height
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final movie = snapshot.data![index];
                          return GestureDetector(
                            onTap: () {
                              if (movie.id != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TopRatedDetails(movieId: movie.id),
                                  ),
                                );
                              } else {
                                // Handle the case where movie.id is null
                                print('Movie ID is null');
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                child: Image.network(
                                  movie.getFullPath(),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                
                  
                  
              }
            }
            return Center(child: CircularProgressIndicator());
          },
        );

}