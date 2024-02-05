import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movei_app/state/movie_cart.dart';
import 'package:movei_app/state/notifier.dart';
import 'package:provider/provider.dart';

class Save_page extends StatefulWidget {
  const Save_page({Key? key}) : super(key: key);

  @override
  State<Save_page> createState() => _Save_pageState();
}

class _Save_pageState extends State<Save_page> {
  @override
  Widget build(BuildContext context) {
    List<Movieitem> savedMovies = Provider.of<saved>(context).savedMovies;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(

        elevation: 0,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Favs'),
      ),
      body: ListView.builder(
        itemCount: savedMovies.length,
        itemBuilder: (context, index) {
          return _buildMovieItem(savedMovies[index], index);
        },
      ),
    );
  }

  Widget _buildMovieItem(Movieitem data, int index) {
    return Card(
      child: Dismissible(
        key: Key(data.movieid.toString()), // Assuming id is a property in Movieitem
        onDismissed: (direction) {
          // Remove the movie from the list
          Provider.of<saved>(context, listen: false).removeSavedMovie(
            data.movieid,

          );
        },
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 16.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 100,
                
                child: Image.network(
                  "https://image.tmdb.org/t/p/w500/${data.posterpath}",
                ),
              ),
              SizedBox(width: 16), // Add some space between image and text
              Expanded(
                child: Text(
                  data.title,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
