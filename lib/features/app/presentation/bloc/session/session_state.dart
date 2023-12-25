part of 'session_cubit.dart';

@freezed
class MovieSessionState with _$MovieSessionState {
  const factory MovieSessionState.initial() = Initial;

  const factory MovieSessionState.loading() = Loading;

  const factory MovieSessionState.success({
    @Default([]) List<MovieSession> sessions,
    int? selectedSessionIndex,
  }) = Success;

  const factory MovieSessionState.error([String? message]) = Error;
}
