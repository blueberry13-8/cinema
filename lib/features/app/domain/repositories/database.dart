import 'dart:convert';

import 'package:cinema/features/app/domain/models/movie.dart';
import 'package:logger/logger.dart';
import 'package:postgres/postgres.dart';
import '../models/customer.dart';
import '../models/employee.dart';
import '../models/hall.dart';
import '../models/movie_session.dart';
import '../models/ticket.dart';
import 'package:crypto/crypto.dart';

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
      // logger.i("Connected to DB");
      return this.conn!;
    }
    // logger.i("Starting connection to DB");
    final conn = await Connection.open(
      Endpoint(
        host: host,
        database: database,
        username: user,
        password: password,
      ),
      settings: const ConnectionSettings(sslMode: SslMode.disable),
    );
    // logger.i('Connected to DB');
    this.conn = conn;
    return conn;
  }

  Future<List<Movie>> getMovies() async {
    await connect();
    var query = 'SELECT * FROM Movie';
    final result = await conn!.execute(
      query,
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

  Future<void> addMovie(Movie item) async {
    await connect();
    await conn!.execute(
      r'INSERT INTO Movie (duration, genre, name) VALUES ($1, $2, $3)',
      parameters: [item.duration, item.genre, item.name],
    );
  }

  Future<void> deleteMovie(Movie item) async {
    await connect();
    await conn!.execute(
      r'DELETE FROM Movie WHERE id=$1',
      parameters: [item.id],
    );
  }

  Future<void> updateMovie(Movie item) async {
    await connect();
    await conn!.execute(
      r'UPDATE Movie SET name=$1, duration=$2, genre=$3 WHERE id=$4',
      parameters: [item.name, item.duration, item.genre, item.id],
    );
  }

  Future<void> addHall(Hall item) async {
    await connect();
    await conn!.execute(
      r'INSERT INTO Hall (type, seats_number) VALUES ($1, $2)',
      parameters: [item.type, item.seatsNumber],
    );
  }

  Future<void> deleteHall(Hall item) async {
    await connect();
    await conn!.execute(
      r'DELETE  FROM Hall WHERE id=$1',
      parameters: [item.id],
    );
  }

  Future<void> updateHall(Hall item) async {
    await connect();
    await conn!.execute(
      r'UPDATE Hall SET type=$1, seats_number=$2 WHERE id=$3',
      parameters: [item.type, item.seatsNumber, item.id],
    );
  }

  Future<void> addSession(MovieSession item) async {
    await connect();
    await conn!.execute(
      r'INSERT INTO Session (start_time, movie_id, hall_id) VALUES ($1, $2, $3)',
      parameters: [item.startTime, item.movieId, item.hallId],
    );
  }

  Future<void> deleteSession(MovieSession item) async {
    await connect();
    await conn!.execute(
      r'DELETE  FROM Session WHERE id=$1',
      parameters: [item.id],
    );
  }

  Future<void> updateSession(MovieSession item) async {
    await connect();
    await conn!.execute(
      r'UPDATE Session SET start_time=$1, movie_id=$2, hall_id=$3 WHERE id=$4',
      parameters: [item.startTime, item.movieId, item.hallId, item.id],
    );
  }

  Future<void> addCustomer(Customer item) async {
    await connect();
    await conn!.execute(
      r'INSERT INTO Customer (login, password) VALUES ($1, $2)',
      parameters: [item.login, md5.convert(utf8.encode(item.password)).toString()],
    );
  }

  Future<void> deleteCustomer(Customer item) async {
    await connect();
    await conn!.execute(
      r'DELETE  FROM Customer WHERE id=$1',
      parameters: [item.id],
    );
  }

  Future<void> updateCustomer(Customer item) async {
    await connect();
    await conn!.execute(
      r'UPDATE Customer SET login=$1, password=$2 WHERE id=$3',
      parameters: [item.login, item.password, item.id],
    );
  }

  Future<void> addEmployee(Employee item) async {
    await connect();
    await conn!.execute(
      r'INSERT INTO Employee (name, position, salary) VALUES ($1, $2, $3)',
      parameters: [item.name, item.position, item.salary],
    );
  }

  Future<void> deleteEmployee(Employee item) async {
    await connect();
    await conn!.execute(
      r'DELETE  FROM Employee WHERE id=$1',
      parameters: [item.id],
    );
  }

  Future<void> updateEmployee(Employee item) async {
    await connect();
    await conn!.execute(
      r'UPDATE Employee SET name=$1, position=$2, salary=$3 WHERE id=$4',
      parameters: [item.name, item.position, item.salary, item.id],
    );
  }

  Future<void> addTicket(Ticket item) async {
    await connect();
    await conn!.execute(
      r'INSERT INTO Ticket (seat_number, row_number, price, session_id, customer_id) VALUES ($1, $2, $3, $4, $5)',
      parameters: [item.seatNumber, item.rowNumber, item.price, item.sessionId, item.customerId],
    );
  }

  Future<void> deleteTicket(Ticket item) async {
    await connect();
    await conn!.execute(
      r'DELETE  FROM Ticket WHERE id=$1',
      parameters: [item.id],
    );
  }

  Future<void> updateTicket(Ticket item) async {
    await connect();
    await conn!.execute(
      r'UPDATE Ticket SET seat_number=$1, row_number=$2, price=$3, session_id=$4, customer_id=$5 WHERE id=$6',
      parameters: [item.seatNumber, item.rowNumber, item.price, item.sessionId, item.customerId, item.id],
    );
  }

  Future<bool> login(String login, String password) async {
    await connect();
    var hashedPassword = md5.convert(utf8.encode(password)).toString();
    var result = await conn!.execute(
      r'SELECT * FROM Customer WHERE login=$1 and password=$2',
      parameters: [login, hashedPassword],
    );
    if (result.length == 1){
      return true;
    }
    return false;
  }

  Future<List<Ticket>> getUserTickets(String login) async{
    await connect();
    var result = await conn!.execute(
      r'SELECT * FROM Customer WHERE login=$1',
      parameters: [login]
    );
    int id = result.first[0] as int;
    result = await conn!.execute(
        r'SELECT * FROM Ticket WHERE customer_id=$1',
        parameters: [id]
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
}
