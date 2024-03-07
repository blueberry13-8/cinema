import 'package:cinema/features/app/presentation/pages/department/department_page.dart';
import 'package:cinema/features/app/presentation/pages/new_employee/new_employee_page.dart';
import 'package:cinema/features/app/presentation/pages/position/position_page.dart';
import 'package:cinema/features/app/presentation/pages/salary_payment/salary_payments_page.dart';
import 'package:flutter/material.dart';

class AdminOverviewPage extends StatelessWidget {
  const AdminOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabAlignment: TabAlignment.center,
            tabs: [
              Tab(
                child: Text('Работники'),
              ),
              Tab(
                child: Text('Отделы'),
              ),
              Tab(
                child: Text('Должности'),
              ),
              Tab(
                child: Text('Выплаты'),
              ),
            ],
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 0,
          ),
          child: TabBarView(
            children: [
              NewEmployeePage(),
              DepartmentPage(),
              PositionsPage(),
              SalaryPaymentsPage(),
            ],
          ),
        ),
      ),
    );
  }
}
