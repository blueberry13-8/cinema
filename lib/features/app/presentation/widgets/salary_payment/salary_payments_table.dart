import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/models/salary_payment.dart';

import '../../bloc/salary_payment/salary_payment_cubit.dart';

class SalaryPaymentsTable extends StatelessWidget {
  const SalaryPaymentsTable({
    super.key,
    required this.salaryPayments,
    this.selectedSalaryPaymentIndex,
    this.editable=true,
  });

  final List<SalaryPayment> salaryPayments;

  final int? selectedSalaryPaymentIndex;

  final bool editable;

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 600,
      showCheckboxColumn: false,
      columns: editable ? kSalaryPaymentFields.map((e) => DataColumn2(label: Text(e),),).toList():
      kSalaryPaymentFields.sublist(1).map((e) => DataColumn2(label: Text(e),),).toList(),
      rows: salaryPayments.asMap().entries.map(
            (entry) {
          final index = entry.key;
          final salaryPayment = entry.value;
          return DataRow(
            selected: selectedSalaryPaymentIndex == index,
            onSelectChanged: (selected) {
              if (selected != null && selected) {
                context.read<SalaryPaymentCubit>().selectSalaryPayment(index);
              }
            },
            cells: [
              if (editable)
                DataCell(
                  Text('${salaryPayment.id}'),
                ),
              DataCell(
                Text(salaryPayment.date.toString()),
              ),
              DataCell(
                Text(salaryPayment.amount.toString()),
              ),
              DataCell(
                Text(salaryPayment.employeeId.toString()),
              ),
            ],
          );
        },
      ).toList(),
    );
  }
}
