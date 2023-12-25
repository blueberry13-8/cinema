import 'package:cinema/features/app/presentation/pages/session/user_session_page.dart';
import 'package:cinema/features/app/presentation/pages/ticket/user_ticket_page.dart';
import 'package:flutter/material.dart';
import 'movie/user_movies_page.dart';

class UserOverviewPage extends StatelessWidget {
  const UserOverviewPage({super.key});

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
        body: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 0,
          ),
          child: TabBarView(
            children: [
              UserMoviesPage(),
              UserSessionsPage(),
              UserTicketsPage(),
            ],
          ),
        ),
      ),
    );
  }
}
