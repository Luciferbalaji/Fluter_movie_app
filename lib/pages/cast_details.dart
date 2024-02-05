// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movei_app/model/movie_person_model.dart';

class cast_details extends StatelessWidget {
  final  int id;
  const cast_details({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("Cast Details",
      style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20
          ),
      ),
      backgroundColor: Colors.black12,
      elevation: 0,

      centerTitle: true,
      ),
      backgroundColor: Colors.black12,
        body: FutureBuilder(
      future: fetch_castdetails(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Failed to load'),
          );
        }
        if (snapshot.hasData) {
          final casts = snapshot.data!.cast;
          return ListView.builder(
              itemCount: casts.length,
              itemBuilder: (context, index) {
                final cast = casts[index];
                return Row(
  children: [
    if (cast.profilePath != null && cast.profilePath.isNotEmpty)
      Image.network(
        'https://image.tmdb.org/t/p/w500/${cast.profilePath}',
        height: 150,
      )
    else
      Icon(Icons.person, size: 110, color: Colors.grey), // Adjust size and color as needed
    SizedBox(width: 16), // Add some spacing between image and text
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          cast.name,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16
          )
        ),
        Text(
          cast.character,
          style:GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 14
          )
        ),
        Text(
          cast.knownForDepartment,
          style:GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 12
          )
        ),
      ],
    ),
  ],
);

              });
        }
        return Container();
      },
    ));
  }
}