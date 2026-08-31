import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../widgets/movie_card.dart';
import '../widgets/genre_filter_chips.dart';
import '../widgets/empty_state.dart';

/// Écran 1 : liste des films avec recherche et filtrage par genre.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = context.watch<MovieProvider>();
    final filteredMovies = movieProvider.filteredMovies;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Films & Séries'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: movieProvider.setSearchQuery,
              decoration: InputDecoration(
                hintText: 'Rechercher un film...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
              ),
            ),
          ),
          GenreFilterChips(
            genres: movieProvider.genres,
            selectedGenre: movieProvider.selectedGenre,
            onSelected: movieProvider.setGenreFilter,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: filteredMovies.isEmpty
                ? const EmptyState(message: 'Aucun film ne correspond à ta recherche.')
                : LayoutBuilder(
                    builder: (context, constraints) {
                      final isTablet = constraints.maxWidth >= 600;
                      if (isTablet) {
                        return GridView.builder(
                          padding: const EdgeInsets.all(16),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: filteredMovies.length,
                          itemBuilder: (context, index) {
                            final movie = filteredMovies[index];
                            return MovieCard(
                              movie: movie,
                              onTap: () => context.push('/detail/${movie.id}'),
                            );
                          },
                        );
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        itemCount: filteredMovies.length,
                        itemBuilder: (context, index) {
                          final movie = filteredMovies[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: MovieCard(
                              movie: movie,
                              onTap: () => context.push('/detail/${movie.id}'),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
