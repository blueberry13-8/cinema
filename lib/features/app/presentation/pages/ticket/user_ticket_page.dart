import 'package:cinema/features/app/presentation/bloc/ticket/ticket_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/ticket.dart';
import '../../widgets/ticket/my_editing_ticket_widget.dart';
import '../../widgets/ticket/tickets_table.dart';

class UserTicketsPage extends StatelessWidget {
  const UserTicketsPage({super.key, required this.login});

  final String login;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TicketCubit()..loadTickets(login),
      child: _UserTicketsPage(
        key: key,
      ),
    );
  }
}

class _UserTicketsPage extends StatelessWidget {
  const _UserTicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TicketCubit>().state;
    if (state case Success state) {
      return SingleChildScrollView(
        child: Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 400,
              ),
              child: TicketsTable(
                tickets: state.tickets,
                selectedTicketIndex: state.selectedTicketIndex,
              ),
            ),
            if (state.selectedTicketIndex != null)
              Padding(
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
