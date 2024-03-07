part of 'department_cubit.dart';

@freezed
class DepartmentState with _$DepartmentState {
  const factory DepartmentState.initial() = Initial;

  const factory DepartmentState.loading() = Loading;

  const factory DepartmentState.success({
    @Default([]) List<Department> departments,
    int? selectedDepartmentIndex,
  }) = Success;

  const factory DepartmentState.error([String? message]) = Error;
}
