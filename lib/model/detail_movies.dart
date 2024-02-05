import 'package:http/http.dart' as http;
import 'dart:convert';

class Detailsmovies {
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final String backdropPath;
  final String language;
  final num budget;
  final num rating;
  final String releasedate;
  final int runtime;
  final String status;
  final List<Genre> genre;
  final List<ProductionCompany> productiondetails;

  Detailsmovies({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.backdropPath,
    required this.language,
    required this.budget,
    required this.rating,
    required this.releasedate,
    required this.runtime,
    required this.status,
    required this.genre,
    required this.productiondetails,
  });

  factory Detailsmovies.fromJson(Map<String, dynamic> json) {
    return Detailsmovies(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      posterPath: json['poster_path'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      backdropPath: json['backdrop_path'] as String? ?? '',
      language: json['original_language'] as String? ?? '',
      budget: json['budget'] as num? ?? 0,
      rating: json['vote_average'] as num? ?? 0,
      releasedate: json['release_date']?.toString() ?? '',
      runtime: json['runtime'] as int? ?? 0,
      status: json['status'] as String? ?? '',
      genre: List<Genre>.from(json['genres']?.map((genre) => Genre.fromJson(genre)) ?? []),
      productiondetails: List<ProductionCompany>.from(
        json['production_companies']?.map((company) => ProductionCompany.fromJson(company)) ?? [],
      ),
    );
  }
   String getFullPosterImage() {
    String basePath = "https://image.tmdb.org/t/p/w500/";
    return basePath + this.posterPath;
  }

  String backfropPath() {
    String backdropPath = "https://image.tmdb.org/t/p/w500/";
    return backdropPath + this.backdropPath;
  }
}

class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
    );
  }
}

class ProductionCompany {
  final int id;
  final String productioncompanyname;
  final String productioncompanylogo;
  final String countryname;

  ProductionCompany({
    required this.id,
    required this.productioncompanyname,
    required this.productioncompanylogo,
    required this.countryname,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(
      id: json['id'] as int? ?? 0,
      productioncompanylogo: json['logo_path'] as String? ?? '',
      productioncompanyname: json['name'] as String? ?? '',
      countryname: json['origin_country'] as String? ?? '',
    );
  }
}




Future<Detailsmovies> fetch_moviesdetails(int id) async {
  final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/$id?api_key=5afd0e1be4e363700a675ba3c63c08cc'));

  if (response.statusCode == 200) {
    final dynamic jsonData = jsonDecode(response.body);
    return Detailsmovies.fromJson(jsonData);
  } else {
    throw Exception('Failed to load movie details');
  }
}