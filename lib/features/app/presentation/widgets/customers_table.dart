import 'package:cinema/features/app/presentation/widgets/my_table.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../domain/models/customer.dart';

class CustomersTable extends StatelessWidget {
  const CustomersTable({super.key, required this.customers});

  final List<Customer> customers;

  @override
  Widget build(BuildContext context) {
    return MyTable(
      columns: const [
        Text('ID'),
        Text('Login'),
        Text('Password'),
      ],
      rows: customers
          .map(
            (e) => [e.id.toString(), e.login, e.password]
                .map((e) => Text(e))
                .toList(),
          )
          .toList(),
    );
    return DataTable2(
      showCheckboxColumn: false,
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
      rows: customers
          .map(
            (customer) => DataRow2(
              onSelectChanged: (_) {},

              // color: MaterialStateProperty.resolveWith((states) {
              //   print(states);
              //   if (states.contains(MaterialState.hovered)) {
              //     return Colors.grey;
              //   }
              //   return Colors.white;
              // }),
              cells: [
                DataCell(
                  Text('${customer.id}'),
                ),
                DataCell(
                  Text(customer.login),
                ),
                DataCell(
                  Text(customer.password),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
