import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket.freezed.dart';

part 'ticket.g.dart';

@freezed
class Ticket with _$Ticket {
  const factory Ticket({
    required int id,
    @JsonKey(name: 'seat_number') required int seatNumber,
    @JsonKey(name: 'row_number') required int rowNumber,
    required double price,
    @JsonKey(name: 'session_id') required int sessionId,
    @JsonKey(name: 'customer_id') required int customerId,
  }) = _Ticket;

  factory Ticket.fromJson(Map<String, Object?> json) => _$TicketFromJson(json);
}

const kTicketFields = [
  'ID',
  'Seat number',
  'Row number',
  'Price',
  'Session ID',
  'Customer ID',
];
