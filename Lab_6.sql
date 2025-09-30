#------------------------------------------------------Exercise_1------------------------------------------------------

CREATE DATABASE exercise_1;
#DROP DATABASE exercise_1;
USE exercise_1;

CREATE TABLE Authors
(
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(50)
);

INSERT INTO Authors( author_name) VALUES
                                      ('Maria Charlotte'),
                                      ('Juan Perez'),
                                      ('Gemma Alcocer');

CREATE TABLE Blogs
(
    blog_id INT AUTO_INCREMENT PRIMARY KEY,
    blog_title VARCHAR(100),
    blog_word_count INT,
    blog_views INT,
    author_id INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

INSERT INTO Blogs(blog_title,blog_word_count,blog_views,author_id) VALUES
                                                                       ('Best Paint Colors',814,14,1),
                                                                       ('Small Space Decorating Tips',1146,221,2),
                                                                       ('Hot Accessories',986,105,1),
                                                                       ('Mixing Textures',765,22,1),
                                                                       ('Kitchen Refresh',1242,307,2),
                                                                       ('Homemade Art Hacks',1002,193,1),
                                                                       ('Refinishing Wood Floors',1571,7542,3);

#------------------------------------------------------Initial Table---------------------------------------------------

SELECT a.author_name As Author,b.blog_title AS Title,b.blog_word_count As Words,b.blog_views As Views FROM Blogs b
                                                                                                               Join Authors a ON b.author_id = a.author_id;

#------------------------------------------------------Exercise_2------------------------------------------------------

CREATE DATABASE exercise_2;
#DROP DATABASE exercise_2;
USE exercise_2;

CREATE TABLE Customers
(
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(50),
    customer_status VARCHAR(10),
    customer_total_mileage INT
);

INSERT INTO Customers(customer_name,customer_status,customer_total_mileage) VALUES
                                                                                ('Agustine Riviera','Silver',115235),
                                                                                ('Alaina Sepulvida','None',6008),
                                                                                ('Tom Jones','Gold',205767),
                                                                                ('Sam Rio','None',2653),
                                                                                ('Jessica James','Silver',127656),
                                                                                ('Ana Janco','Silver',136773),
                                                                                ('Jennifer Cortez','Gold',300582),
                                                                                ('Christian Janco','Silver',14642)
;

CREATE TABLE Aircrafts
(
    aircraft_id INT AUTO_INCREMENT PRIMARY KEY,
    aircraft_name VARCHAR(50),
    aircraft_seats INT
);

INSERT INTO Aircrafts(aircraft_name,aircraft_seats) VALUES
                                                        ('Boeing 747',400),
                                                        ('Airbus A330',236),
                                                        ('Boeing 777',264)
;

CREATE TABLE Flights
(
    flight_id INT AUTO_INCREMENT PRIMARY KEY,
    flight_number VARCHAR(50),
    flight_mileage INT
);

INSERT INTO Flights(flight_number,flight_mileage) VALUES
                                                      ('DL143',135),
                                                      ('DL122',4370),
                                                      ('DL53',2078),
                                                      ('DL222',1765),
                                                      ('DL37',531)
;

CREATE TABLE Bookings
(
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    aircraft_id INT,
    flight_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (aircraft_id) REFERENCES Aircrafts(aircraft_id),
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);

INSERT INTO Bookings(customer_id,aircraft_id,flight_id) VALUES
                                                            (1,1,1),
                                                            (1,2,2),
                                                            (2,2,2),
                                                            (1,1,1),
                                                            (3,2,2),
                                                            (3,3,3),
                                                            (1,1,1),
                                                            (4,1,1),
                                                            (1,1,1),
                                                            (3,3,4),
                                                            (5,1,1),
                                                            (4,1,1),
                                                            (6,3,4),
                                                            (7,3,4),
                                                            (5,2,2),
                                                            (4,1,5),
                                                            (8,3,4)
;

#------------------------------------------------------Initial Table---------------------------------------------------

SELECT b.booking_id AS 'Num',
    c.customer_name AS 'Customer Name',
    c.customer_status AS 'Customer Status',
    f.flight_number AS 'Flight Number',
    a.aircraft_name AS 'Aircraft',
    a.aircraft_seats AS 'Total Aircraft Seats',
    f.flight_mileage AS 'Flight Mileage',
    c.customer_total_mileage AS 'Total Customer Mileage'
FROM Bookings b
         JOIN Customers c ON b.customer_id = c.customer_id
         JOIN Aircrafts a ON b.aircraft_id = a.aircraft_id
         JOIN Flights f ON b.flight_id = f.flight_id;

#------------------------------------------------------Exercise_3------------------------------------------------------

#  1. Total number of flights:

SELECT COUNT(flight_id) AS 'Total Flights' FROM Flights;

#  2. Average flight distance:

SELECT AVG(flight_mileage) AS 'Average Flight Distance' From Flights;

#  3. Average number of seats per aircraft:

SELECT AVG(aircraft_seats) AS 'Average number of seats per aircraft' FROM Aircrafts;

#  4. Average miles flown by customers, grouped by status:

SELECT c.customer_status, AVG(customer_total_mileage) AS 'Average miles flown by customers' FROM Customers c
GROUP BY c.customer_status;

#  5. Max miles flown by customers, grouped by status:

SELECT c.customer_status, MAX(customer_total_mileage) AS 'Max miles flown by customers' FROM Customers c
GROUP BY c.customer_status;

#  6. Number of aircrafts with "Boeing" in their name:

SELECT COUNT(*) AS 'Number of aircrafts with "Boeing" in their name' FROM Aircrafts
WHERE aircraft_name LIKE '%Boeing%';

#  7. Flights with distance between 300 and 2000 miles:

SELECT * FROM Flights WHERE flight_mileage BETWEEN 300 AND 2000;

#  8. Average flight distance booked, grouped by customer status:

SELECT c.customer_status AS 'Customer Status',
    AVG(f.flight_mileage) AS 'Average flight distance booked'
FROM Bookings b
         JOIN Customers c ON b.customer_id = c.customer_id
         JOIN Flights f ON b.flight_id = f.flight_id
GROUP BY c.customer_status;

#  9. Most booked aircraft among Gold status members:

SELECT a.aircraft_name, COUNT(*) AS Most_booked_aircraft_among_Gold_status_members
FROM Bookings b
         JOIN Customers c ON b.customer_id = c.customer_id
         JOIN Aircrafts a ON b.aircraft_id = a.aircraft_id
         JOIN Flights f ON b.flight_id = f.flight_id
WHERE c.customer_status = 'Gold'
GROUP BY a.aircraft_name
ORDER BY Most_booked_aircraft_among_Gold_status_members DESC
    LIMIT 1;