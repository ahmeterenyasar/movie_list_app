import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'services/movie_api_service.dart';
import 'repositories/movie_repository.dart';
import 'repositories/favorites_repository.dart';
import 'cubits/movie_list_cubit.dart';
import 'cubits/favorites_cubit.dart';
import 'screens/movie_list_page.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final favoritesRepository = FavoritesRepository();
  await favoritesRepository.init();

  final movieApiService = MovieApiService();
  final movieRepository = MovieRepository(apiService: movieApiService);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MovieListCubit(movieRepository: movieRepository),
        ),
        BlocProvider(
          create: (_) =>
              FavoritesCubit(favoritesRepository: favoritesRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Movie List App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const MovieListPage(),
      ),
    ),
  );
}
