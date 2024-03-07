import 'package:cinema/features/app/domain/models/new_employee.dart';
import 'package:cinema/features/app/presentation/widgets/new_employee/my_edition_new_employee_widget.dart';
import 'package:cinema/features/app/presentation/widgets/new_employee/new_employees_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/new_employee/new_employee_cubit.dart';


class NewEmployeePage extends StatelessWidget {
  const NewEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewEmployeeCubit()..loadNewEmployees(),
      child: _NewEmployeePage(
        key: key,
      ),
    );
  }
}

class _NewEmployeePage extends StatefulWidget {
  const _NewEmployeePage({super.key});

  @override
  State<_NewEmployeePage> createState() => _NewEmployeePageState();
}

class _NewEmployeePageState extends State<_NewEmployeePage> {
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

  List<NewEmployee> filtered(List<NewEmployee> newEmployees, String? query) {
    if (query == null) return newEmployees;
    return newEmployees
        .where(
          (element) => element.firstName.toLowerCase().contains(
        query.toLowerCase(),
      ),
    )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<NewEmployeeCubit>().state;
    if (state case Success state) {
      return Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () {
                  context.read<NewEmployeeCubit>().selectNewEmployee(-1);
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
                  child: NewEmployeesTable(
                    newEmployees: filtered(state.newEmployees, _searchController.text),
                    selectedNewEmployeeIndex: state.selectedNewEmployeeIndex,
                    editable: true,
                  ),
                ),
                if (state.selectedNewEmployeeIndex != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 150.0,
                      vertical: 20,
                    ),
                    child: MyEditingNewEmployeeWidget(
                      newEmployee: state.selectedNewEmployeeIndex! >= 0 &&
                          state.selectedNewEmployeeIndex! <
                              state.newEmployees.length
                          ? state.newEmployees[state.selectedNewEmployeeIndex!]
                          : null,
                      fields: kNewEmployeeFields,
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
