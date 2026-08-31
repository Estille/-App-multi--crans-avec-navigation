import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';

/// Écran 3 : formulaire d'ajout d'un film, avec validation (4 champs).
class AddMovieScreen extends StatefulWidget {
  const AddMovieScreen({super.key});

  @override
  State<AddMovieScreen> createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _yearController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedGenre;
  double _rating = 3.0;

  @override
  void dispose() {
    _titleController.dispose();
    _yearController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<MovieProvider>().addMovie(
            title: _titleController.text.trim(),
            genre: _selectedGenre!,
            year: int.parse(_yearController.text.trim()),
            rating: _rating,
            description: _descriptionController.text.trim(),
          );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Film ajouté avec succès !')),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final genres = context.read<MovieProvider>().genres;

    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter un film')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Titre', border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.trim().length < 2) {
                  return 'Le titre doit contenir au moins 2 caractères.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _yearController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Année', border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "L'année est requise.";
                }
                final year = int.tryParse(value.trim());
                if (year == null || year < 1900 || year > 2100) {
                  return 'Entre une année valide (1900-2100).';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedGenre,
              decoration: const InputDecoration(labelText: 'Genre', border: OutlineInputBorder()),
              items: genres
                  .map((genre) => DropdownMenuItem(value: genre, child: Text(genre)))
                  .toList(),
              onChanged: (value) => setState(() => _selectedGenre = value),
              validator: (value) => value == null ? 'Choisis un genre.' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Synopsis',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null || value.trim().length < 10) {
                  return 'Le synopsis doit contenir au moins 10 caractères.';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Text('Note : ${_rating.toStringAsFixed(1)} / 5', style: Theme.of(context).textTheme.bodyMedium),
            Slider(
              value: _rating,
              min: 0,
              max: 5,
              divisions: 10,
              label: _rating.toStringAsFixed(1),
              onChanged: (value) => setState(() => _rating = value),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: _submit,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Enregistrer le film'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
