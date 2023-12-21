import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.freezed.dart';
part 'session.g.dart';

@freezed
class Session with _$Session {
  const factory Session({
    required int id,
    @JsonKey(name: 'movie_id')
    required int movieId,
    @JsonKey(name: 'hall_id')
    required int hallId,
    @JsonKey(name: 'start_time')
    required DateTime startTime,
  }) = _Session;

  factory Session.fromJson(Map<String, Object?> json) =>
      _$SessionFromJson(json);
}