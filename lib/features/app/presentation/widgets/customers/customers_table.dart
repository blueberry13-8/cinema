import 'package:cinema/features/app/domain/models/customer.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/customer/customer_cubit.dart';

class CustomersTable extends StatelessWidget {
  const CustomersTable({
    super.key,
    required this.customers,
    this.selectedCustomerIndex,
    this.editable=true,
  });

  final List<Customer> customers;

  final int? selectedCustomerIndex;

  final bool editable;

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 600,
      showCheckboxColumn: false,
      columns: editable ? kCustomerFields.map((e) => DataColumn2(label: Text(e),),).toList():
                          kCustomerFields.sublist(1).map((e) => DataColumn2(label: Text(e),),).toList(),
      rows: customers.asMap().entries.map(
            (entry) {
          final index = entry.key;
          final customer = entry.value;
          return DataRow(
            selected: selectedCustomerIndex == index,
            onSelectChanged: (selected) {
              if (selected != null && selected) {
                context.read<CustomerCubit>().selectCustomer(index);
              }
            },
            cells: [
              if (editable)
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
          );
        },
      ).toList(),
    );
  }
}
