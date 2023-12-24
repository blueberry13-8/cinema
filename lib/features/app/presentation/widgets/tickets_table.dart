import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../domain/models/ticket.dart';

class TicketsTable extends StatelessWidget {
  const TicketsTable({super.key, required this.tickets});

  final List<Ticket> tickets;

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
          label: Text('Seat Number'),
        ),
        DataColumn(
          label: Text('Row Number'),
        ),
        DataColumn(
          label: Text('Price'),
        ),
        DataColumn(
          label: Text('Session ID'),
        ),
        DataColumn(
          label: Text('Customer ID'),
        ),
      ],
      rows: tickets
          .map(
            (movie) => DataRow(
              cells: [
                DataCell(
                  Text('${movie.id}'),
                ),
                DataCell(
                  Text('${movie.seatNumber}'),
                ),
                DataCell(
                  Text('${movie.rowNumber}'),
                ),
                DataCell(
                  Text('${movie.price}'),
                ),
                DataCell(
                  Text('${movie.sessionId}'),
                ),
                DataCell(
                  Text('${movie.customerId}'),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
