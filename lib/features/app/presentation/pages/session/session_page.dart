import 'package:cinema/features/app/presentation/bloc/session/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/movie_session.dart';
import '../../widgets/session/my_editing_session_widget.dart';
import '../../widgets/session/sessions_table.dart';



class SessionsPage extends StatelessWidget {
  const SessionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SessionCubit()..loadSessions(),
      child: _SessionsPage(
        key: key,
      ),
    );
  }
}

class _SessionsPage extends StatelessWidget {
  const _SessionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SessionCubit>().state;
    if (state case Success state) {
      return Stack(
        children: [
          SessionsTable(
            sessions: state.sessions,
            selectedSessionIndex: state.selectedSessionIndex,
          ),
          if (state.selectedSessionIndex != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 150.0,
                  vertical: 20,
                ),
                child: MyEditingSessionWidget(
                  session: state.selectedSessionIndex! >= 0 &&
                      state.selectedSessionIndex! < state.sessions.length
                      ? state.sessions[state.selectedSessionIndex!]
                      : null,
                  fields: kSessionFields,
                ),
              ),
            ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () {
                  context.read<SessionCubit>().selectSession(-1);
                },
                child: const Icon(Icons.add),
              ),
            ),
          ),
        ],
      );
    } else if (state case Loading || Initial) {
      return const CircularProgressIndicator();
    } else {
      return const Center(
        child: Text('Error'),
      );
    }
  }
}
