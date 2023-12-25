import 'package:cinema/features/app/domain/repositories/database.dart';
import 'package:cinema/features/app/presentation/widgets/tickets_table.dart';
import 'package:flutter/material.dart';

import '../widgets/movie/movies_table.dart';
import '../widgets/session/sessions_table.dart';

class UserOverviewPage extends StatelessWidget {
  const UserOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: null,
          automaticallyImplyLeading: false,
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
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 150,
            vertical: 100,
          ),
          child: TabBarView(
            children: [
              FutureBuilder(
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? MoviesTable(
                    movies: snapshot.requireData,
                  )
                      : const CircularProgressIndicator();
                },
                future: Database().getMovies(),
              ),
              FutureBuilder(
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? SessionsTable(
                    sessions: snapshot.requireData,
                  )
                      : const CircularProgressIndicator();
                },
                future: Database().getSessions(),
              ),
              FutureBuilder(
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? TicketsTable(
                    tickets: snapshot.requireData,
                  )
                      : const CircularProgressIndicator();
                },
                future: Database().getTickets(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
