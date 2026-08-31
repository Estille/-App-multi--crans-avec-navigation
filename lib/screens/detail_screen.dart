import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../widgets/rating_stars.dart';

/// Écran 2 : détail d'un film (paramètre movieId reçu via GoRouter).
class DetailScreen extends StatelessWidget {
  final int movieId;

  const DetailScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final movie = context.watch<MovieProvider>().getMovieById(movieId);

    if (movie == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Film introuvable')),
        body: const Center(child: Text("Ce film n'existe pas ou plus.")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.primaryContainer,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Center(
                    child: Icon(Icons.local_movies, color: Colors.white, size: 72),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 16,
                  child: Chip(label: Text(movie.genre)),
                ),
                Positioned(
                  top: 12,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: RatingStars(rating: movie.rating, size: 16),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text('Année : ${movie.year}', style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),
                  Text('Synopsis', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(movie.description, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
