import 'package:http/http.dart' as http;
import 'dart:convert';
class similarmovies{
  final int id;
  final String title;
  final String poster_path;
  final String backdrop_path;
  final double rating;

  similarmovies( {
    required this.poster_path,
    required this.id, required this.title, required this.backdrop_path, required this.rating});
  
 factory similarmovies.fromJson(Map<String, dynamic> json) {
  return similarmovies(
    poster_path:json['poster_path'] ?? 'No Path',
  
    id: json['id'] ?? 0, // Replace 0 with your default value
    title: json['title'] ?? 'No Title', // Replace 'No Title' with your default value
    backdrop_path: json['poster_path'] ?? 'No Path', // Replace 'No Path' with your default value
    rating: json['vote_average']?.toDouble() ?? 0.0, // Replace 0.0 with your default value
  );
}

}

Future<List<similarmovies>> fetch_similarmovies(int id) async{
  final response =  await http.get(Uri.parse('https://api.themoviedb.org/3/movie/$id/similar?api_key=5afd0e1be4e363700a675ba3c63c08cc'));

  if(response.statusCode == 200){
   final List<dynamic> jsonlist = jsonDecode(response.body)['results'];
   return jsonlist.map((json) =>similarmovies.fromJson(json) ).toList();
    

  }else{
    throw Exception('Failed to load similar movies');
  }


}