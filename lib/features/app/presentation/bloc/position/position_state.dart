part of 'position_cubit.dart';

@freezed
class PositionState with _$PositionState {
  const factory PositionState.initial() = Initial;

  const factory PositionState.loading() = Loading;

  const factory PositionState.success({
    @Default([]) List<Position> positions,
    int? selectedPositionIndex,
  }) = Success;

  const factory PositionState.error([String? message]) = Error;
}
