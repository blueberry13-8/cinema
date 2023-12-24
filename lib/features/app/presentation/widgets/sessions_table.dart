import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../domain/models/movie_session.dart';

class SessionsTable extends StatelessWidget {
  const SessionsTable({super.key, required this.sessions});

  final List<MovieSession> sessions;

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 600,
      columns: const [
        DataColumn2(
          label: Text('ID'),
          size: ColumnSize.S,
        ),
        DataColumn(
          label: Text('Movie Id'),
        ),
        DataColumn(
          label: Text('Hall Id'),
        ),
        DataColumn(
          label: Text('Start Time'),
        ),
      ],
      rows: sessions
          .map(
            (session) => DataRow(
          cells: [
            DataCell(
              Text('${session.id}'),
            ),
            DataCell(
              Text('${session.movieId}'),
            ),
            DataCell(
              Text(session.hallId.toString()),
            ),
            DataCell(
              Text(session.startTime.toString()),
            ),
          ],
        ),
      )
          .toList(),
    );
  }
}
