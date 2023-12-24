import 'package:cinema/features/app/domain/models/movie.dart';
import 'package:flutter/material.dart';

import 'my_form_field.dart';

class MyEditingMovieWidget extends StatefulWidget {
  const MyEditingMovieWidget({super.key, required this.movie});

  final Movie movie;

  @override
  State<MyEditingMovieWidget> createState() => _MyEditingMovieWidgetState();
}

class _MyEditingMovieWidgetState extends State<MyEditingMovieWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyFormField(fieldName: 'ID', value: widget.movie.id),
        MyFormField(fieldName: 'Duration', value: widget.movie.duration),
        MyFormField(fieldName: 'Genre', value: widget.movie.genre),
        MyFormField(fieldName: 'Name', value: widget.movie.name),
        const SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Обновить'),
            ),
            const SizedBox(width: 15,),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Удалить'),
            ),
          ],
        ),
      ],
    );
  }
}
