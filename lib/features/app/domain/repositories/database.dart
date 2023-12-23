import 'package:cinema/features/app/domain/models/movie.dart';
import 'package:logger/logger.dart';
import 'package:postgres/postgres.dart';
import '../models/customer.dart';
import '../models/employee.dart';
import '../models/hall.dart';
import '../models/movie_session.dart';
import '../models/ticket.dart';

class Database {
  static final Database _db = Database._privateConstructor();

  Database._privateConstructor();

  final String user = 'postgres',
      password = 'buter',
      host = 'localhost',
      database = 'cinema';

  Connection? conn;
  var logger = Logger();

  factory Database() {
    return _db;
  }

  Future<Connection> connect() async {
    if (this.conn != null) {
      logger.i("Connected to DB");
      return this.conn!;
    }
    logger.i("Starting connection to DB");
    final conn = await Connection.open(
      Endpoint(
        host: host,
        database: database,
        username: user,
        password: password,
      ),
      settings: const ConnectionSettings(sslMode: SslMode.disable),
    );
    logger.i('Connected to DB');
    this.conn = conn;
    return conn;
  }

  Future<List<Movie>> getMovies() async {
    await connect();
    final result = await conn!.execute(
      'SELECT * FROM Movie',
    );
    List<Movie> items = [];
    for (int i = 0; i < result.length; i++) {
      items.add(
        Movie(
          id: result[i][0] as int,
          duration: result[i][1] as int,
          genre: result[i][2] as String,
          name: result[i][3] as String,
        ),
      );
    }
    return items;
  }

  Future<List<Hall>> getHalls() async {
    await connect();
    final result = await conn!.execute(
      'SELECT * FROM Hall',
    );
    List<Hall> items = [];
    for (int i = 0; i < result.length; i++) {
      items.add(
        Hall(
          id: result[i][0] as int,
          type: result[i][1] as String,
          seatsNumber: result[i][2] as int,
        ),
      );
    }
    return items;
  }

  Future<List<MovieSession>> getSessions() async {
    await connect();
    final result = await conn!.execute(
      'SELECT * FROM Session',
    );
    List<MovieSession> items = [];
    for (int i = 0; i < result.length; i++) {
      items.add(
        MovieSession(
          id: result[i][0] as int,
          movieId: result[i][2] as int,
          hallId: result[i][3] as int,
          startTime: result[i][1] as DateTime,
        ),
      );
    }
    return items;
  }

  Future<List<Customer>> getCustomers() async {
    await connect();
    final result = await conn!.execute(
      'SELECT * FROM Customer',
    );
    List<Customer> items = [];
    for (int i = 0; i < result.length; i++) {
      items.add(
        Customer(
          id: result[i][0] as int,
          login: result[i][1] as String,
          password: result[i][2] as String,
        ),
      );
    }
    return items;
  }

  Future<List<Ticket>> getTickets() async {
    await connect();
    final result = await conn!.execute(
      'SELECT * FROM Ticket',
    );
    List<Ticket> items = [];
    for (int i = 0; i < result.length; i++) {
      items.add(
        Ticket(
          id: result[i][0] as int,
          seatNumber: result[i][1] as int,
          rowNumber: result[i][2] as int,
          price: double.parse(result[i][3] as String),
          sessionId: result[i][4] as int,
          customerId: result[i][5] as int,
        ),
      );
    }
    return items;
  }

  Future<List<Employee>> getEmployees() async {
    await connect();
    final result = await conn!.execute(
      'SELECT * FROM Employee',
    );
    List<Employee> items = [];
    for (int i = 0; i < result.length; i++) {
      items.add(
        Employee(
          id: result[i][0] as int,
          name: result[i][1] as String,
          position: result[i][2] as String,
          salary: num.parse(result[i][3] as String),
        ),
      );
    }
    return items;
  }
}
