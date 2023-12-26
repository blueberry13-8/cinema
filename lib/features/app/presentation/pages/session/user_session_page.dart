import 'package:cinema/features/app/presentation/bloc/session/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/movie_session.dart';
import '../../widgets/session/my_editing_session_widget.dart';
import '../../widgets/session/sessions_table.dart';



class UserSessionsPage extends StatelessWidget {
  const UserSessionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SessionCubit()..loadSessions(),
      child: _UserSessionsPage(
        key: key,
      ),
    );
  }
}

class _UserSessionsPage extends StatefulWidget {
  const _UserSessionsPage({super.key});

  @override
  State<_UserSessionsPage> createState() => _UserSessionsPageState();
}

class _UserSessionsPageState extends State<_UserSessionsPage> {

  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<MovieSession> filtered(List<MovieSession> sessions, String? query) {
    if (query == null) return sessions;
    return sessions
        .where(
          (element) => element.id.toString().toLowerCase().contains(
        query.toLowerCase(),
      ),
    )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SessionCubit>().state;
    if (state case Success state) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 80.0,
                vertical: 10,
              ),
              child: TextFormField(
                controller: _searchController,
                onChanged: (newValue) => setState(() {}),
                decoration: const InputDecoration(
                  hintText: 'Поиск...',
                  icon: Icon(
                    Icons.search,
                  ),
                ),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 400,),
              child: SessionsTable(
                sessions: filtered(state.sessions, _searchController.text),
                selectedSessionIndex: state.selectedSessionIndex,
                editable: false,
              ),
            ),
            if (state.selectedSessionIndex != null)
              Padding(
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
                  editable: false,
                ),
              ),
          ],
        ),
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
