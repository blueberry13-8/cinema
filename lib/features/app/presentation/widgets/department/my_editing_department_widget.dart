import 'package:cinema/features/app/domain/models/department.dart';
import 'package:cinema/features/app/presentation/bloc/department/department_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../my_form_field.dart';

class MyEditingDepartmentTable extends StatefulWidget {
  const MyEditingDepartmentTable({
    super.key,
    required this.fields,
    this.department,
  });

  final Department? department;
  final List<String> fields;

  @override
  State<MyEditingDepartmentTable> createState() =>
      _MyEditingDepartmentTableState();
}

class _MyEditingDepartmentTableState extends State<MyEditingDepartmentTable> {
  @override
  void initState() {
    super.initState();
    if (widget.department == null) {
      _department = const Department(
        id: -1,
        name: '',
        description: '',
      );
    } else {
      _department = widget.department!;
    }
  }

  late Department _department;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyFormField(
          enabled: false,
          fieldName: widget.fields[0],
          value: widget.department?.id,
          onChanged: (newValue) =>
          _department = _department.copyWith(id: int.parse(newValue)),
          editable: false,
        ),
        MyFormField(
          enabled: false,
          fieldName: widget.fields[1],
          value: widget.department?.name,
          onChanged: (newValue) =>
          _department = _department.copyWith(name: newValue),
          editable: false,
        ),
        MyFormField(
          enabled: false,
          fieldName: widget.fields[2],
          value: widget.department?.description,
          onChanged: (newValue) =>
          _department = _department.copyWith(description: newValue),
          editable: false,
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<DepartmentCubit>().updateDepartment(
                  _department,
                  widget.department == null,
                );
              },
              child: const Text('Обновить'),
            ),
            const SizedBox(
              width: 15,
            ),
            ElevatedButton(
              onPressed: () async {
                if (widget.department != null) {
                  context.read<DepartmentCubit>().deleteDepartment(
                    widget.department!,
                  );
                }
              },
              child: const Text('Удалить'),
            ),
          ],
        ),
      ],
    );
  }
}
