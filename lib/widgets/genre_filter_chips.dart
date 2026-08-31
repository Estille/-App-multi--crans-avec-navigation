import 'package:flutter/material.dart';

/// Widget réutilisable : rangée horizontale de filtres par genre.
class GenreFilterChips extends StatelessWidget {
  final List<String> genres;
  final String? selectedGenre;
  final ValueChanged<String?> onSelected;

  const GenreFilterChips({
    super.key,
    required this.genres,
    required this.selectedGenre,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: genres.length + 1,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          if (index == 0) {
            return ChoiceChip(
              label: const Text('Tous'),
              selected: selectedGenre == null,
              onSelected: (_) => onSelected(null),
            );
          }
          final genre = genres[index - 1];
          return ChoiceChip(
            label: Text(genre),
            selected: selectedGenre == genre,
            onSelected: (_) => onSelected(genre),
          );
        },
      ),
    );
  }
}
