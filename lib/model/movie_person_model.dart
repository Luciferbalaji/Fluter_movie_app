import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movei_app/model/movie_crew.dart';

class persondetails{
  final  int id;
  List<Cast> cast;
  List<CrewMemberDetails> crewmwembers;

  persondetails({required this.id,
  required this.cast,
  required this.crewmwembers,
  });
  factory persondetails.fromJson(Map<String,dynamic>json){
    return persondetails(
      id: json['id'],
      cast: List<Cast>.from(json['cast'].map((cast) => Cast.fromJson(cast))),
      crewmwembers: List<CrewMemberDetails>.from(json['crew'].map((crew) => CrewMemberDetails.fromJson(crew)))
    );
  }
    
}
class Cast {
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String profilePath;
  final int castId;
  final String character;
  final String creditId;
  final int order;

  Cast({
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
  });

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      gender: json['gender'] as int? ?? 0,
      id: json['id'] as int? ?? 0,
      knownForDepartment: json['known_for_department'] as String? ?? '',
      name: json['name'] as String? ?? '',
      originalName: json['original_name'] as String? ?? '',
      popularity: json['popularity'] as double? ?? 0.0,
      profilePath: json['profile_path'] as String? ?? '',
      castId: json['cast_id'] as int? ?? 0,
      character: json['character'] as String? ?? '',
      creditId: json['credit_id'] as String? ?? '',
      order: json['order'] as int? ?? 0,
    );
  }
 
}

 Future<persondetails> fetch_castdetails(int id ) async{

  final Response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/$id/credits?api_key=5afd0e1be4e363700a675ba3c63c08cc'));
  if(Response.statusCode == 200){
    final json = Response.body;
    final jsonData = jsonDecode(json);
    return persondetails.fromJson(jsonData);
  }else{
    throw Exception('Failed to load cast details');
  }
 }
 