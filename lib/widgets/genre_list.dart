import 'package:flutter/material.dart';
import 'package:movei_app/model/genre_model.dart';
import 'package:movei_app/pages/genre_movielist.dart';

Widget fetchGenre(BuildContext buildContext) {
  return FutureBuilder(
    future: fetchGenres(),
    builder: (context, snapshot) {
      if (ConnectionState.active == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (snapshot.hasError) {
        return Text('something went wrong');
      } else if (snapshot.hasData) {
        return Padding(
          padding: const EdgeInsets.only(left:10.0,right: 10),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: (1 / .4),
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final data = snapshot.data?[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => genre_list(
                        movieid: data!.id,
                        genrename: data.genrename,
                      ),
                    ),
                  );
                },
                child: ListTile(
                  tileColor:Colors.grey.shade900,
                  title: Text(data!.genrename),
                  
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
