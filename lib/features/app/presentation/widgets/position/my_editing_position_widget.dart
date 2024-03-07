import 'package:cinema/features/app/domain/models/position.dart';
import 'package:cinema/features/app/presentation/bloc/position/position_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../my_form_field.dart';

class MyEditingPositionWidget extends StatefulWidget {
  const MyEditingPositionWidget({
    super.key,
    required this.fields,
    this.position,
    required this.editable,
  });

  final Position? position;
  final List<String> fields;
  final bool editable;

  @override
  State<MyEditingPositionWidget> createState() =>
      _MyEditingPositionWidgetState();
}

class _MyEditingPositionWidgetState extends State<MyEditingPositionWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.position == null) {
      _position = const Position(
        id: -1,
        name: '',
        description: '',
        salary: 0,
      );
    } else {
      _position = widget.position!;
    }
  }

  late Position _position;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyFormField(
          enabled: false,
          fieldName: widget.fields[0],
          value: widget.position?.id,
          onChanged: (newValue) =>
          _position = _position.copyWith(id: int.parse(newValue)),
          editable: widget.editable,
        ),
        MyFormField(
          enabled: widget.editable,
          fieldName: widget.fields[1],
          value: widget.position?.name,
          onChanged: (newValue) =>
          _position = _position.copyWith(name: newValue),
          editable: widget.editable,
        ),
        MyFormField(
          enabled: widget.editable,
          fieldName: widget.fields[2],
          value: widget.position?.description,
          onChanged: (newValue) =>
          _position = _position.copyWith(description: newValue),
          editable: widget.editable,
        ),
        MyFormField(
          enabled: widget.editable,
          fieldName: widget.fields[3],
          value: widget.position?.salary,
          onChanged: (newValue) =>
          _position = _position.copyWith(salary: num.parse(newValue)),
          editable: widget.editable,
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                if (widget.editable) {
                  context.read<PositionCubit>().updatePosition(
                        _position,
                        widget.position == null,
                      );
                }
              },
              child: const Text('Обновить'),
            ),
            const SizedBox(
              width: 15,
            ),
            ElevatedButton(
              onPressed: () async {
                if (widget.editable && widget.position != null) {
                  context.read<PositionCubit>().deletePosition(
                    widget.position!,
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
