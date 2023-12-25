import 'package:cinema/features/app/domain/models/customer.dart';
import 'package:cinema/features/app/presentation/bloc/customer/customer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/customers/customers_table.dart';
import '../../widgets/customers/my_editing_customer_widget.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerCubit()..loadCustomers(),
      child: _CustomersPage(
        key: key,
      ),
    );
  }
}

class _CustomersPage extends StatefulWidget {
  const _CustomersPage({super.key});

  @override
  State<_CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<_CustomersPage> {
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

  List<Customer> filtered(List<Customer> customers, String? query) {
    if (query == null) return customers;
    return customers
        .where(
          (element) => element.login.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CustomerCubit>().state;
    if (state case Success state) {
      return Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () {
                  context.read<CustomerCubit>().selectCustomer(-1);
                },
                child: const Icon(Icons.add),
              ),
            ),
          ),
          Column(
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
                    hintText: 'Search...',
                    icon: Icon(
                      Icons.search,
                    ),
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 400),
                child: CustomersTable(
                  customers: filtered(state.customers, _searchController.text),
                  selectedCustomerIndex: state.selectedCustomerIndex,
                ),
              ),
              if (state.selectedCustomerIndex != null)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 150.0,
                    vertical: 20,
                  ),
                  child: MyEditingCustomerWidget(
                    customer: state.selectedCustomerIndex! >= 0 &&
                            state.selectedCustomerIndex! <
                                state.customers.length
                        ? state.customers[state.selectedCustomerIndex!]
                        : null,
                    fields: kCustomerFields,
                  ),
                ),
            ],
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
