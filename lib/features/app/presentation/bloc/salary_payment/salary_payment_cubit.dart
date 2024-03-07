import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/salary_payment.dart';
import '../../../domain/repositories/database.dart';

part 'salary_payment_state.dart';

part 'salary_payment_cubit.freezed.dart';

class SalaryPaymentCubit extends Cubit<SalaryPaymentState> {
  SalaryPaymentCubit() : super(const SalaryPaymentState.initial());

  void selectSalaryPayment(int newIndex) {
    if (state case Success state) {
      emit(
        state.copyWith(
          selectedSalaryPaymentIndex: newIndex,
        ),
      );
    }
  }

  Future<void> loadSalaryPayments({String? newEmployeeId}) async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const SalaryPaymentState.loading());
    try {
      final salaryPayments =
          await Database().getSalaryPayments(newEmployeeId: newEmployeeId,);
      emit(
        SalaryPaymentState.success(
          salaryPayments: salaryPayments,
          selectedSalaryPaymentIndex: prevState?.selectedSalaryPaymentIndex,
        ),
      );
    } catch (e) {
      emit(SalaryPaymentState.error(e.toString()));
      rethrow;
    }
  }

  Future<void> deleteSalaryPayment(SalaryPayment salaryPayment) async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const SalaryPaymentState.loading());
    try {
      await Database().deleteSalaryPayment(salaryPayment);
      final salaryPayments = await Database().getSalaryPayments();
      final selectedSalaryPaymentIndex = prevState != null &&
              salaryPayment.id == prevState.selectedSalaryPaymentIndex
          ? null
          : prevState?.selectedSalaryPaymentIndex;
      emit(
        SalaryPaymentState.success(
          salaryPayments: salaryPayments,
          selectedSalaryPaymentIndex: selectedSalaryPaymentIndex,
        ),
      );
    } catch (e) {
      emit(SalaryPaymentState.error(e.toString()));
      rethrow;
    }
  }

  Future<void> addSalaryPayment() async {
    if (state case Success state) {
      final id = state.salaryPayments.length;
      emit(
        state.copyWith(
          salaryPayments: [
            ...state.salaryPayments,
            SalaryPayment(
              id: id + 1,
              date: DateTime.now(),
              amount: 0,
              employeeId: 0,
            ),
          ],
          selectedSalaryPaymentIndex: id,
        ),
      );
    }
  }

  Future<void> updateSalaryPayment(
    SalaryPayment salaryPayment, [
    bool isAdd = false,
  ]) async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const SalaryPaymentState.loading());
    try {
      if (isAdd) {
        await Database().addSalaryPayment(salaryPayment);
      } else {
        await Database().updateSalaryPayment(salaryPayment);
      }
      final salaryPayments = await Database().getSalaryPayments();
      emit(
        SalaryPaymentState.success(
          salaryPayments: salaryPayments,
          selectedSalaryPaymentIndex: prevState?.selectedSalaryPaymentIndex,
        ),
      );
    } catch (e) {
      emit(SalaryPaymentState.error(e.toString()));
      rethrow;
    }
  }
}
