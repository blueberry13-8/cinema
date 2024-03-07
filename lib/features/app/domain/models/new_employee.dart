import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_employee.freezed.dart';

@freezed
class NewEmployee with _$NewEmployee {
  const factory NewEmployee({
    required int id,
    required String firstName,
    required String surname,
    required DateTime startDate,
    required String password,
    required String otherInfo,
    required int positionId,
    required int departmentId,
  }) = _NewEmployee;
}

const kNewEmployeeFields = [
  'ID',
  'Имя',
  'Фамилия',
  'Дата начала работы',
  'Пароль',
  'Дополнительная информация',
  'ID должности',
  'ID отдела',
];