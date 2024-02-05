import 'package:http/http.dart' as http;
import 'dart:convert';

class UpcomingMovie {
  final int id;
  final String title;
  final String posterPath;

  UpcomingMovie({required this.id, required this.title, required this.posterPath});

  factory UpcomingMovie.fromJson(Map<String, dynamic> json) {
    return UpcomingMovie(id: json['id']  as int? ?? 0, 
    title:json['title'] as String? ?? '' , 
    posterPath:  json['poster_path'] as String? ?? ''
     );

  }

  
}

Future<List<UpcomingMovie>> fetchUpcomingMovies() async {

  final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/now_playing?api_key=5afd0e1be4e363700a675ba3c63c08cc'));

  if(response.statusCode ==200){
    final List<dynamic> jsonlist = jsonDecode(response.body)['results'];
    return jsonlist.map((json) => UpcomingMovie.fromJson(json)).toList();
  }else{
    throw Exception('Failed to load upcoming movies');
  }


}