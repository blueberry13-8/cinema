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

class _UserMoviesPage extends StatelessWidget {
  const _UserMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MovieCubit>().state;
    if (state case Success state) {
      return Stack(
        children: [
          MoviesTable(
            movies: state.movies,
            selectedMovieIndex: state.selectedMovieIndex,
          ),
          if (state.selectedMovieIndex != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
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
            ),
        ],
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
