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

class _CustomersPage extends StatelessWidget {
  const _CustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CustomerCubit>().state;
    if (state case Success state) {
      return Stack(
        children: [
          CustomersTable(
            customers: state.customers,
            selectedCustomerIndex: state.selectedCustomerIndex,
          ),
          if (state.selectedCustomerIndex != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 150.0,
                  vertical: 20,
                ),
                child: MyEditingCustomerWidget(
                  customer: state.selectedCustomerIndex! >= 0 &&
                          state.selectedCustomerIndex! < state.customers.length
                      ? state.customers[state.selectedCustomerIndex!]
                      : null,
                  fields: kCustomerFields,
                ),
              ),
            ),
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
