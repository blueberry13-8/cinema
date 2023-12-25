part of 'movie_cubit.dart';

@freezed
class MovieState with _$MovieState {
  const factory MovieState.initial() = Initial;

  const factory MovieState.loading() = Loading;

  const factory MovieState.success({
    @Default([]) List<Movie> movies,
    int? selectedMovieIndex,
  }) = Success;

  const factory MovieState.error([String? message]) = Error;
}
