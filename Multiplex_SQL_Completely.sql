CREATE DATABASE CinemaMultiplex

CREATE TABLE EmployeesPositions
(
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Names NVARCHAR(30) NOT NULL
)

INSERT INTO EmployeesPositions
VALUES
('Specialist in customer service'),
('Chief Accountant'),
('HR-director')

SELECT * FROM EmployeesPositions

CREATE TABLE Employees
(
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
RolesId INT REFERENCES Roles(Id) ON DELETE CASCADE NOT NULL,
EmployeesPositionsId INT REFERENCES EmployeesPositions(Id) ON DELETE CASCADE NOT NULL,
Names NVARCHAR(50) NOT NULL,
Surname NVARCHAR(50) NOT NULL,
DateBirthday DATE NOT NULL CHECK(DateBirthday!>GETDATE()),
Email NVARCHAR(50) NOT NULL,
TelephoneNumber NVARCHAR(10) NOT NULL,
EmploymentDate DATE NOT NULL CHECK(EmploymentDate!>GETDATE()),
)

INSERT INTO Employees
VALUES
(2,3,'Alyona','Tut','07.07.2001','o.tutova.82@gmail.com','0984236827','12.04.2018'),
(2,2,'Anastasiya','Filip','13.05.2001','filippova@gmail.com','0671369639','04.06.2019'),
(2,1,'Sergey','Perepel','21.11.1996','perpelov@gmail.com','0660205625','05.04.2018')

SELECT * FROM Employees

DROP TABLE Employees

CREATE TABLE FiredEmployees
(
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
EmployeesId INT REFERENCES Employees(Id) ON DELETE CASCADE NOT NULL,
Names NVARCHAR(50) NOT NULL,
Surname NVARCHAR(50) NOT NULL,
EmploymentDate DATE NOT NULL CHECK(EmploymentDate!>GETDATE()),
DateDismissal DATE NOT NULL CHECK(DateDismissal!>GETDATE()),
Email NVARCHAR(50) NOT NULL,
TelephoneNumber NVARCHAR(10) NOT NULL,
CHECK(DateDismissal!<EmploymentDate)
)

INSERT INTO FiredEmployees
VALUES
(3,'Sergey','Perepel','05.04.2018','24.01.2023','perpelov@gmail.com','0660205625')

SELECT * FROM FiredEmployees

DROP TABLE FiredEmployees

CREATE TABLE RegisteredUsers
(
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
RolesId INT REFERENCES Roles(Id) ON DELETE CASCADE NOT NULL,
Names NVARCHAR(50) NOT NULL,
Surname NVARCHAR(50) NOT NULL,
DateBirthday DATE NOT NULL CHECK(DateBirthday!>GETDATE()),
Email NVARCHAR(50) NOT NULL,
TelephoneNumber NVARCHAR(10) NOT NULL,
Logins NVARCHAR(50) NOT NULL UNIQUE,
Passwords NVARCHAR(50) NOT NULL,
IsHasADiscount BIT DEFAULT(0)
)

INSERT INTO RegisteredUsers
VALUES
(3,'Alex','Smelyanskiy','01.04.2005','azure@gmail.com','0984567382','azureXSX','12345',1),
(3,'Polina','Gutovskaya','24.10.2001','gutovskaya@gmail.com','0974512390','polina_gutovskaya','43215',0),
(3,'Sergey','Izya','20.01.1985','izya@gmail.com','0961487912','izya_here','98761',1)

SELECT * FROM RegisteredUsers

CREATE TABLE Films
(
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
ProductionYear DATETIME NOT NULL CHECK(ProductionYear!>GETDATE()),
Country NVARCHAR(100) NOT NULL,
Names NVARCHAR(50) NOT NULL UNIQUE,
Genre NVARCHAR(100) NOT NULL,
Producer NVARCHAR(100) NOT NULL,
Budget MONEY NOT NULL CHECK(Budget!<0),
Duration TIME NOT NULL,
PremiereDate DATETIME NOT NULL,
CHECK(ProductionYear!>PremiereDate)
)

INSERT INTO Films
VALUES
('2023','Germany','Corsage','Biographical, Historical, Drama','Marie Kreutzer',1200500,'01:53','02.02.2023'),
('2001','New Zeland, USA','Lord of the rings, Brotherhood of the ring','fantasy, adventure, drama','Peter Jackson',93000000,'02:58','10.12.2001')

CREATE TABLE CinemaHalls
(
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Names NVARCHAR(100) NOT NULL,
NumberOfSeats INT NOT NULL CHECK(NumberOfSeats!<0),
IsAvailable BIT DEFAULT(1)
)

INSERT INTO CinemaHalls
VALUES
('1',100,1),
('2',75,0)

SELECT * FROM CinemaHalls

CREATE TABLE MovieSnacks
(
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Names NVARCHAR(100) NOT NULL,
Amount INT NOT NULL CHECK (Amount!<0),
Price MONEY NOT NULL CHECK(Price!<0),
Discount MONEY CHECK(Discount!<0),
IsDiscount BIT DEFAULT(0)
)

INSERT INTO MovieSnacks
VALUES
('popcorn',15,5.75,25,1),
('coca-cola',50,3,0,0)

SELECT * FROM MovieSnacks

CREATE TABLE Sessions
(
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
FilmsId INT NOT NULL REFERENCES Films(Id) ON DELETE CASCADE,
CinemaHallsId INT NOT NULL REFERENCES CinemaHalls(Id) ON DELETE CASCADE,
Dates DATETIME NOT NULL,
Times TIME NOT NULL
)

INSERT INTO Sessions
VALUES
(2,1,'02.02.2023','15:30'),
(1,2,'31.01.2023','19:00')