import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/detail_screen.dart';
import '../screens/add_movie_screen.dart';
import '../screens/settings_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/detail/:id',
      name: 'detail',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return DetailScreen(movieId: id);
      },
    ),
    GoRoute(
      path: '/add',
      name: 'add',
      builder: (context, state) => const AddMovieScreen(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
