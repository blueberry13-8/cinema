import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(const MovieState());

  void selectMovie(int selectedMovieIndex) {
    emit(
      MovieState(
        selectedMovieIndex: selectedMovieIndex,
      ),
    );
  }
}
