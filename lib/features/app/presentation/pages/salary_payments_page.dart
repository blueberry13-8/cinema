import 'package:cinema/features/app/domain/models/salary_payment.dart';
import 'package:cinema/features/app/presentation/bloc/salary_payment/salary_payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/salary_payment/salary_payments_table.dart';
import '../widgets/salary_payment/my_editing_salary_payment_widget.dart';

class SalaryPaymentsPage extends StatelessWidget {
  const SalaryPaymentsPage({
    super.key,
    required this.editable,
    required this.employeeId,
  });

  final String? employeeId;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SalaryPaymentCubit()..loadSalaryPayments(newEmployeeId: employeeId),
      child: _SalaryPaymentsPage(
        key: key,
        editable: editable,
      ),
    );
  }
}

class _SalaryPaymentsPage extends StatefulWidget {
  const _SalaryPaymentsPage({super.key, required this.editable});

  final bool editable;

  @override
  State<_SalaryPaymentsPage> createState() => _SalaryPaymentsPageState();
}

class _SalaryPaymentsPageState extends State<_SalaryPaymentsPage> {
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

  List<SalaryPayment> filtered(
      List<SalaryPayment> salaryPayments, String? query) {
    if (query == null) return salaryPayments;
    return salaryPayments
        .where(
          (element) => element.date.toString().toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SalaryPaymentCubit>().state;
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
                    context.read<SalaryPaymentCubit>().selectSalaryPayment(-1);
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
                  child: SalaryPaymentsTable(
                    salaryPayments:
                        filtered(state.salaryPayments, _searchController.text),
                    selectedSalaryPaymentIndex:
                        state.selectedSalaryPaymentIndex,
                    editable: widget.editable,
                  ),
                ),
                if (state.selectedSalaryPaymentIndex != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 150.0,
                      vertical: 20,
                    ),
                    child: MyEditingSalaryPaymentWidget(
                      salaryPayment: state.selectedSalaryPaymentIndex! >= 0 &&
                              state.selectedSalaryPaymentIndex! <
                                  state.salaryPayments.length
                          ? state
                              .salaryPayments[state.selectedSalaryPaymentIndex!]
                          : null,
                      fields: kSalaryPaymentFields,
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
