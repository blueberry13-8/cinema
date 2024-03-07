import 'package:cinema/features/app/domain/models/position.dart';
import 'package:cinema/features/app/presentation/bloc/position/position_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/position/positions_table.dart';
import '../widgets/position/my_editing_position_widget.dart';

class PositionsPage extends StatelessWidget {
  const PositionsPage({
    super.key,
    required this.editable,
  });

  final bool editable;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PositionCubit()..loadPositions(),
      child: _PositionsPage(
        key: key,
        editable: editable,
      ),
    );
  }
}

class _PositionsPage extends StatefulWidget {
  const _PositionsPage({super.key, required this.editable});

  final bool editable;

  @override
  State<_PositionsPage> createState() => _PositionsPageState();
}

class _PositionsPageState extends State<_PositionsPage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Position> filtered(List<Position> positions, String? query) {
    if (query == null) return positions;
    return positions
        .where(
          (element) => element.name.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PositionCubit>().state;
    if (state case Success state) {
      return Stack(
        children: [
          if (widget.editable)
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  onPressed: () {
                    context.read<PositionCubit>().selectPosition(-1);
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 80.0,
                    vertical: 10,
                  ),
                  child: TextFormField(
                    controller: _searchController,
                    onChanged: (newValue) => setState(() {}),
                    decoration: const InputDecoration(
                      hintText: 'Поиск...',
                      icon: Icon(
                        Icons.search,
                      ),
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 400),
                  child: PositionsTable(
                    positions:
                        filtered(state.positions, _searchController.text),
                    selectedPositionIndex: state.selectedPositionIndex,
                    editable: widget.editable,
                  ),
                ),
                if (state.selectedPositionIndex != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 150.0,
                      vertical: 20,
                    ),
                    child: MyEditingPositionWidget(
                      position: state.selectedPositionIndex! >= 0 &&
                              state.selectedPositionIndex! <
                                  state.positions.length
                          ? state.positions[state.selectedPositionIndex!]
                          : null,
                      fields: kPositionFields,
                      editable: widget.editable,
                    ),
                  ),
              ],
            ),
          ),
        ],
      );
    } else if (state case Loading || Initial) {
      return const CircularProgressIndicator();
    } else {
      return const Center(
        child: Text('Error'),
      );
    }
  }
}
