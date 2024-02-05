import 'package:http/http.dart' as http;
import 'dart:convert';

class genremoviesmodel{
  final int id;
  final String genrename;
  final String posterpath;
  final num voteaverage;
  final String overview;

  genremoviesmodel({required this.id, required this.genrename,required this.posterpath,
  required this.voteaverage,
  required this.overview
  });

  factory genremoviesmodel.fromJson(Map<String, dynamic> json) {
    return genremoviesmodel(id: json['id'] as int? ?? 0   ,
     genrename: json['original_title'] as String? ?? '',
     posterpath: json['poster_path'] as String? ?? '',
     voteaverage: json['vote_average'] as num? ?? 0,
     overview: json['overview'] as String? ?? ''
     );

  }
}
Future<List<genremoviesmodel>> fetchGenrpage(int id) async {
  final response = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/discover/movie?api_key=5afd0e1be4e363700a675ba3c63c08cc&with_genres=$id'));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body)['results'];
    return data.map((json) => genremoviesmodel.fromJson(json)).toList();
        
  } else {
    throw Exception('Failed to load movies for genre $id');
  }
}
