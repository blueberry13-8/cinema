import 'package:cinema/features/app/domain/models/movie.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class MoviesTable extends StatelessWidget {
  const MoviesTable({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 600,
      columns: const [
        DataColumn2(
          label: Text('ID'),
          size: ColumnSize.S,
        ),
        DataColumn(
          label: Text('Duration'),
        ),
        DataColumn(
          label: Text('Genre'),
        ),
        DataColumn(
          label: Text('Name'),
        ),
      ],
      rows: movies
          .map(
            (movie) => DataRow(
              cells: [
                DataCell(
                  Text('${movie.id}'),
                ),
                DataCell(
                  Text('${movie.duration}'),
                ),
                DataCell(
                  Text(movie.genre),
                ),
                DataCell(
                  Text(movie.name),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
