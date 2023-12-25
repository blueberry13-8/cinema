import 'package:cinema/features/app/domain/models/ticket.dart';
import 'package:cinema/features/app/presentation/bloc/ticket/ticket_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../my_form_field.dart';

class MyEditingTicketWidget extends StatefulWidget {
  const MyEditingTicketWidget({
    super.key,
    required this.fields,
    this.ticket,
  });

  final Ticket? ticket;
  final List<String> fields;

  @override
  State<MyEditingTicketWidget> createState() => _MyEditingTicketWidgetState();
}

class _MyEditingTicketWidgetState extends State<MyEditingTicketWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.ticket == null) {
      _ticket = const Ticket(
        id: -1,
        seatNumber: -1,
        rowNumber: -1,
        price: -1,
        sessionId: -1,
        customerId: -1,
      );
    } else {
      _ticket = widget.ticket!;
    }
  }

  late Ticket _ticket;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyFormField(
          fieldName: widget.fields[0],
          value: widget.ticket?.id,
          onChanged: (newValue) => _ticket = _ticket.copyWith(
            id: int.parse(newValue),
          ),
        ),
        MyFormField(
          fieldName: widget.fields[1],
          value: widget.ticket?.seatNumber,
          onChanged: (newValue) => _ticket = _ticket.copyWith(
            seatNumber: int.parse(newValue),
          ),
        ),
        MyFormField(
          fieldName: widget.fields[2],
          value: widget.ticket?.rowNumber,
          onChanged: (newValue) => _ticket = _ticket.copyWith(
            rowNumber: int.parse(newValue),
          ),
        ),
        MyFormField(
          fieldName: widget.fields[3],
          value: widget.ticket?.price,
          onChanged: (newValue) => _ticket = _ticket.copyWith(
            price: double.parse(newValue),
          ),
        ),
        MyFormField(
          fieldName: widget.fields[4],
          value: widget.ticket?.sessionId,
          onChanged: (newValue) => _ticket = _ticket.copyWith(
            sessionId: int.parse(newValue),
          ),
        ),
        MyFormField(
          fieldName: widget.fields[5],
          value: widget.ticket?.customerId,
          onChanged: (newValue) => _ticket = _ticket.copyWith(
            customerId: int.parse(newValue),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<TicketCubit>().updateTicket(
                      _ticket,
                      widget.ticket == null,
                    );
              },
              child: const Text('Обновить'),
            ),
            const SizedBox(
              width: 15,
            ),
            ElevatedButton(
              onPressed: () async {
                if (widget.ticket != null) {
                  context.read<TicketCubit>().deleteTicket(
                        widget.ticket!,
                      );
                }
              },
              child: const Text('Удалить'),
            ),
          ],
        ),
      ],
    );
  }
}
