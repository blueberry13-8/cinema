import 'package:bloc/bloc.dart';
import 'package:cinema/features/app/domain/repositories/database.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/movie.dart';

part 'movie_cubit.freezed.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(const MovieState.initial());

  void selectMovie(int newIndex) {
    if (state case Success state) {
      emit(
        state.copyWith(
          selectedMovieIndex: newIndex,
        ),
      );
    }
  }

  Future<void> loadMovies() async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const MovieState.loading());
    try {
      final movies = await Database().getMovies();
      emit(
        MovieState.success(
          movies: movies,
          selectedMovieIndex: prevState?.selectedMovieIndex,
        ),
      );
    } catch (e) {
      emit(MovieState.error(e.toString()));
    }
  }

  Future<void> deleteMovie(Movie movie) async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const MovieState.loading());
    try {
      await Database().deleteMovie(movie);
      final movies = await Database().getMovies();
      final selectedMovieIndex =
          prevState != null && movie.id == prevState.selectedMovieIndex
              ? null
              : prevState?.selectedMovieIndex;
      emit(
        MovieState.success(
          movies: movies,
          selectedMovieIndex: selectedMovieIndex,
        ),
      );
    } catch (e) {
      emit(MovieState.error(e.toString()));
    }
  }

  Future<void> addMovie() async {
    if (state case Success state) {
      final id = state.movies.length;
      emit(
        state.copyWith(
          movies: [
            ...state.movies,
            Movie(
              id: id + 1,
              duration: -1,
              genre: '',
              name: '',
            ),
          ],
          selectedMovieIndex: id,
        ),
      );
    }
  }

  Future<void> updateMovie(
    Movie movie, [
    bool isAdd = false,
  ]) async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const MovieState.loading());
    try {
      if (isAdd) {
        await Database().addMovie(movie);
      } else {
        await Database().updateMovie(movie);
      }
      final movies = await Database().getMovies();
      emit(
        MovieState.success(
          movies: movies,
          selectedMovieIndex: prevState?.selectedMovieIndex,
        ),
      );
    } catch (e) {
      emit(MovieState.error(e.toString()));
    }
  }

  Future<void> updateMovie2(Map<String, String> fields, [bool isAdd = false]) async {
    final movie = Movie(
        id: int.parse(fields['id']!),
        duration: int.parse(fields['duration']!),
        genre: fields['genre']!,
        name: fields['name']!);
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const MovieState.loading());
    try {
      if (isAdd) {
        await Database().addMovie(movie);
      } else {
        await Database().updateMovie(movie);
      }
      final movies = await Database().getMovies();
      emit(
        MovieState.success(
          movies: movies,
          selectedMovieIndex: prevState?.selectedMovieIndex,
        ),
      );
    } catch (e) {
      emit(MovieState.error(e.toString()));
    }
  }
}
