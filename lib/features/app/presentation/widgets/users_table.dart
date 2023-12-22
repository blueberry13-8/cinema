import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class UsersTable extends StatelessWidget {
  const UsersTable({super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 600,
      columns: const [
        DataColumn2(
          label: Text('ID'),
          size: ColumnSize.L,
        ),
        DataColumn(
          label: Text('Login'),
        ),
        DataColumn(
          label: Text('Password'),
        ),
      ],
      rows: List<DataRow>.generate(
        100,
            (index) => DataRow(
          cells: [
            DataCell(Text('A' * (10 - index % 10))),
            DataCell(Text('B' * (10 - (index + 5) % 10))),
            DataCell(Text('C' * (15 - (index + 5) % 10))),
          ],
        ),
      ),
    );
  }
}
