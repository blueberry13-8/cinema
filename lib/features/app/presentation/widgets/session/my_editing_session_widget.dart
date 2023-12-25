import 'package:cinema/features/app/presentation/bloc/session/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/movie_session.dart';
import '../my_form_field.dart';

class MyEditingSessionWidget extends StatefulWidget {
  const MyEditingSessionWidget({
    super.key,
    required this.fields,
    this.session,
  });

  final MovieSession? session;
  final List<String> fields;

  @override
  State<MyEditingSessionWidget> createState() => _MyEditingSessionWidgetState();
}

class _MyEditingSessionWidgetState extends State<MyEditingSessionWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.session == null) {
      _session = MovieSession(id: -1, movieId: -1, hallId: -1, startTime: DateTime(1));
    } else {
      _session = widget.session!;
    }
  }

  late MovieSession _session;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyFormField(
          enabled: false,
          fieldName: widget.fields[0],
          value: widget.session?.id,
          onChanged: (newValue) =>
          _session = _session.copyWith(id: int.parse(newValue),),
        ),
        MyFormField(
          fieldName: widget.fields[1],
          value: widget.session?.movieId,
          onChanged: (newValue) =>
          _session = _session.copyWith(movieId: int.parse(newValue),),
        ),
        MyFormField(
          fieldName: widget.fields[2],
          value: widget.session?.hallId,
          onChanged: (newValue) => _session = _session.copyWith(hallId: int.parse(newValue),),
        ),
        MyFormField(
          fieldName: widget.fields[3],
          value: widget.session?.startTime,
          onChanged: (newValue) => _session = _session.copyWith(startTime: DateTime.parse(newValue),),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<SessionCubit>().updateSession(
                  _session,
                  widget.session == null,
                );
              },
              child: const Text('Обновить'),
            ),
            const SizedBox(
              width: 15,
            ),
            ElevatedButton(
              onPressed: () async {
                if (widget.session != null) {
                  context.read<SessionCubit>().deleteSession(
                    widget.session!,
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
