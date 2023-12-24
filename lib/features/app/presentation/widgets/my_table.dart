import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class MyTable extends StatelessWidget {
  const MyTable({super.key, required this.rows, required this.columns});

  final List<List<Widget>> rows;
  final List<Widget> columns;

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 600,
      columns: columns
          .map(
            (e) => DataColumn2(
              label: e,
            ),
          )
          .toList(),
      rows: rows
          .map(
            (cells) => DataRow(
              cells: cells
                  .map(
                    (e) => DataCell(e),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }
}
