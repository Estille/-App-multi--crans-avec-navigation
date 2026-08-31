import 'package:flutter/material.dart';

/// Widget réutilisable : affichage d'une note sous forme d'étoiles (0 à 5).
class RatingStars extends StatelessWidget {
  final double rating;
  final double size;

  const RatingStars({super.key, required this.rating, this.size = 18});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final threshold = index + 1;
        IconData icon;
        if (rating >= threshold) {
          icon = Icons.star;
        } else if (rating >= threshold - 0.5) {
          icon = Icons.star_half;
        } else {
          icon = Icons.star_border;
        }
        return Icon(icon, color: Colors.amber, size: size);
      }),
    );
  }
}
