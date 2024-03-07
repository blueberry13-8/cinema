import 'package:cinema/features/app/domain/models/salary_payment.dart';
import 'package:cinema/features/app/presentation/bloc/salary_payment/salary_payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../my_form_field.dart';

class MyEditingSalaryPaymentWidget extends StatefulWidget {
  const MyEditingSalaryPaymentWidget({
    super.key,
    required this.fields,
    this.salaryPayment,
  });

  final SalaryPayment? salaryPayment;
  final List<String> fields;

  @override
  State<MyEditingSalaryPaymentWidget> createState() => _MyEditingSalaryPaymentWidgetState();
}

class _MyEditingSalaryPaymentWidgetState extends State<MyEditingSalaryPaymentWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.salaryPayment == null) {
      _salaryPayment = SalaryPayment(id: -1, date: DateTime.now(), amount: 0, employeeId: 0);
    } else {
      _salaryPayment = widget.salaryPayment!;
    }
  }

  late SalaryPayment _salaryPayment;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyFormField(
          enabled: false,
          fieldName: widget.fields[0],
          value: widget.salaryPayment?.id,
          onChanged: (newValue) =>
          _salaryPayment = _salaryPayment.copyWith(id: int.parse(newValue)),
          editable: false,
        ),
        MyFormField(
          enabled: false,
          fieldName: widget.fields[1],
          value: widget.salaryPayment?.date,
          onChanged: (newValue) =>
          _salaryPayment = _salaryPayment.copyWith(date: DateTime.parse(newValue)),
          editable: false,
        ),
        MyFormField(
          enabled: false,
          fieldName: widget.fields[2],
          value: widget.salaryPayment?.amount,
          onChanged: (newValue) =>
          _salaryPayment = _salaryPayment.copyWith(amount: num.parse(newValue)),
          editable: false,
        ),
        MyFormField(
          enabled: false,
          fieldName: widget.fields[3],
          value: widget.salaryPayment?.employeeId,
          onChanged: (newValue) =>
          _salaryPayment = _salaryPayment.copyWith(employeeId: int.parse(newValue)),
          editable: false,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<SalaryPaymentCubit>().updateSalaryPayment(
                  _salaryPayment,
                  widget.salaryPayment == null,
                );
              },
              child: const Text('Обновить'),
            ),
            const SizedBox(
              width: 15,
            ),
            ElevatedButton(
              onPressed: () async {
                if (widget.salaryPayment != null) {
                  context.read<SalaryPaymentCubit>().deleteSalaryPayment(
                    widget.salaryPayment!,
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
