part of 'customer_cubit.dart';

@freezed
class CustomerState with _$CustomerState {
  const factory CustomerState.initial() = Initial;

  const factory CustomerState.loading() = Loading;

  const factory CustomerState.success({
    @Default([]) List<Customer> customers,
    int? selectedCustomerIndex,
  }) = Success;

  const factory CustomerState.error([String? message]) = Error;
}
