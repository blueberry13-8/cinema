import 'package:cinema/features/app/domain/models/movie.dart';
import 'package:cinema/features/app/presentation/bloc/movie/movie_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/movie/movies_table.dart';
import '../../widgets/movie/my_editing_movie_widget.dart';

class UserMoviesPage extends StatelessWidget {
  const UserMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieCubit()..loadMovies(),
      child: _UserMoviesPage(
        key: key,
      ),
    );
  }
}

class _UserMoviesPage extends StatefulWidget {
  const _UserMoviesPage({super.key});

  @override
  State<_UserMoviesPage> createState() => _UserMoviesPageState();
}

class _UserMoviesPageState extends State<_UserMoviesPage> {

  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Movie> filtered(List<Movie> movies, String? query) {
    if (query == null) return movies;
    return movies
        .where(
          (element) => element.name.toLowerCase().contains(
        query.toLowerCase(),
      ),
    )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MovieCubit>().state;
    if (state case Success state) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 80.0,
                vertical: 10,
              ),
              child: TextFormField(
                controller: _searchController,
                onChanged: (newValue) => setState(() {}),
                decoration: const InputDecoration(
                  hintText: 'Поиск...',
                  icon: Icon(
                    Icons.search,
                  ),
                ),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 400,
              ),
              child: MoviesTable(
                movies: filtered(state.movies, _searchController.text),
                selectedMovieIndex: state.selectedMovieIndex,
              ),
            ),
            if (state.selectedMovieIndex != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 150.0,
                  vertical: 20,
                ),
                child: MyEditingMovieWidget(
                  movie: state.selectedMovieIndex! >= 0 &&
                          state.selectedMovieIndex! < state.movies.length
                      ? state.movies[state.selectedMovieIndex!]
                      : null,
                  fields: kMovieFields,
                  editable: false,
                ),
              ),
          ],
        ),
      );
    } else if (state case Loading || Initial) {
      return const CircularProgressIndicator();
    } else {
      return const Center(
        child: Text('Error'),
      );
    }
  }
}
