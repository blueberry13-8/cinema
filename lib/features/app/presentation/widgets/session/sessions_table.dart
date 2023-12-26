import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/movie_session.dart';
import '../../bloc/session/session_cubit.dart';

class SessionsTable extends StatelessWidget {
  const SessionsTable({
    super.key,
    required this.sessions,
    this.selectedSessionIndex,
    this.editable=true,
  });

  final List<MovieSession> sessions;

  final int? selectedSessionIndex;

  final bool editable;

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 600,
      showCheckboxColumn: false,
      columns: editable
          ? kSessionFields.map((e) => DataColumn2(label: Text(e),),).toList()
          : kSessionFields.sublist(1).map((e) => DataColumn2(label: Text(e),),).toList(),
      // columns: kSessionFields.map((e) => DataColumn2(label: Text(e),),).toList(),
      rows: sessions.asMap().entries.map(
            (entry) {
          final index = entry.key;
          final session = entry.value;
          return DataRow(
            selected: selectedSessionIndex == index,
            onSelectChanged: (selected) {
              if (selected != null && selected) {
                context.read<SessionCubit>().selectSession(index);
              }
            },
            cells: [
              if (editable)
                DataCell(
                  Text('${session.id}'),
                ),
              DataCell(
                Text('${session.hallId}'),
              ),
              DataCell(
                Text('${session.movieId}'),
              ),
              DataCell(
                Text('${session.startTime}'),
              ),
            ],
          );
        },
      ).toList(),
    );
  }
}
