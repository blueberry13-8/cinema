import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/position.dart';
import '../../../domain/repositories/database.dart';

part 'position_state.dart';

part 'position_cubit.freezed.dart';

class PositionCubit extends Cubit<PositionState> {
  PositionCubit() : super(const PositionState.initial());

  void selectPosition(int newIndex) {
    if (state case Success state) {
      emit(
        state.copyWith(
          selectedPositionIndex: newIndex,
        ),
      );
    }
  }

  Future<void> loadPositions() async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const PositionState.loading());
    try {
      final positions = await Database().getPositions();
      emit(
        PositionState.success(
          positions: positions,
          selectedPositionIndex: prevState?.selectedPositionIndex,
        ),
      );
    } catch (e) {
      emit(PositionState.error(e.toString()));
      rethrow;
    }
  }

  Future<void> deletePosition(Position position) async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const PositionState.loading());
    try {
      await Database().deletePosition(position);
      final positions = await Database().getPositions();
      final selectedPositionIndex =
          prevState != null && position.id == prevState.selectedPositionIndex
              ? null
              : prevState?.selectedPositionIndex;
      emit(
        PositionState.success(
          positions: positions,
          selectedPositionIndex: selectedPositionIndex,
        ),
      );
    } catch (e) {
      emit(PositionState.error(e.toString()));
      rethrow;
    }
  }

  Future<void> addPosition() async {
    if (state case Success state) {
      final id = state.positions.length;
      emit(
        state.copyWith(
          positions: [
            ...state.positions,
            Position(
              id: id + 1,
              name: '',
              description: '',
              salary: 0,
            ),
          ],
          selectedPositionIndex: id,
        ),
      );
    }
  }

  Future<void> updatePosition(
      Position position, [
        bool isAdd = false,
      ]) async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const PositionState.loading());
    try {
      if (isAdd) {
        await Database().addPosition(position);
      } else {
        await Database().updatePosition(position);
      }
      final positions = await Database().getPositions();
      emit(
        PositionState.success(
          positions: positions,
          selectedPositionIndex: prevState?.selectedPositionIndex,
        ),
      );
    } catch (e) {
      emit(PositionState.error(e.toString()));
      rethrow;
    }
  }
}
