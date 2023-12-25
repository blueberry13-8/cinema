import 'package:cinema/features/app/domain/models/movie.dart';
import 'package:cinema/features/app/presentation/bloc/movie_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'my_form_field.dart';

class MyEditingMovieWidget extends StatefulWidget {
  const MyEditingMovieWidget({
    super.key,
    this.movie,
  });

  final Movie? movie;

  @override
  State<MyEditingMovieWidget> createState() => _MyEditingMovieWidgetState();
}

class _MyEditingMovieWidgetState extends State<MyEditingMovieWidget> {
  Map<String, String> _fields = Map.fromEntries(
    const Movie(id: 1, duration: 1, genre: '', name: '').toJson().entries.map(
          (e) => MapEntry(
            e.key,
            '',
          ),
        ),
  );

  @override
  void initState() {
    super.initState();
    if (widget.movie != null) {
      _fields = widget.movie!.toJson().map(
            (key, value) => MapEntry(
              key,
              value.toString(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ..._fields.entries
            .map(
              (entry) => MyFormField(
                fieldName: entry.key.toUpperCase(),
                value: entry.value,
                onChanged: (newValue) => _fields[entry.key] = newValue,
              ),
            )
            .toList(),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<MovieCubit>().updateMovie2(
                      _fields,
                      widget.movie == null,
                    );
              },
              child: const Text('Обновить'),
            ),
            const SizedBox(
              width: 15,
            ),
            ElevatedButton(
              onPressed: () async {
                context.read<MovieCubit>().deleteMovie(
                      Movie(
                        id: int.parse(_fields['id']!),
                        duration: -1,
                        genre: 'asda',
                        name: 'asdsdf',
                      ),
                    );
              },
              child: const Text('Удалить'),
            ),
          ],
        ),
      ],
    );
  }
}
