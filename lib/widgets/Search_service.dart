import 'package:http/http.dart' as http;
import 'dart:convert';

class search{
  final int id;
  final String title;
  final String poster_path;
  final String backdrop_path;


  search({required this.title, required this.poster_path,
  required this.backdrop_path,
  required this.id
  });
  factory search.fromJson(Map<String, dynamic> json) {

    return search(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
     poster_path: json['poster_path'] as String? ?? '',
     backdrop_path: json['profile_path'] as String? ?? ''
     );
  }
  

}


 Future<List<search>> serachmethod(String query) async{

  final response = await http.get(Uri.parse('https://api.themoviedb.org/3/search/movie?api_key=5afd0e1be4e363700a675ba3c63c08cc&query=$query'));

  if (response.statusCode == 200) {
      final List<dynamic> jsonlsit = jsonDecode(response.body)['results'];    
      return jsonlsit.map((e) => search.fromJson(e)).toList();
  }else{
    return [];
  }



 }
