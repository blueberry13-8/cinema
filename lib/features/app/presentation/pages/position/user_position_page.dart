import 'package:cinema/features/app/domain/models/position.dart';
import 'package:cinema/features/app/presentation/bloc/position/position_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/position/positions_table.dart';
import '../../widgets/position/my_editing_position_widget.dart';

class UserPositionsPage extends StatelessWidget {
  const UserPositionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PositionCubit()..loadPositions(),
      child: _PositionsPage(
        key: key,
      ),
    );
  }
}

class _PositionsPage extends StatefulWidget {
  const _PositionsPage({super.key});

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
      return SingleChildScrollView(
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
                positions: filtered(state.positions, _searchController.text),
                selectedPositionIndex: state.selectedPositionIndex,
                editable: false,
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
                ),
              ),
          ],
        ),
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

