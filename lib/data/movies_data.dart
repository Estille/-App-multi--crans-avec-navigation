import '../models/movie.dart';

/// Source de données de l'application (aucune donnée en dur dans les widgets).
class MoviesData {
  static const List<String> genres = [
    'Action',
    'Drame',
    'Comédie',
    'Science-Fiction',
    'Animation',
    'Horreur',
  ];

  static final List<Movie> initialMovies = [
    Movie(id: 1, title: 'Horizon Perdu', genre: 'Action', year: 2021, rating: 4.5, description: "Un ancien agent secret est rappelé pour une dernière mission qui menace de tout changer."),
    Movie(id: 2, title: 'Les Silences', genre: 'Drame', year: 2019, rating: 4.0, description: "Une famille traverse une crise qui révèle des secrets enfouis depuis des années."),
    Movie(id: 3, title: 'Rire aux Éclats', genre: 'Comédie', year: 2022, rating: 3.8, description: "Deux amis d'enfance se retrouvent après 10 ans et rien ne se passe comme prévu."),
    Movie(id: 4, title: 'Nova Prime', genre: 'Science-Fiction', year: 2023, rating: 4.7, description: "L'humanité découvre une planète habitable, mais elle n'est pas inhabitée."),
    Movie(id: 5, title: 'Le Royaume Oublié', genre: 'Animation', year: 2020, rating: 4.2, description: "Une jeune princesse part à la recherche d'un royaume disparu depuis des siècles."),
    Movie(id: 6, title: 'La Maison Vide', genre: 'Horreur', year: 2018, rating: 3.5, description: "Une famille emménage dans une maison qui cache un lourd secret."),
    Movie(id: 7, title: 'Course Contre le Temps', genre: 'Action', year: 2024, rating: 4.1, description: "Un pilote doit livrer un colis vital avant l'aube, quoi qu'il en coûte."),
    Movie(id: 8, title: "Mémoires d'Automne", genre: 'Drame', year: 2017, rating: 4.3, description: "Un écrivain revisite son passé à travers les lettres de sa jeunesse."),
  ];
}
