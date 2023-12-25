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

class _TicketsPage extends StatefulWidget {
  const _TicketsPage({super.key});

  @override
  State<_TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<_TicketsPage> {
  late final TextEditingController _searchController;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  List<Ticket> filtered(List<Ticket> tickets, String? query) {
    if (query == null) return tickets;
    return tickets
        .where(
          (element) => element.id.toString().toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TicketCubit>().state;
    if (state case Success state) {
      return Stack(
        children: [
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
          SingleChildScrollView(
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
                      hintText: 'Search...',
                      icon: Icon(
                        Icons.search,
                      ),
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 400,
                    // minHeight: 150,
                  ),
                  child: TicketsTable(
                    tickets: filtered(state.tickets, _searchController.text),
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
                    ),
                  ),
              ],
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
