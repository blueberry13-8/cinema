import 'package:bloc/bloc.dart';
import 'package:cinema/features/app/domain/repositories/database.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/customer.dart';

part 'customer_cubit.freezed.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit() : super(const CustomerState.initial());

  void selectCustomer(int newIndex) {
    if (state case Success state) {
      emit(
        state.copyWith(
          selectedCustomerIndex: newIndex,
        ),
      );
    }
  }

  Future<void> loadCustomers() async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const CustomerState.loading());
    try {
      final customers = await Database().getCustomers();
      emit(
        CustomerState.success(
          customers: customers,
          selectedCustomerIndex: prevState?.selectedCustomerIndex,
        ),
      );
    } catch (e) {
      emit(CustomerState.error(e.toString()));
      rethrow;
    }
  }

  Future<void> deleteCustomer(Customer customer) async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const CustomerState.loading());
    try {
      await Database().deleteCustomer(customer);
      final customers = await Database().getCustomers();
      final selectedCustomerIndex =
          prevState != null && customer.id == prevState.selectedCustomerIndex
              ? null
              : prevState?.selectedCustomerIndex;
      emit(
        CustomerState.success(
          customers: customers,
          selectedCustomerIndex: selectedCustomerIndex,
        ),
      );
    } catch (e) {
      emit(CustomerState.error(e.toString()));
      rethrow;
    }
  }

  Future<void> addCustomer() async {
    if (state case Success state) {
      final id = state.customers.length;
      emit(
        state.copyWith(
          customers: [
            ...state.customers,
            Customer(
              id: id + 1,
              login: '',
              password: '',
            ),
          ],
          selectedCustomerIndex: id,
        ),
      );
    }
  }

  Future<void> updateCustomer(
    Customer customer, [
    bool isAdd = false,
  ]) async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const CustomerState.loading());
    try {
      if (isAdd) {
        await Database().addCustomer(customer);
      } else {
        await Database().updateCustomer(customer);
      }
      final customers = await Database().getCustomers();
      emit(
        CustomerState.success(
          customers: customers,
          selectedCustomerIndex: prevState?.selectedCustomerIndex,
        ),
      );
    } catch (e) {
      emit(CustomerState.error(e.toString()));
      rethrow;
    }
  }

  Future<void> updateCustomer2(Map<String, String> fields,
      [bool isAdd = false]) async {
    final customer = Customer(
      id: int.parse(fields['id']!),
      login: fields['login']!,
      password: fields['password']!,
    );
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const CustomerState.loading());
    try {
      if (isAdd) {
        await Database().addCustomer(customer);
      } else {
        await Database().updateCustomer(customer);
      }
      final customers = await Database().getCustomers();
      emit(
        CustomerState.success(
          customers: customers,
          selectedCustomerIndex: prevState?.selectedCustomerIndex,
        ),
      );
    } catch (e) {
      emit(CustomerState.error(e.toString()));
      rethrow;
    }
  }
}
