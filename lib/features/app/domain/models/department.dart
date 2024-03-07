import 'package:freezed_annotation/freezed_annotation.dart';

part 'department.freezed.dart';

@freezed
class Department with _$Department {
  const factory Department({
    required int id,
    required String name,
    required String description,
  }) = _Department;
}

const kDepartmentFields = [
  'ID',
  'Название',
  'Описание',
];