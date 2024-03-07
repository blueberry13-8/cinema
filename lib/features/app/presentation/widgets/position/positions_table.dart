import 'package:cinema/features/app/domain/models/position.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/position/position_cubit.dart';

class PositionsTable extends StatelessWidget {
  const PositionsTable({
    super.key,
    required this.positions,
    this.selectedPositionIndex,
    this.editable=true,
  });

  final List<Position> positions;

  final int? selectedPositionIndex;

  final bool editable;

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 600,
      showCheckboxColumn: false,
      columns: editable ? kPositionFields.map((e) => DataColumn2(label: Text(e),),).toList():
      kPositionFields.sublist(1).map((e) => DataColumn2(label: Text(e),),).toList(),
      rows: positions.asMap().entries.map(
            (entry) {
          final index = entry.key;
          final position = entry.value;
          return DataRow(
            selected: selectedPositionIndex == index,
            onSelectChanged: (selected) {
              if (selected != null && selected) {
                context.read<PositionCubit>().selectPosition(index);
              }
            },
            cells: [
              if (editable)
                DataCell(
                  Text('${position.id}'),
                ),
              DataCell(
                Text(position.name),
              ),
              DataCell(
                Text(position.description),
              ),
              DataCell(
                Text(position.salary.toString()),
              ),
            ],
          );
        },
      ).toList(),
    );
  }
}
