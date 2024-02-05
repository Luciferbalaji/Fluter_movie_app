import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movei_app/widgets/now_play_service.dart';
import 'package:movei_app/widgets/popular_service.dart';
import 'package:movei_app/widgets/top_rates.dart';

import '../widgets/upcoming_moves.dart';



class TopMoviesPage extends StatefulWidget {
  const TopMoviesPage({Key? key}) : super(key: key);

  @override
  _TopMoviesPageState createState() => _TopMoviesPageState();
}

class _TopMoviesPageState extends State<TopMoviesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers:  [
       SliverAppBar(
        centerTitle: true,


          title: Text('FlickFlow',
          style:GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
          ),
          expandedHeight: 50,
  elevation: 0,
  backgroundColor: Colors.black, // Change to a darker color if needed
  
  floating: true,
  pinned: false,
),
      SliverList(delegate: SliverChildListDelegate(
        [
          


           Padding(
            padding: const EdgeInsets.only(left:15.0),
            child: Text('Up coming movies',
            style: GoogleFonts.poppins(
              color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600
            
            ),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: NowplayingMovies(context),
          ),
           Padding(
            padding: const EdgeInsets.only(left:15.0),
            child: Text('Now playing',
            style: GoogleFonts.poppins(
              color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600
            
            ),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: upcoming(context),
          ),
           Padding(
            padding: const EdgeInsets.only(left:15.0),
            child: Text('Top Rated ',
            style: GoogleFonts.poppins(
              color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600
            
            ),),
          ),Padding(
             padding: const EdgeInsets.all(8.0),
             child: toprated(context),
           ),
          
           Padding(
            padding: const EdgeInsets.only(left:15.0),
            child: Text('popular',
            style: GoogleFonts.poppins(
              color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600
            
            ),),

          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: fetchPopularMovies(context),
          )
           


        
        ]
      ))

        ],
      )
      
      
    );
  }
}
