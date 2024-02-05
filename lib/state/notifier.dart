import 'package:flutter/material.dart';
import 'package:movei_app/state/movie_cart.dart';

class saved extends ChangeNotifier {
  List<Movieitem> _savedMovies = [];

  List<Movieitem> get savedMovies => [..._savedMovies];

  void addSavedMovie(Movieitem movie) {
    _savedMovies.add(movie);
    notifyListeners();
  }

  bool isMovieSaved(int movieId) {
    return _savedMovies.any((movie) => movie.movieid == movieId);
  }

  void removeSavedMovie(int movieId) {
    _savedMovies.removeWhere((movie) => movie.movieid == movieId);
    notifyListeners();
  }
}
