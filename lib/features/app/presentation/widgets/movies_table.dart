import 'package:cinema/features/app/domain/models/movie.dart';
import 'package:cinema/features/app/presentation/widgets/my_editing_widget.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class MoviesTable extends StatefulWidget {
  const MoviesTable({super.key, required this.movies});

  final List<Movie> movies;

  @override
  State<MoviesTable> createState() => _MoviesTableState();
}

class _MoviesTableState extends State<MoviesTable> {
  int? selectedMovieIndex;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DataTable2(
          columnSpacing: 12,
          horizontalMargin: 12,
          minWidth: 600,
          showCheckboxColumn: false,
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
          rows: widget.movies.asMap().entries.map(
            (entry) {
              final index = entry.key;
              final movie = entry.value;
              return DataRow(
                selected: selectedMovieIndex == index,
                onSelectChanged: (selected) {
                  if (selected != null && selected) {
                    selectedMovieIndex = index;
                    setState(() {});
                  }
                },
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
              );
            },
          ).toList(),
        ),
        if (selectedMovieIndex != null)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 58.0),
              child: MyEditingMovieWidget(
                movie: widget.movies[selectedMovieIndex!],
              ),
            ),
          ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () {
                print(selectedMovieIndex);
              },
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }
}
