import 'package:http/http.dart' as http;
import 'dart:convert';

class Nowplaying{
  final int id;
  final String title;
  final String posterPath;

  Nowplaying({
    required this.id,
    required this.title,
    required this.posterPath
  });

  factory Nowplaying.fromJson(Map<String, dynamic> json) {
    return Nowplaying(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      posterPath: json['poster_path'] as String? ?? ''
    );
  }
}

Future<List<Nowplaying>> fetchNowPlayingMovies() async {
  final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/upcoming?api_key=5afd0e1be4e363700a675ba3c63c08cc'));

  if(response.statusCode == 200){
     final List<dynamic> jsomlist = jsonDecode(response.body)['results'];
     return jsomlist.map((json) => Nowplaying.fromJson(json)).toList();
  }else{
    throw Exception('Failed to load upcoming movies');
  }

}