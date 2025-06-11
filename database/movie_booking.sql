-- Database Schema for Movie Booking System

CREATE DATABASE IF NOT EXISTS movie_booking;
USE movie_booking;

-- Table: Theatres
CREATE TABLE theatres (
    theatre_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(255)
);

-- Table: Shows
CREATE TABLE shows (
    show_id INT AUTO_INCREMENT PRIMARY KEY,
    movie_name VARCHAR(150) NOT NULL,
    theatre_id INT,
    show_time DATETIME,
    FOREIGN KEY (theatre_id) REFERENCES theatres(theatre_id)
);

-- Table: Seats
CREATE TABLE seats (
    seat_id INT AUTO_INCREMENT PRIMARY KEY,
    theatre_id INT,
    seat_number VARCHAR(10),
    FOREIGN KEY (theatre_id) REFERENCES theatres(theatre_id)
);

-- Table: Customers
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);

-- Table: Bookings
CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    show_id INT,
    seat_id INT,
    customer_id INT,
    booking_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (show_id) REFERENCES shows(show_id),
    FOREIGN KEY (seat_id) REFERENCES seats(seat_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Sample Data

INSERT INTO theatres (name, location) VALUES ('CineMagic', 'New Delhi');

INSERT INTO shows (movie_name, theatre_id, show_time)
VALUES ('Inception', 1, '2025-06-12 18:30:00');

mysql> INSERT INTO seats (theatre_id, seat_number) 
VALUES (1, 'A1'), (1, 'A2'), (1, 'A3'), (1, 'A4'), (1, 'A5'), (1, 'A6'), (1, 'B1'), (1, 'B2'), (1, 'B3'), (1, 'B4'), (1, 'B5'), (1, 'B6');

INSERT INTO customers (name, email) 
VALUES ('Riya Kaushik', 'riya12@gmail.com');

INSERT INTO bookings (show_id, seat_id, customer_id)
VALUES (1, 2, 1); -- Books seat 'A2' for 'Inception' by John

-- Query: Available seats for show_id=1
-- SELECT s.seat_id, s.seat_number
-- FROM seats s
-- JOIN shows sh ON s.theatre_id = sh.theatre_id
-- WHERE sh.show_id = 1
-- AND s.seat_id NOT IN (SELECT seat_id FROM bookings WHERE show_id = 1);
