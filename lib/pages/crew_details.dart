// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movei_app/model/movie_person_model.dart';

class crew_details extends StatelessWidget {
  final int id;
  const crew_details({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("Crew Details",
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
      body: FutureBuilder(future: fetch_castdetails(id), builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.hasData) {
          final crew = snapshot.data!.crewmwembers;
          return ListView.builder(
            itemCount:  crew.length,
            itemBuilder: (context, index) {
              final member = crew[index];
              return Row(
                children: [
                   if (member.profilePath != null && member.profilePath.isNotEmpty)
      Image.network(
        'https://image.tmdb.org/t/p/w500/${member.profilePath}',
        height: 150,
      )
    else
      Icon(Icons.person, size: 110, color: Colors.grey), // Adjust size and color as needed
    SizedBox(width: 16),
SizedBox(width: 10,),
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      member.name,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white
      ),
    ),
    SizedBox(height: 5,),
    Text(
      member.job,
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey
      ),
    ),
  ],
)
                ],
              );
            },
          );
        }
        return Container();
      })
    );
  }
}