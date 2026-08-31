import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../data/movies_data.dart';

class MovieProvider extends ChangeNotifier {
  final List<Movie> _movies = List<Movie>.from(MoviesData.initialMovies);
  String _searchQuery = '';
  String? _selectedGenre;

  List<Movie> get movies => List.unmodifiable(_movies);
  String get searchQuery => _searchQuery;
  String? get selectedGenre => _selectedGenre;
  List<String> get genres => MoviesData.genres;

  List<Movie> get filteredMovies {
    return _movies.where((movie) {
      final matchesSearch =
          movie.title.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesGenre =
          _selectedGenre == null || movie.genre == _selectedGenre;
      return matchesSearch && matchesGenre;
    }).toList();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setGenreFilter(String? genre) {
    _selectedGenre = genre;
    notifyListeners();
  }

  Movie? getMovieById(int id) {
    try {
      return _movies.firstWhere((movie) => movie.id == id);
    } catch (_) {
      return null;
    }
  }

  void addMovie({
    required String title,
    required String genre,
    required int year,
    required double rating,
    required String description,
  }) {
    final newMovie = Movie(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      genre: genre,
      year: year,
      rating: rating,
      description: description,
    );
    _movies.insert(0, newMovie);
    notifyListeners();
  }
}
