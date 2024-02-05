import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movei_app/model/up_coming.dart';
import 'package:movei_app/pages/detail_page.dart';

Widget NowplayingMovies(BuildContext buildContext) {
  return FutureBuilder(future:fetchNowPlayingMovies() ,
  builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );

      }if(snapshot.hasError){
        return const Center(
          child: Text('eror'),
        );
      }
      if(snapshot.hasData){
        final moviesdata = snapshot.data as List<Nowplaying>;
        return CarouselSlider.builder(itemCount: moviesdata.length, itemBuilder: (context, index, realIndex) {
          final movie = moviesdata[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TopRatedDetails(movieId: movie.id)));
            },
            child: Container(
                     
              child: Image.network(
                'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
              ),
            ),
          );
          
        }, options: CarouselOptions(
          aspectRatio: 8/9 ,
         
          
          
          autoPlay: true
        ));

      }else{
        return const Center(
          child: Text('No Data'),
        );
      }

    

    
  },
  );

}