part of 'ticket_cubit.dart';

@freezed
class TicketState with _$TicketState {
  const factory TicketState.initial() = Initial;

  const factory TicketState.loading() = Loading;

  const factory TicketState.success({
    @Default([]) List<Ticket> tickets,
    int? selectedTicketIndex,
  }) = Success;

  const factory TicketState.error([String? message]) = Error;
}