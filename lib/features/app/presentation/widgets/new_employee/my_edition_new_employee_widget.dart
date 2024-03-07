import 'dart:convert';
import 'package:cinema/features/app/domain/models/new_employee.dart';
import 'package:cinema/features/app/presentation/bloc/new_employee/new_employee_cubit.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../my_form_field.dart';

class MyEditingNewEmployeeWidget extends StatefulWidget {
  const MyEditingNewEmployeeWidget({
    super.key,
    required this.fields,
    this.newEmployee,
  });

  final NewEmployee? newEmployee;
  final List<String> fields;

  @override
  State<MyEditingNewEmployeeWidget> createState() =>
      _MyEditingNewEmployeeWidgetState();
}

class _MyEditingNewEmployeeWidgetState
    extends State<MyEditingNewEmployeeWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.newEmployee == null) {
      _newEmployee = NewEmployee(
        id: -1,
        firstName: '',
        surname: '',
        startDate: DateTime.now(),
        password: '',
        otherInfo: '',
        positionId: 0,
        departmentId: 0,
      );
    } else {
      _newEmployee = widget.newEmployee!;
    }
  }

  late NewEmployee _newEmployee;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyFormField(
          enabled: false,
          fieldName: widget.fields[0],
          value: widget.newEmployee?.id,
          onChanged: (newValue) =>
              _newEmployee = _newEmployee.copyWith(id: int.parse(newValue)),
          editable: false,
        ),
        MyFormField(
          enabled: false,
          fieldName: widget.fields[1],
          value: widget.newEmployee?.firstName,
          onChanged: (newValue) =>
              _newEmployee = _newEmployee.copyWith(firstName: newValue),
          editable: false,
        ),
        MyFormField(
          enabled: false,
          fieldName: widget.fields[2],
          value: widget.newEmployee?.surname,
          onChanged: (newValue) =>
              _newEmployee = _newEmployee.copyWith(surname: newValue),
          editable: false,
        ),
        MyFormField(
          enabled: false,
          fieldName: widget.fields[3],
          value: widget.newEmployee?.startDate,
          onChanged: (newValue) => _newEmployee = _newEmployee.copyWith(
              startDate: DateTime.parse(
            newValue,
          )),
          editable: false,
        ),
        MyFormField(
          enabled: false,
          fieldName: widget.fields[4],
          value: widget.newEmployee?.password,
          onChanged: (newValue) =>
          _newEmployee = _newEmployee.copyWith(password: md5.convert(utf8.encode(newValue)).toString()),
          // TODO: HASHING
          editable: false,
        ),
        MyFormField(
          enabled: false,
          fieldName: widget.fields[5],
          value: widget.newEmployee?.otherInfo,
          onChanged: (newValue) =>
          _newEmployee = _newEmployee.copyWith(otherInfo: newValue),
          editable: false,
        ),
        MyFormField(
          enabled: false,
          fieldName: widget.fields[6],
          value: widget.newEmployee?.positionId,
          onChanged: (newValue) =>
          _newEmployee = _newEmployee.copyWith(positionId: int.parse(newValue)),
          editable: false,
        ),
        MyFormField(
          enabled: false,
          fieldName: widget.fields[7],
          value: widget.newEmployee?.departmentId,
          onChanged: (newValue) =>
          _newEmployee = _newEmployee.copyWith(departmentId: int.parse(newValue)),
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
                context.read<NewEmployeeCubit>().updateNewEmployee(
                      _newEmployee,
                      widget.newEmployee == null,
                    );
              },
              child: const Text('Обновить'),
            ),
            const SizedBox(
              width: 15,
            ),
            ElevatedButton(
              onPressed: () async {
                if (widget.newEmployee != null) {
                  context.read<NewEmployeeCubit>().deleteNewEmployee(
                        widget.newEmployee!,
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
