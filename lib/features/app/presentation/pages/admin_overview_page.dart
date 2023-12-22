import 'package:cinema/features/app/presentation/widgets/users_table.dart';
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
                child: Text('Пользователи'),
              ),
              Tab(
                child: Text('Фильмы'),
              ),
              Tab(
                child: Text('Сеансы'),
              ),
              Tab(
                child: Text('Билеты'),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(150.0),
              child: UsersTable(),
            ),
            const Text('2'),
            const Text('3'),
            const Text('4'),
          ],
        ),
      ),
    );
  }
}
