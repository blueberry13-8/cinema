import 'package:cinema/features/app/domain/models/customer.dart';
import 'package:cinema/features/app/presentation/bloc/customer/customer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../my_form_field.dart';

class MyEditingCustomerWidget extends StatefulWidget {
  const MyEditingCustomerWidget({
    super.key,
    required this.fields,
    this.customer,
  });

  final Customer? customer;
  final List<String> fields;

  @override
  State<MyEditingCustomerWidget> createState() =>
      _MyEditingCustomerWidgetState();
}

class _MyEditingCustomerWidgetState extends State<MyEditingCustomerWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.customer == null) {
      _customer = const Customer(id: -1, login: '', password: '');
    } else {
      _customer = widget.customer!;
    }
  }

  late Customer _customer;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyFormField(
          fieldName: widget.fields[0],
          value: widget.customer?.id,
          onChanged: (newValue) =>
              _customer = _customer.copyWith(id: int.parse(newValue)),
        ),
        MyFormField(
          fieldName: widget.fields[1],
          value: widget.customer?.login,
          onChanged: (newValue) =>
              _customer = _customer.copyWith(login: newValue),
        ),
        MyFormField(
          fieldName: widget.fields[2],
          value: widget.customer?.password,
          onChanged: (newValue) =>
              _customer = _customer.copyWith(password: newValue),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<CustomerCubit>().updateCustomer(
                      _customer,
                      widget.customer == null,
                    );
              },
              child: const Text('Обновить'),
            ),
            const SizedBox(
              width: 15,
            ),
            ElevatedButton(
              onPressed: () async {
                if (widget.customer != null) {
                  context.read<CustomerCubit>().deleteCustomer(
                        widget.customer!,
                      );
                }
              },
              child: const Text('Удалить'),
            ),
          ],
        ),
      ],
    );
  }
}
