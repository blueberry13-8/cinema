import 'package:bloc/bloc.dart';
import 'package:cinema/features/app/domain/repositories/database.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/movie_session.dart';

part 'session_cubit.freezed.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<MovieSessionState> {
  SessionCubit() : super(const MovieSessionState.initial());

  void selectSession(int newIndex) {
    if (state case Success state) {
      emit(
        state.copyWith(
          selectedSessionIndex: newIndex,
        ),
      );
    }
  }

  Future<void> loadSessions() async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const MovieSessionState.loading());
    try {
      final sessions = await Database().getSessions();
      emit(
        MovieSessionState.success(
          sessions: sessions,
          selectedSessionIndex: prevState?.selectedSessionIndex,
        ),
      );
    } catch (e) {
      emit(MovieSessionState.error(e.toString()));
      rethrow;
    }
  }

  Future<void> deleteSession(MovieSession session) async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const MovieSessionState.loading());
    try {
      await Database().deleteSession(session);
      final sessions = await Database().getSessions();
      final selectedSessionIndex =
      prevState != null && session.id == prevState.selectedSessionIndex
          ? null
          : prevState?.selectedSessionIndex;
      emit(
        MovieSessionState.success(
          sessions: sessions,
          selectedSessionIndex: selectedSessionIndex,
        ),
      );
    } catch (e) {
      emit(MovieSessionState.error(e.toString()));
      rethrow;
    }
  }

  Future<void> addSession() async {
    if (state case Success state) {
      final id = state.sessions.length;
      emit(
        state.copyWith(
          sessions: [
            ...state.sessions,
            MovieSession(
              id: id + 1,
              hallId: -1,
              movieId: -1,
              startTime: DateTime.fromMicrosecondsSinceEpoch(0),
            ),
          ],
          selectedSessionIndex: id,
        ),
      );
    }
  }

  Future<void> updateSession(
      MovieSession session, [
        bool isAdd = false,
      ]) async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const MovieSessionState.loading());
    try {
      if (isAdd) {
        await Database().addSession(session);
      } else {
        await Database().updateSession(session);
      }
      final sessions = await Database().getSessions();
      emit(
        MovieSessionState.success(
          sessions: sessions,
          selectedSessionIndex: prevState?.selectedSessionIndex,
        ),
      );
    } catch (e) {
      emit(MovieSessionState.error(e.toString()));
      rethrow;
    }
  }
}
