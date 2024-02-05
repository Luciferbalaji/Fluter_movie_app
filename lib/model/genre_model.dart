import 'package:http/http.dart' as http;
import 'dart:convert';


class genre{
  final int id;
  final String genrename;

  genre({required this.id, required this.genrename});

 factory genre.fromJson(Map<String, dynamic> json) {
  return genre(id: json['id'] as int? ?? 0   ,
   genrename: json['name'] as String? ?? ''
   );
 }
}

Future<List<genre>> fetchGenres() async {
  final repose = await http.get(Uri.parse('https://api.themoviedb.org/3/genre/movie/list?your_api_key'));

  if(repose.statusCode == 200){

    final List<dynamic> jsonList = jsonDecode(repose.body)['genres'];
     return jsonList.map((json) => genre.fromJson(json)).toList();
  }
  else{
    throw Exception('Failed to load genres');
  }
}
