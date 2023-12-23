import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_session.freezed.dart';
part 'movie_session.g.dart';

@freezed
class MovieSession with _$MovieSession {
  const factory MovieSession({
    required int id,
    @JsonKey(name: 'movie_id')
    required int movieId,
    @JsonKey(name: 'hall_id')
    required int hallId,
    @JsonKey(name: 'start_time')
    required DateTime startTime,
  }) = _MovieSession;

  factory MovieSession.fromJson(Map<String, Object?> json) =>
      _$MovieSessionFromJson(json);
}