import 'package:freezed_annotation/freezed_annotation.dart';

part 'salary_payment.freezed.dart';

@freezed
class SalaryPayment with _$SalaryPayment {
  const factory SalaryPayment({
    required int id,
    required DateTime date,
    required num amount,
    required int employeeId,
  }) = _SalaryPayment;
}

const kSalaryPaymentFields = [
  'ID',
  'Дата выплаты',
  'Сумма',
  'ID работника'
];
