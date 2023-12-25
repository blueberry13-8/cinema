import 'package:cinema/features/app/presentation/bloc/ticket/ticket_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/ticket.dart';
import '../../widgets/ticket/my_editing_ticket_widget.dart';
import '../../widgets/ticket/tickets_table.dart';

class TicketsPage extends StatelessWidget {
  const TicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TicketCubit()..loadTickets(),
      child: _TicketsPage(
        key: key,
      ),
    );
  }
}

class _TicketsPage extends StatelessWidget {
  const _TicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TicketCubit>().state;
    if (state case Success state) {
      return Stack(
        children: [
          TicketsTable(
            tickets: state.tickets,
            selectedTicketIndex: state.selectedTicketIndex,
          ),
          if (state.selectedTicketIndex != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 150.0,
                  vertical: 20,
                ),
                child: MyEditingTicketWidget(
                  ticket: state.selectedTicketIndex! >= 0 &&
                      state.selectedTicketIndex! < state.tickets.length
                      ? state.tickets[state.selectedTicketIndex!]
                      : null,
                  fields: kTicketFields,
                ),
              ),
            ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () {
                  context.read<TicketCubit>().selectTicket(-1);
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
