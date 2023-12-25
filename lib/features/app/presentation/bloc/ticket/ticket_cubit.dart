import 'package:bloc/bloc.dart';
import 'package:cinema/features/app/domain/repositories/database.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/ticket.dart';

part 'ticket_cubit.freezed.dart';

part 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> {
  TicketCubit() : super(const TicketState.initial());

  void selectTicket(int newIndex) {
    if (state case Success state) {
      emit(
        state.copyWith(
          selectedTicketIndex: newIndex,
        ),
      );
    }
  }

  Future<void> loadTickets() async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const TicketState.loading());
    try {
      final tickets = await Database().getTickets();
      emit(
        TicketState.success(
          tickets: tickets,
          selectedTicketIndex: prevState?.selectedTicketIndex,
        ),
      );
    } catch (e) {
      emit(TicketState.error(e.toString()));
      rethrow;
    }
  }

  Future<void> deleteTicket(Ticket ticket) async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const TicketState.loading());
    try {
      await Database().deleteTicket(ticket);
      final tickets = await Database().getTickets();
      final selectedTicketIndex =
      prevState != null && ticket.id == prevState.selectedTicketIndex
          ? null
          : prevState?.selectedTicketIndex;
      emit(
        TicketState.success(
          tickets: tickets,
          selectedTicketIndex: selectedTicketIndex,
        ),
      );
    } catch (e) {
      emit(TicketState.error(e.toString()));
      rethrow;
    }
  }

  Future<void> addTicket() async {
    if (state case Success state) {
      final id = state.tickets.length;
      emit(
        state.copyWith(
          tickets: [
            ...state.tickets,
            Ticket(
              id: id + 1,
              customerId: -1,
              price: -1,
              rowNumber: -1,
              seatNumber: -1,
              sessionId: -1,
            ),
          ],
          selectedTicketIndex: id,
        ),
      );
    }
  }

  Future<void> updateTicket(
      Ticket ticket, [
        bool isAdd = false,
      ]) async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const TicketState.loading());
    try {
      if (isAdd) {
        await Database().addTicket(ticket);
      } else {
        await Database().updateTicket(ticket);
      }
      final tickets = await Database().getTickets();
      emit(
        TicketState.success(
          tickets: tickets,
          selectedTicketIndex: prevState?.selectedTicketIndex,
        ),
      );
    } catch (e) {
      emit(TicketState.error(e.toString()));
      rethrow;
    }
  }

// Future<void> updateTicket2(Map<String, String> fields, [bool isAdd = false]) async {
//   final ticket = Ticket(
//       id: int.parse(fields['id']!),
//       duration: int.parse(fields['duration']!),
//       genre: fields['genre']!,
//       name: fields['name']!);
//   Success? prevState;
//   if (state case Success state) {
//     prevState = state.copyWith();
//   }
//   emit(const TicketState.loading());
//   try {
//     if (isAdd) {
//       await Database().addTicket(ticket);
//     } else {
//       await Database().updateTicket(ticket);
//     }
//     final tickets = await Database().getTickets();
//     emit(
//       TicketState.success(
//         tickets: tickets,
//         selectedTicketIndex: prevState?.selectedTicketIndex,
//       ),
//     );
//   } catch (e) {
//     emit(TicketState.error(e.toString()));
//     rethrow;
//   }
// }
}
