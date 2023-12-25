import 'package:cinema/features/app/domain/models/ticket.dart';
import 'package:flutter/material.dart';
import '../my_form_field.dart';

class MyEditingTicketWidget extends StatefulWidget {
  const MyEditingTicketWidget({
    super.key,
    required this.fields,
    this.ticket,
    this.editable=true,
  });

  final Ticket? ticket;
  final List<String> fields;
  final bool editable;

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
          editable: false,
        ),
        MyFormField(
          fieldName: widget.fields[1],
          value: widget.ticket?.seatNumber,
          onChanged: (newValue) => _ticket = _ticket.copyWith(
            seatNumber: int.parse(newValue),
          ),
          editable: widget.editable,
        ),
        MyFormField(
          fieldName: widget.fields[2],
          value: widget.ticket?.rowNumber,
          onChanged: (newValue) => _ticket = _ticket.copyWith(
            rowNumber: int.parse(newValue),
          ),
          editable: widget.editable,
        ),
        MyFormField(
          fieldName: widget.fields[3],
          value: widget.ticket?.price,
          onChanged: (newValue) => _ticket = _ticket.copyWith(
            price: double.parse(newValue),
          ),
          editable: widget.editable,
        ),
        MyFormField(
          fieldName: widget.fields[4],
          value: widget.ticket?.sessionId,
          onChanged: (newValue) => _ticket = _ticket.copyWith(
            sessionId: int.parse(newValue),
          ),
          editable: widget.editable,
        ),
        MyFormField(
          fieldName: widget.fields[5],
          value: widget.ticket?.customerId,
          onChanged: (newValue) => _ticket = _ticket.copyWith(
            customerId: int.parse(newValue),
          ),
          editable: widget.editable,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
