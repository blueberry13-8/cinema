import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/models/department.dart';
import 'package:cinema/features/app/domain/repositories/database.dart';

part 'department_state.dart';
part 'department_cubit.freezed.dart';

class DepartmentCubit extends Cubit<DepartmentState> {
  DepartmentCubit() : super(const DepartmentState.initial());

  void selectDepartment(int newIndex) {
    if (state case Success state) {
      emit(
        state.copyWith(
          selectedDepartmentIndex: newIndex,
        ),
      );
    }
  }

  Future<void> loadDepartments() async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const DepartmentState.loading());
    try {
      final departments = await Database().getDepartments();
      emit(
        DepartmentState.success(
          departments: departments,
          selectedDepartmentIndex: prevState?.selectedDepartmentIndex,
        ),
      );
    } catch (e) {
      emit(DepartmentState.error(e.toString()));
      rethrow;
    }
  }

  Future<void> deleteDepartment(Department department) async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const DepartmentState.loading());
    try {
      await Database().deleteDepartment(department);
      final departments = await Database().getDepartments();
      final selectedDepartmentIndex =
      prevState != null && department.id == prevState.selectedDepartmentIndex
          ? null
          : prevState?.selectedDepartmentIndex;
      emit(
        DepartmentState.success(
          departments: departments,
          selectedDepartmentIndex: selectedDepartmentIndex,
        ),
      );
    } catch (e) {
      emit(DepartmentState.error(e.toString()));
      rethrow;
    }
  }

  Future<void> addDepartment() async {
    if (state case Success state) {
      final id = state.departments.length;
      emit(
        state.copyWith(
          departments: [
            ...state.departments,
            Department(
              id: id + 1,
              name: '',
              description: '',
            ),
          ],
          selectedDepartmentIndex: id,
        ),
      );
    }
  }

  Future<void> updateDepartment(
      Department department, [
        bool isAdd = false,
      ]) async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const DepartmentState.loading());
    try {
      if (isAdd) {
        await Database().addDepartment(department);
      } else {
        await Database().updateDepartment(department);
      }
      final departments = await Database().getDepartments();
      emit(
        DepartmentState.success(
          departments: departments,
          selectedDepartmentIndex: prevState?.selectedDepartmentIndex,
        ),
      );
    } catch (e) {
      emit(DepartmentState.error(e.toString()));
      rethrow;
    }
  }
}
