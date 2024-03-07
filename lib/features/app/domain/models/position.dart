import 'package:freezed_annotation/freezed_annotation.dart';

part 'position.freezed.dart';

@freezed
class Position with _$Position {
  const factory Position({
    required int id,
    required String name,
    required String description,
    required num salary,
  }) = _Position;
}

const kPositionFields = [
  'ID',
  'Название',
  'Описание',
  'Оплата',
];
