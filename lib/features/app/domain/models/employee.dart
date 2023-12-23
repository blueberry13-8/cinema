import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee.freezed.dart';
part 'employee.g.dart';

@freezed
class Employee with _$Employee {
  const factory Employee({
    required int id,
    required String name,
    required String position,
    required num salary,
  }) = _Employee;

  factory Employee.fromJson(Map<String, Object?> json) =>
      _$EmployeeFromJson(json);
}