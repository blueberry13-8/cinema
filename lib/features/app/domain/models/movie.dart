import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  const factory Movie({
    required int id,
    required int duration,
    required String genre,
    required String name,
}) = _Movie;

  factory Movie.fromJson(Map<String, Object?> json) =>
      _$MovieFromJson(json);
}