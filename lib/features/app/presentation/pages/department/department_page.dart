import 'package:cinema/features/app/domain/models/department.dart';
import 'package:cinema/features/app/presentation/bloc/department/department_cubit.dart';
import 'package:cinema/features/app/presentation/widgets/department/my_editing_department_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../widgets/department/department_table.dart';

class DepartmentPage extends StatelessWidget {
  const DepartmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DepartmentCubit()..loadDepartments(),
      child: _DepartmentsPage(
        key: key,
      ),
    );
  }
}

class _DepartmentsPage extends StatefulWidget {
  const _DepartmentsPage({super.key});

  @override
  State<_DepartmentsPage> createState() => _DepartmentsPageState();
}

class _DepartmentsPageState extends State<_DepartmentsPage> {
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

  List<Department> filtered(List<Department> departments, String? query) {
    if (query == null) return departments;
    return departments
        .where(
          (element) => element.name.toLowerCase().contains(
        query.toLowerCase(),
      ),
    )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DepartmentCubit>().state;
    if (state case Success state) {
      return Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () {
                  context.read<DepartmentCubit>().selectDepartment(-1);
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
                  child: DepartmentsTable(
                    departments: filtered(state.departments, _searchController.text),
                    selectedDepartmentIndex: state.selectedDepartmentIndex,
                    editable: true,
                  ),
                ),
                if (state.selectedDepartmentIndex != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 150.0,
                      vertical: 20,
                    ),
                    child: MyEditingDepartmentTable(
                      department: state.selectedDepartmentIndex! >= 0 &&
                          state.selectedDepartmentIndex! <
                              state.departments.length
                          ? state.departments[state.selectedDepartmentIndex!]
                          : null,
                      fields: kDepartmentFields,
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
