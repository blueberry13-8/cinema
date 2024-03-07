part of 'new_employee_cubit.dart';

@freezed
class NewEmployeeState with _$NewEmployeeState {
  const factory NewEmployeeState.initial() = Initial;

  const factory NewEmployeeState.loading() = Loading;

  const factory NewEmployeeState.success({
    @Default([]) List<NewEmployee> newEmployees,
    int? selectedNewEmployeeIndex,
  }) = Success;

  const factory NewEmployeeState.error([String? message]) = Error;
}
