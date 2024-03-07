import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinema/features/app/domain/models/department.dart';
import '../../bloc/department/department_cubit.dart';

class DepartmentsTable extends StatelessWidget {
  const DepartmentsTable({
    super.key,
    required this.departments,
    this.selectedDepartmentIndex,
    this.editable = true,
  });

  final List<Department> departments;

  final int? selectedDepartmentIndex;

  final bool editable;

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 600,
      showCheckboxColumn: false,
      columns: editable ? kDepartmentFields.map((e) => DataColumn2(label: Text(e),),).toList():
      kDepartmentFields.sublist(1).map((e) => DataColumn2(label: Text(e),),).toList(),
      rows: departments.asMap().entries.map(
            (entry) {
          final index = entry.key;
          final department = entry.value;
          return DataRow(
            selected: selectedDepartmentIndex == index,
            onSelectChanged: (selected) {
              if (selected != null && selected) {
                context.read<DepartmentCubit>().selectDepartment(index);
              }
            },
            cells: [
              if (editable)
                DataCell(
                  Text('${department.id}'),
                ),
              DataCell(
                Text(department.name),
              ),
              DataCell(
                Text(department.description),
              ),
            ],
          );
        },
      ).toList(),
    );
  }
}
