part of 'salary_payment_cubit.dart';

@freezed
class SalaryPaymentState with _$SalaryPaymentState {
  const factory SalaryPaymentState.initial() = Initial;

  const factory SalaryPaymentState.loading() = Loading;

  const factory SalaryPaymentState.success({
    @Default([]) List<SalaryPayment> salaryPayments,
    int? selectedSalaryPaymentIndex,
  }) = Success;

  const factory SalaryPaymentState.error([String? message]) = Error;
}
