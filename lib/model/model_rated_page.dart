import 'package:http/http.dart' as http;
import 'dart:convert';

class TopMovies {
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final String backdropPath;
  final List<int> genreIds;

  TopMovies({
    required this.id,
    required this.genreIds,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.backdropPath,
  });

  factory TopMovies.fromJson(Map<String, dynamic> json) {
    List<int> genreIds = [];

    if (json.containsKey('genre_ids') && json['genre_ids'] is List) {
      genreIds = List<int>.from(json['genre_ids']);
    }

    return TopMovies(
      id: json['id'] ?? 0,
      genreIds: genreIds,
      title: json['original_title'] as String,
      overview: json['overview'] as String,
      posterPath: json['poster_path'] as String,
      backdropPath: json['backdrop_path'] as String,
    );
  }

  String getFullPath() {
    String basePath = "https://image.tmdb.org/t/p/w500/";
    return basePath + this.posterPath;
  }

  String backfropPath() {
    String backdropPath = "https://image.tmdb.org/t/p/w500/";
    return backdropPath + this.backdropPath;
  }
}

Future<List<TopMovies>> fetchTopRatedMovies() async {
  final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/movie/top_rated?api_key=5afd0e1be4e363700a675ba3c63c08cc'));

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = jsonDecode(response.body)['results'];

    return jsonList.map((json) => TopMovies.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load top-rated movies');
  }
}

void genre_data() async {
  List<TopMovies> moviegenre = await fetchTopRatedMovies();

  final genreMap = {
    28: 'Action',
    12: 'Adventure',
    16: 'Animation',
    35: 'Comedy',
    80: 'Crime',
    99: 'Documentary',
    18: 'Drama',
    10751: 'Family',
    14: 'Fantasy',
    36: 'History',
    27: 'Horror',
    10402: 'Music',
    9648: 'Mystery',
    10749: 'Romance',
    878: 'Science Fiction',
    10770: 'TV Movie',
    53: 'Thriller',
    10752: 'War',
    37: 'Western',
  };

  for (var movie in moviegenre) {
    List<String> genres = movie.genreIds.map((id) => genreMap[id] ?? 'Unknown').toList();
    print('${movie.title} Genres: ${genres.join(', ')}');
  }
}

