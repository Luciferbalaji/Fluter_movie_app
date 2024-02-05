import 'package:flutter/material.dart';
import 'package:movei_app/model/genre_movie_model.dart';
import 'package:movei_app/pages/detail_page.dart';

class genre_list extends StatefulWidget {
  final int movieid;
  final String genrename;

  const genre_list({super.key, required this.movieid, required this.genrename});

  @override
  State<genre_list> createState() => _genre_listState();
}

class _genre_listState extends State<genre_list> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.genrename),
      ),
      body: FutureBuilder(future: fetchGenrpage(widget.movieid), builder:(context, snapshot) {

        if(ConnectionState.active == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }if (snapshot.hasError){
          return Center(
            child: Text('Something went wrong....!'),
          );
        }else if(snapshot.hasData){
          return  GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 2.4 / 4,
                crossAxisSpacing: 5,
                mainAxisSpacing: 8, // Adjust mainAxisSpacing as needed
                crossAxisCount: 3,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final data = snapshot.data![index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TopRatedDetails(
                          movieId: data.id,
                        )
                      ),
                    );
                  },
                  child: Container(
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500/${data.posterpath}' ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
        }
        return Container();
        
      },)

    );
  }
}