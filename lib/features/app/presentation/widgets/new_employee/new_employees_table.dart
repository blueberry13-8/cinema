import 'package:cinema/features/app/domain/models/new_employee.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/new_employee/new_employee_cubit.dart';

class NewEmployeesTable extends StatelessWidget {
  const NewEmployeesTable({
    super.key,
    required this.newEmployees,
    this.selectedNewEmployeeIndex,
    this.editable = true,
  });

  final List<NewEmployee> newEmployees;

  final int? selectedNewEmployeeIndex;

  final bool editable;

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 600,
      showCheckboxColumn: false,
      columns: editable ? kNewEmployeeFields.map((e) => DataColumn2(label: Text(e),),).toList():
      kNewEmployeeFields.sublist(1).map((e) => DataColumn2(label: Text(e),),).toList(),
      rows: newEmployees.asMap().entries.map(
            (entry) {
          final index = entry.key;
          final newEmployee = entry.value;
          return DataRow(
            selected: selectedNewEmployeeIndex == index,
            onSelectChanged: (selected) {
              if (selected != null && selected) {
                context.read<NewEmployeeCubit>().selectNewEmployee(index);
              }
            },
            cells: [
              if (editable)
                DataCell(
                  Text('${newEmployee.id}'),
                ),
              DataCell(
                Text(newEmployee.firstName),
              ),
              DataCell(
                Text(newEmployee.surname),
              ),
              DataCell(
                Text(newEmployee.startDate.toString()),
              ),
              DataCell(
                Text(newEmployee.password),
              ),
              DataCell(
                Text(newEmployee.otherInfo),
              ),
              DataCell(
                Text(newEmployee.positionId.toString()),
              ),
              DataCell(
                Text(newEmployee.departmentId.toString()),
              ),
            ],
          );
        },
      ).toList(),
    );
  }
}
