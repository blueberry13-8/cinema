import 'package:cinema/features/app/domain/repositories/database.dart';
import 'package:cinema/features/app/presentation/pages/customers/customers_page.dart';
import 'package:cinema/features/app/presentation/pages/session/session_page.dart';
import 'package:cinema/features/app/presentation/pages/ticket/ticket_page.dart';
import 'package:cinema/features/app/presentation/widgets/customers/customers_table.dart';
import 'package:cinema/features/app/presentation/widgets/tickets_table.dart';
import 'package:flutter/material.dart';

import '../widgets/movie/movies_table.dart';
import '../widgets/session/sessions_table.dart';
import 'movie/movies_page.dart';

class AdminOverviewPage extends StatelessWidget {
  const AdminOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: null,
          automaticallyImplyLeading: false,
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
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 0,
          ),
          child: TabBarView(
            children: [
              const CustomersPage(),
              const MoviesPage(),
              const SessionsPage(),
              const TicketsPage(),
            ],
          ),
        ),
      ),
    );
  }
}
