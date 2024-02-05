import 'package:http/http.dart' as http;
import 'dart:convert';

class popular{
  final int id;
  final String title;
  final String poster_path;

  popular({
  required this.id,
  required this.title,
  required this.poster_path
});

factory popular.fromJson(Map<String,dynamic>json){
   return popular(
     id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      poster_path: json['poster_path'] as String? ?? ''
     );
}
}

Future<List<popular>> PopularMovies() async {
  final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=5afd0e1be4e363700a675ba3c63c08cc'));

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = jsonDecode(response.body)['results'];
    return jsonList.map((json) => popular.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load popular movies');
  }
}
