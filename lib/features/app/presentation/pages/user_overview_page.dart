import 'package:cinema/features/app/presentation/pages/department/department_page.dart';
import 'package:cinema/features/app/presentation/pages/position/position_page.dart';
import 'package:cinema/features/app/presentation/pages/position/user_position_page.dart';
import 'package:cinema/features/app/presentation/pages/salary_payment/salary_payments_page.dart';
import 'package:cinema/features/app/presentation/pages/salary_payment/user_salary_payments_page.dart';
import 'package:flutter/material.dart';

import 'department/user_department_page.dart';

class UserOverviewPage extends StatelessWidget {
  const UserOverviewPage({super.key, required this.login});

  final String login;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabAlignment: TabAlignment.center,
            tabs: [
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
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 0,
          ),
          child: TabBarView(
            children: [
              const UserDepartmentPage(),
              const UserPositionsPage(),
              UserSalaryPaymentsPage(employeeId: login),
              //UserTicketsPage(login: login),
            ],
          ),
        ),
      ),
    );
  }
}
