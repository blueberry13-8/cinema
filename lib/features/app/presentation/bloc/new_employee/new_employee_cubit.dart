import 'package:bloc/bloc.dart';
import 'package:cinema/features/app/domain/models/new_employee.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cinema/features/app/domain/repositories/database.dart';

part 'new_employee_state.dart';
part 'new_employee_cubit.freezed.dart';

class NewEmployeeCubit extends Cubit<NewEmployeeState> {
  NewEmployeeCubit() : super(const NewEmployeeState.initial());

  void selectNewEmployee(int newIndex) {
    if (state case Success state) {
      emit(
        state.copyWith(
          selectedNewEmployeeIndex: newIndex,
        ),
      );
    }
  }

  Future<void> loadNewEmployees() async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const NewEmployeeState.loading());
    try {
      final newEmployees = await Database().getNewEmployees();
      emit(
        NewEmployeeState.success(
          newEmployees: newEmployees,
          selectedNewEmployeeIndex: prevState?.selectedNewEmployeeIndex,
        ),
      );
    } catch (e) {
      emit(NewEmployeeState.error(e.toString()));
      rethrow;
    }
  }

  Future<void> deleteNewEmployee(NewEmployee newEmployee) async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const NewEmployeeState.loading());
    try {
      await Database().deleteNewEmployee(newEmployee);
      final newEmployees = await Database().getNewEmployees();
      final selectedCustomerIndex =
      prevState != null && newEmployee.id == prevState.selectedNewEmployeeIndex
          ? null
          : prevState?.selectedNewEmployeeIndex;
      emit(
        NewEmployeeState.success(
          newEmployees: newEmployees,
          selectedNewEmployeeIndex: selectedCustomerIndex,
        ),
      );
    } catch (e) {
      emit(NewEmployeeState.error(e.toString()));
      rethrow;
    }
  }

  Future<void> addNewEmployee() async {
    if (state case Success state) {
      final id = state.newEmployees.length;
      emit(
        state.copyWith(
          newEmployees: [
            ...state.newEmployees,
            NewEmployee(
              id: id + 1,
              firstName: '',
              surname: '',
              startDate: DateTime.now(),
              password: '',
              otherInfo: '',
              positionId: 0,
              departmentId: 0,
            ),
          ],
          selectedNewEmployeeIndex: id,
        ),
      );
    }
  }

  Future<void> updateNewEmployee(
      NewEmployee newEmployee, [
        bool isAdd = false,
      ]) async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const NewEmployeeState.loading());
    try {
      if (isAdd) {
        await Database().addNewEmployee(newEmployee);
      } else {
        await Database().updateNewEmployee(newEmployee);
      }
      final newEmployees = await Database().getNewEmployees();
      emit(
        NewEmployeeState.success(
          newEmployees: newEmployees,
          selectedNewEmployeeIndex: prevState?.selectedNewEmployeeIndex,
        ),
      );
    } catch (e) {
      emit(NewEmployeeState.error(e.toString()));
      rethrow;
    }
  }
}
