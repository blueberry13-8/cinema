import 'package:cinema/features/app/domain/models/customer.dart';
import 'package:cinema/features/app/domain/models/movie.dart';
import 'package:cinema/features/app/domain/models/session.dart';
import 'package:cinema/features/app/domain/models/ticket.dart';
import 'package:cinema/features/app/presentation/widgets/customers_table.dart';
import 'package:cinema/features/app/presentation/widgets/data_table_example.dart';
import 'package:cinema/features/app/presentation/widgets/sessions_table.dart';
import 'package:cinema/features/app/presentation/widgets/tickets_table.dart';
import 'package:flutter/material.dart';

import '../widgets/movies_table.dart';

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
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 150,
            vertical: 100,
          ),
          child: TabBarView(
            children: [
              // const DataTableExample(),
              const CustomersTable(
                customers: [
                  Customer(id: 1, login: 'customer1', password: 'password1'),
                  Customer(id: 2, login: 'customer2', password: 'password2'),
                  Customer(id: 3, login: 'customer3', password: 'password3'),
                  Customer(id: 4, login: 'customer4', password: 'password4'),
                  Customer(id: 5, login: 'customer5', password: 'password5'),
                ],
              ),
              const MoviesTable(
                movies: [
                  Movie(
                      id: 1, duration: 1234532134, genre: 'Horror', name: 'It'),
                  Movie(
                      id: 2, duration: 1234532134, genre: 'Horror', name: 'It'),
                  Movie(
                      id: 3, duration: 1234532134, genre: 'Horror', name: 'It'),
                  Movie(
                      id: 4, duration: 1234532134, genre: 'Horror', name: 'It'),
                  Movie(
                      id: 5, duration: 1234532134, genre: 'Horror', name: 'It'),
                ],
              ),
              SessionsTable(
                sessions: [
                  Session(
                    id: 1,
                    movieId: 1,
                    hallId: 2,
                    startTime: DateTime.now(),
                  ),
                  Session(
                    id: 2,
                    movieId: 2,
                    hallId: 1,
                    startTime: DateTime.now(),
                  ),
                  Session(
                    id: 3,
                    movieId: 3,
                    hallId: 3,
                    startTime: DateTime.now(),
                  ),
                  Session(
                    id: 4,
                    movieId: 3,
                    hallId: 3,
                    startTime: DateTime.now(),
                  ),
                ],
              ),
              const TicketsTable(
                tickets: [
                  Ticket(
                    id: 1,
                    seatNumber: 1,
                    rowNumber: 1,
                    price: 120.0,
                    sessionId: 1,
                    customerId: 2,
                  ),
                  Ticket(
                    id: 2,
                    seatNumber: 1,
                    rowNumber: 1,
                    price: 120.0,
                    sessionId: 1,
                    customerId: 2,
                  ),
                  Ticket(
                    id: 3,
                    seatNumber: 1,
                    rowNumber: 1,
                    price: 120.0,
                    sessionId: 1,
                    customerId: 2,
                  ),
                  Ticket(
                    id: 4,
                    seatNumber: 1,
                    rowNumber: 1,
                    price: 120.0,
                    sessionId: 1,
                    customerId: 2,
                  ),
                  Ticket(
                    id: 5,
                    seatNumber: 1,
                    rowNumber: 1,
                    price: 120.0,
                    sessionId: 1,
                    customerId: 2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
