import 'package:freezed_annotation/freezed_annotation.dart';

part 'hall.freezed.dart';
part 'hall.g.dart';

@freezed
class Hall with _$Hall {
  const factory Hall({
    required int id,
    required String type,
    @JsonKey(name: 'seats_number')
    required int seatsNumber,
  }) = _Hall;

  factory Hall.fromJson(Map<String, Object?> json) =>
      _$HallFromJson(json);
}