-- Create Cinema Database
CREATE DATABASE cinema;
\c cinema;

-- Create Movie Table
CREATE TABLE Movie (
    id SERIAL PRIMARY KEY,
    duration INT,
    genre VARCHAR(255),
    name VARCHAR(255)
);

-- Create Session Table
CREATE TABLE Session (
    id SERIAL PRIMARY KEY,
    start_time TIMESTAMP,
    movie_id INT REFERENCES Movie(id),
    hall_id INT REFERENCES Hall(id)
);

-- Create Hall Table
CREATE TABLE Hall (
    id SERIAL PRIMARY KEY,
    type VARCHAR(255),
    seats_number INT
);

-- Create Ticket Table
CREATE TABLE Ticket (
    id SERIAL PRIMARY KEY,
    seat_number INT,
    row_number INT,
    price DECIMAL(10, 2),
    session_id INT REFERENCES Session(id),
    customer_id INT REFERENCES Customer(id)
);

-- Create Employee Table
CREATE TABLE Employee (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    position VARCHAR(255),
    salary DECIMAL(10, 2)
);

-- Create Customer Table
CREATE TABLE Customer (
    id SERIAL PRIMARY KEY,
    login VARCHAR(255),
    password VARCHAR(255)
);

-- Create Ternary Relationship Table
CREATE TABLE Employee_Customer_Ticket (
    employee_id INT REFERENCES Employee(id),
    customer_id INT REFERENCES Customer(id),
    ticket_id INT REFERENCES Ticket(id),
    PRIMARY KEY (employee_id, customer_id, ticket_id)
);
