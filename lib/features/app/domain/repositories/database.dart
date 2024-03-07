import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:postgres/postgres.dart';
import '../models/department.dart';
import '../models/new_employee.dart';
import '../models/position.dart';
import '../models/salary_payment.dart';
import 'package:crypto/crypto.dart';


class Database {
  static final Database _db = Database._privateConstructor();

  Database._privateConstructor();

  // TODO: Use data for current database
  final String user = 'postgres',
      password = 'buter',
      host = 'localhost',

      database = 'hrdep';

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

  Future<bool> login(String login, String password) async {
    await connect();
    var hashedPassword = md5.convert(utf8.encode(password)).toString();
    var result = await conn!.execute(
      r'SELECT * FROM Employees WHERE employee_id=$1 and password=$2',
      parameters: [login, hashedPassword],
    );
    if (result.length == 1){
      return true;
    }
    return false;
  }

  /// Positions
  /// All methods for interactions with Positions table
  Future<List<Position>> getPositions() async {
    await connect();
    var query = 'SELECT * FROM Positions';
    final result = await conn!.execute(
      query,
    );
    List<Position> items = [];
    for (int i = 0; i < result.length; i++) {
      items.add(
        Position(
          id: result[i][0] as int,
          name: result[i][1] as String,
          description: result[i][2] as String,
          salary: result[i][3] as num,
        ),
      );
    }
    return items;
  }

  Future<void> addPosition(Position item) async {
    await connect();
    await conn!.execute(
      r'INSERT INTO Positions (name, description, salary) VALUES ($1, $2, $3)',
      parameters: [item.name, item.description, item.salary],
    );
  }

  Future<void> deletePosition(Position item) async {
    await connect();
    await conn!.execute(
      r'DELETE FROM Positions WHERE position_id=$1',
      parameters: [item.id],
    );
  }

  Future<void> updatePosition(Position item) async {
    await connect();
    await conn!.execute(
      r'UPDATE Positions SET name=$1, description=$2, salary=$3 WHERE position_id=$4',
      parameters: [item.name, item.description, item.salary, item.id],
    );
  }

  /// Departments
  /// All methods for interactions with Departments table
  Future<List<Department>> getDepartments() async {
    await connect();
    var query = 'SELECT * FROM Departments';
    final result = await conn!.execute(
      query,
    );
    List<Department> items = [];
    for (int i = 0; i < result.length; i++) {
      items.add(
        Department(
          id: result[i][0] as int,
          name: result[i][1] as String,
          description: result[i][2] as String,
        ),
      );
    }
    return items;
  }

  Future<void> addDepartment(Department item) async {
    await connect();
    await conn!.execute(
      r'INSERT INTO Departments (name, description) VALUES ($1, $2)',
      parameters: [item.name, item.description],
    );
  }

  Future<void> deleteDepartment(Department item) async {
    await connect();
    await conn!.execute(
      r'DELETE FROM Departments WHERE department_id=$1',
      parameters: [item.id],
    );
  }

  Future<void> updateDepartment(Department item) async {
    await connect();
    await conn!.execute(
      r'UPDATE departments SET name=$1, description=$2 WHERE department_id=$3',
      parameters: [item.name, item.description, item.id],
    );
  }

  /// Employees
  /// All methods for interactions with Employees table
  Future<List<NewEmployee>> getNewEmployees() async {
    await connect();
    var query = 'SELECT * FROM Employees';
    final result = await conn!.execute(
      query,
    );
    List<NewEmployee> items = [];
    for (int i = 0; i < result.length; i++) {
      items.add(
        NewEmployee(
          id: result[i][0] as int,
          firstName: result[i][1] as String,
          surname: result[i][2] as String,
          startDate: result[i][3] as DateTime,
          password: result[i][4] as String,
          otherInfo: result[i][5] as String,
          positionId: result[i][6] as int,
          departmentId: result[i][7] as int,
        ),
      );
    }
    return items;
  }

  Future<void> addNewEmployee(NewEmployee item) async {
    await connect();
    await conn!.execute(
      r'INSERT INTO Employees (first_name, surname, start_date, password, other_info, position_id, department_id) VALUES ($1, $2)',
      parameters: [
        item.firstName,
        item.surname,
        item.startDate,
        item.password,
        item.otherInfo,
        item.positionId,
        item.departmentId,
      ],
    );
  }

  Future<void> deleteNewEmployee(NewEmployee item) async {
    await connect();
    await conn!.execute(
      r'DELETE FROM Employees WHERE employee_id=$1',
      parameters: [item.id],
    );
  }

  Future<void> updateNewEmployee(NewEmployee item) async {
    await connect();
    await conn!.execute(
      r'UPDATE Employees SET first_name=$1, surname=$2, start_date=$3, password=$4, other_info=$5, position_id=$6, department_id=$7 WHERE employee_id=$8',
      parameters: [
        item.firstName,
        item.surname,
        item.startDate,
        item.password,
        item.otherInfo,
        item.positionId,
        item.departmentId,
        item.id,
      ],
    );
  }

  /// SalaryPayments
  /// All methods for interactions with Salary_Payments table
  Future<List<SalaryPayment>> getSalaryPayments({String? newEmployeeId}) async {
    await connect();
    var query = 'SELECT * FROM salary_payments';
    if (newEmployeeId != null){
      query = 'SELECT * FROM salary_payments WHERE employee_id=$newEmployeeId';
    }
    final result = await conn!.execute(
      query,
    );
    List<SalaryPayment> items = [];
    for (int i = 0; i < result.length; i++) {
      items.add(
        SalaryPayment(
          id: result[i][0] as int,
          date: result[i][1] as DateTime,
          amount: result[i][2] as num,
          employeeId: result[i][3] as int,
        ),
      );
    }
    return items;
  }

  Future<void> addSalaryPayment(SalaryPayment item) async {
    await connect();
    await conn!.execute(
      r'INSERT INTO Salary_payments (payment_date, employee_id, amount) VALUES ($1, $2, $3)',
      parameters: [item.date, item.employeeId, item.amount],
    );
  }

  Future<void> deleteSalaryPayment(SalaryPayment item) async {
    await connect();
    await conn!.execute(
      r'DELETE FROM Salary_payments WHERE payment_id=$1',
      parameters: [item.id],
    );
  }

  Future<void> updateSalaryPayment(SalaryPayment item) async {
    await connect();
    await conn!.execute(
      r'UPDATE Salary_payments SET payment_date=$1, employee_id=$2, amount=$3 WHERE payment_id=$4',
      parameters: [item.date, item.employeeId, item.amount, item.id],
    );
  }
}
