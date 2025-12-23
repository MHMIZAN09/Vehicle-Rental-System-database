-- create database 

CREATE DATABASE Vehicle_Rental;

-- create users table 

CREATE TABLE users(
  user_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  password VARCHAR(100) NOT NULL,
  phone VARCHAR(15) NOT NULL,
  role VARCHAR(50) NOT NULL CHECK (role IN ('customer', 'admin')) DEFAULT 'customer'
);

-- create vehicles table
CREATE TABLE vehicles(
  vehicle_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  type VARCHAR(50) NOT NULL CHECK (type IN ('car', 'bike', 'truck')),
  make VARCHAR(50) NOT NULL,
  model VARCHAR(50) NOT NULL,
  registration_number VARCHAR(50) UNIQUE NOT NULL,
  rental_price DECIMAL(10, 2) NOT NULL,
  status VARCHAR(50) NOT NULL CHECK (status IN ('available', 'rented', 'maintenance')) DEFAULT 'available'
);

-- create bookings table
CREATE TABLE bookings(
  booking_id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
  vehicle_id INT REFERENCES vehicles(vehicle_id) ON DELETE CASCADE,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  status VARCHAR(50) NOT NULL CHECK (status IN ('pending', 'confirmed', 'completed', 'cancelled')) DEFAULT 'pending',
   total_cost DECIMAL(10, 2) NOT NULL,
   CHECK (end_date >= start_date)
);

-- insert users data 
-- password field users data insert time null set then insert 
INSERT INTO users (name, email, phone, role) VALUES
('Alice', 'alice@example.com', '1234567890', 'customer'),
('Bob', 'bob@example.com', '0987654321', 'admin'),
('Charlie', 'charlie@example.com', '1122334455', 'customer');

-- insert vehicles data

INSERT INTO vehicles (name,type,model,registration_number,rental_price,status) values
('Toyota Corolla',	'car',	2022	,'ABC-123',	50,	'available'),
('Honda Civic',	'car',	2021	,'DEF-456',	60,	'rented'),
('Yamaha R15',	'bike',	2023	,'GHI-789',	30,	'available'),
('Ford F-150',	'truck',	2020	,'JKL-012',	100,	'maintenance');

-- insert bookings data 
-- when create users that time users table this id show that why insert this id 
insert into bookings (user_id,vehicle_id,start_date,end_date,status,total_cost) values 
(4,2,'2023-10-01','2023-10-05','completed',240),
(4,2,'2023-11-01','2023-11-03','completed',120),
(6,2,'2023-12-01','2023-12-02','confirmed',60),
(4,1,'2023-12-10','2023-12-12','pending',100);



-- Query 1: JOIN
-- Requirement: Retrieve booking information along with Customer name and Vehicle name.

SELECT 
    b.booking_id,
    u.name AS customer_name,
    v.name AS vehicle_name,
    b.start_date,
    b.end_date,
    b.status
FROM bookings AS b
INNER JOIN users AS u
    ON b.user_id = u.user_id
INNER JOIN vehicles AS v
    ON b.vehicle_id = v.vehicle_id;

-- Query 2: EXISTS
-- Requirement: Find all vehicles that have never been booked.



SELECT 
    v.vehicle_id,
    v.name,
    v.type,
    v.model,
    v.registration_number,
   ROUND(v.rental_price)  AS rental_price,
    v.status
FROM vehicles as v
WHERE NOT EXISTS (
    SELECT 1
    FROM bookings AS b
    WHERE b.vehicle_id = v.vehicle_id
);

-- subquery use 1 bcz we just check the existence of rows, the actual values returned by the subquery are not important.




-- Query 3: WHERE
-- Requirement: Retrieve all available vehicles of a specific type (e.g. cars).

SELECT
  vehicle_id,
  name,
  type,
  model,
  registration_number,
  ROUND(rental_price) AS rental_price,
  status
FROM
  vehicles
WHERE
  type = 'car'
  AND status = 'available';

-- Query 4: GROUP BY and HAVING
-- Requirement: Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings.

SELECT
  v.name as vehicle_name,
  count(b.booking_id) as total_bookings
FROM
  vehicles AS v
  JOIN bookings AS b ON v.vehicle_id = b.vehicle_id
 GROUP BY
  v.name
HAVING
  count(b.booking_id) > 2;









