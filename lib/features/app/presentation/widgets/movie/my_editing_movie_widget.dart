import 'package:cinema/features/app/domain/models/movie.dart';
import 'package:flutter/material.dart';
import '../my_form_field.dart';

class MyEditingMovieWidget extends StatefulWidget {
  const MyEditingMovieWidget({
    super.key,
    required this.fields,
    this.movie,
    this.editable=true,
  });

  final Movie? movie;
  final List<String> fields;
  final bool editable;

  @override
  State<MyEditingMovieWidget> createState() => _MyEditingMovieWidgetState();
}

class _MyEditingMovieWidgetState extends State<MyEditingMovieWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.movie == null) {
      _movie = const Movie(id: -1, duration: -1, genre: '', name: '');
    } else {
      _movie = widget.movie!;
    }
  }

  late Movie _movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyFormField(
          fieldName: widget.fields[0],
          value: widget.movie?.id,
          onChanged: (newValue) =>
              _movie = _movie.copyWith(id: int.parse(newValue)),
          editable: false,
        ),
        MyFormField(
          fieldName: widget.fields[1],
          value: widget.movie?.duration,
          onChanged: (newValue) =>
              _movie = _movie.copyWith(duration: int.parse(newValue)),
          editable: widget.editable,
        ),
        MyFormField(
          fieldName: widget.fields[2],
          value: widget.movie?.genre,
          onChanged: (newValue) => _movie = _movie.copyWith(genre: newValue),
          editable: widget.editable,
        ),
        MyFormField(
          fieldName: widget.fields[3],
          value: widget.movie?.name,
          onChanged: (newValue) => _movie = _movie.copyWith(name: newValue),
          editable: widget.editable,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
