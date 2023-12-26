import 'package:cinema/features/app/domain/models/ticket.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/ticket/ticket_cubit.dart';

class TicketsTable extends StatelessWidget {
  const TicketsTable({
    super.key,
    required this.tickets,
    this.selectedTicketIndex,
    this.scrollController,
    this.editable = true,
  });

  final List<Ticket> tickets;

  final int? selectedTicketIndex;

  final ScrollController? scrollController;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      scrollController: scrollController,
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 600,
      showCheckboxColumn: false,
      columns: editable
          ? kTicketFields.map((e) => DataColumn2(label: Text(e),),).toList()
          : kTicketFields.sublist(1).map((e) => DataColumn2(label: Text(e),),).toList(),
      rows: tickets.asMap().entries.map(
        (entry) {
          final index = entry.key;
          final ticket = entry.value;
          return DataRow(
            selected: selectedTicketIndex == index,
            onSelectChanged: (selected) {
              if (selected != null && selected) {
                context.read<TicketCubit>().selectTicket(index);
              }
            },
            cells: [
              if (editable)
                DataCell(
                  Text('${ticket.id}'),
                ),
              DataCell(
                Text('${ticket.seatNumber}'),
              ),
              DataCell(
                Text('${ticket.rowNumber}'),
              ),
              DataCell(
                Text('${ticket.price}'),
              ),
              DataCell(
                Text('${ticket.sessionId}'),
              ),
              DataCell(
                Text('${ticket.customerId}'),
              ),
            ],
          );
        },
      ).toList(),
    );
  }
}
