# Vehicle Rental System – Database Design & SQL Queries

## Project Overview
This project is a simplified **Vehicle Rental System database** designed to demonstrate understanding of:
- Database table design
- Entity Relationship Diagram (ERD)
- Primary and Foreign Key relationships
- SQL queries using JOIN, EXISTS, WHERE, GROUP BY and HAVING

The system manages users, vehicles, and bookings while following real-world business rules.

---

## Database Tables

### 1. Users
Stores information about system users.

**Attributes**
- user_id (Primary Key)
- name
- email (Unique)
- password
- phone
- role (Admin / Customer)

**Relationship**
- One user can make multiple bookings (One-to-Many)

---

### 2. Vehicles
Stores vehicle details available for rent.

**Attributes**
- vehicle_id (Primary Key)
- name
- type (car / bike / truck)
- model
- registration_number (Unique)
- rental_price
- status (available / rented / maintenance)

**Relationship**
- One vehicle can appear in multiple bookings over time

---

### 3. Bookings
Stores booking information connecting users and vehicles.

**Attributes**
- booking_id (Primary Key)
- user_id (Foreign Key → Users)
- vehicle_id (Foreign Key → Vehicles)
- start_date
- end_date
- status (pending / confirmed / completed / cancelled)
- total_cost

---

##  ERD Relationships
- **One-to-Many:** Users → Bookings  
- **Many-to-One:** Bookings → Vehicles  
- **Logical One-to-One:** Each booking connects exactly one user and one vehicle  

The ERD was created using **Lucidchart** and includes PK, FK, and relationship cardinality.

## Lucidchart link: https://lucid.app/lucidchart/16655971-5d18-4443-865e-beeaa5eaef42/edit?viewport_loc=-3467%2C-1629%2C3297%2C1536%2C0_0&invitationId=inv_67351b65-612f-4e75-aa11-e678ae46e902

---

## SQL Queries
All required SQL queries are included in the `queries.sql` file with proper explanations.

The queries demonstrate:
- INNER JOIN
- NOT EXISTS (Subquery)
- WHERE clause
- GROUP BY and HAVING

## Theory Questions

## Question 1: What is a foreign key, and why is it important in relational databases?
Answer: A foreign key is a column or set of columns in one table that refers to the primary key of another table. It is used to create a link between the two tables. Foreign keys are important because they enforce referential integrity, which means the database ensures that the relationship between tables remains consistent. For example, in a database with Bookings and Users, the Bookings.users_id can be a foreign key that refers to Users.id. This ensures that every order belongs to a valid customer. Without foreign keys, the database could have inconsistent or orphaned data.

## Question 2: What is the difference between WHERE and HAVING clauses in SQL?
Answer: The WHERE clause is used to filter rows before any grouping is done in SQL. It works on individual rows in a table. The HAVING clause, on the other hand, is used to filter groups after the GROUP BY clause has been applied. For example, if you want to find products with a price greater than 100, you use WHERE price > 100. But if you want to find categories where the average price is more than 100, you use HAVING AVG(price) > 100.

## Question 3: What is a primary key and what are its characteristics?
Answer: A primary key is a column, or a set of columns, in a table that uniquely identifies each row. Its characteristics are:

Unique – No two rows can have the same primary key value.

Not Null – Every row must have a value for the primary key.

Immutable – Ideally, the value of a primary key does not change.
Primary keys are important because they help in identifying rows uniquely and are often used for creating relationships with foreign keys.

## Question 4: What is the difference between INNER JOIN and LEFT JOIN in SQL?
Answer: INNER JOIN returns only the rows that have matching values in both tables. If there is no match, the row is not included.
LEFT JOIN returns all rows from the left table, and matching rows from the right table. If there is no match, the result will still include the left table row, but the right table columns will be NULL.
For example, if you have Users and Bookings, an INNER JOIN will give you only users who have placed orders. A LEFT JOIN will give you all users, including those who have never placed an order.


