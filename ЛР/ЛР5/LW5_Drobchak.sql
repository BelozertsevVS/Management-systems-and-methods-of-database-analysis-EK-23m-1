﻿-- Створення БД `UniversityDB`;

CREATE DATABASE UniversityDB;

-- Перехід до БД `UniversityDB`;

USE UniversityDB;

-- Створення таблиць `Departments` та `Professors` без обмежень;

CREATE TABLE Departments (
	DepartmentID INT NOT NULL,
	DepartmentName VARCHAR(100)
);

CREATE TABLE Professors (
	ProfessorID INT NOT NULL,
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	Age TINYINT,
	DepartmentID INT,
	Email VARCHAR(100)
);

-- Перевірка 

SELECT * FROM Departments
SELECT * FROM Professors

-- Додавання обмежень до існуючих таблиць
-- Додавання PRIMARY KEY до `Departments` та `Professors`.

ALTER TABLE Departments ADD CONSTRAINT PK_Department PRIMARY KEY (DepartmentID);
ALTER TABLE Professors ADD CONSTRAINT PK_Professor PRIMARY KEY (ProfessorID);

-- Додавання UNIQUE обмеження на `Email` в `Professors`.

ALTER TABLE Professors ADD CONSTRAINT UQ_Professor_Email UNIQUE (Email)

-- Додавання FOREIGN KEY обмеження до `Professors`, щоб пов'язати `DepartmentID` з `Departments`.

ALTER TABLE Professors ADD CONSTRAINT FK_Professor_Department FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID);

--Додавання CHECK обмеження на `Age` в ` Professors`, щоб значення віку не було менше 20.

ALTER TABLE Professors ADD CONSTRAINT CK_Age CHECK (Age > = 20);

-- Додавання NOT NULL обмеження на `FirstName` і `LastName` в `Professors`.

ALTER TABLE Professors ALTER COLUMN FirstName VARCHAR(50) NOT NULL;
ALTER TABLE Professors ALTER COLUMN LastName VARCHAR(50) NOT NULL;

-- Додавання DEFAULT значення для `DepartmentName` в `Departments`.

ALTER TABLE Departments ADD CONSTRAINT DF_DepartmentName DEFAULT 'General' FOR DepartmentName;

-- Введення даних та тестування 
--Введіть дані до `Departments`. Якщо `DepartmentName` не вказано, використовуйте значення за замовчуванням.

INSERT INTO Departments (DepartmentID) VALUES (1); -- Застосується DEFAULT значення 'General'

-- Введіть дані до `Professors`, включаючи їх прив'язку до відділів через `DepartmentID`.

INSERT INTO Professors (ProfessorID, FirstName, LastName, Age, DepartmentID, Email)
VALUES (1, 'John', 'Smith', 57, 1, 'john.smith@university.com');

-- Спроба вставити запис до `Professors` з існуючим `Email`, щоб перевірити UNIQUE обмеження.

INSERT INTO Professors (ProfessorID, FirstName, LastName, DepartmentID, Email)
VALUES (2, 'Jane', 'Doe', 1, 35, 'john.smith@university.com'); -- Це викличе помилку через UNIQUE обмеження

-- Спроба вставити запис до `Professors` з існуючим віком менше 20, щоб перевірити CHECK обмеження.

INSERT INTO Professors (ProfessorID, FirstName, LastName, DepartmentID, Email)
VALUES (3, 'Bob', 'Doe', 1, 17, 'bob@university.com'); -- Це викличе помилку через CHECK обмеження

-- Створення БД `CompanyDB`

CREATE DATABASE CompanyDB;

-- Перехід до БД `UniversityDB`;

USE CompanyDB;

-- Створіть таблицю `Employees` з PRIMARY KEY, NOT NULL, UNIQUE, і DEFAULT обмеженнями

  CREATE TABLE Employees (
      EmployeeID INT PRIMARY KEY,
      FirstName VARCHAR(50) NOT NULL,
      LastName VARCHAR(50) NOT NULL,
      Email VARCHAR(100) UNIQUE,
      Position VARCHAR(50) DEFAULT 'Junior Developer'
  );

--Створіть таблицю `Departments` з PRIMARY KEY та CHECK обмеженнями.

  CREATE TABLE Departments (
      DepartmentID INT PRIMARY KEY,
      DepartmentName VARCHAR(100) NOT NULL CHECK (DepartmentName <> ''),
      Budget DECIMAL(10, 2) CHECK (Budget > 0),
      DefaultRoomNumber INT DEFAULT 101
  );


-- Створіть таблицю `Assignments` з FOREIGN KEY, що вказує на `Employees` та `Departments`.

  CREATE TABLE Assignments (
      AssignmentID INT PRIMARY KEY,
      EmployeeID INT NOT NULL,
      DepartmentID INT NOT NULL,
      AssignmentDate DATE DEFAULT GETDATE(),
      FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
      FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
  );

-- Перевірка 

SELECT * FROM Employees
SELECT * FROM Departments
SELECT * FROM Assignments

--Введіть дані до `Departments` і `Employees`

INSERT INTO Departments (DepartmentID, DepartmentName, Budget)
VALUES (1, 'Human Resources', 50000);
INSERT INTO Employees (EmployeeID, FirstName, LastName, Email)
VALUES (1, 'John', 'Smith', 'john.smith@company.com');
INSERT INTO Assignments (AssignmentID, EmployeeID, DepartmentID)
VALUES (1, 1, 1);

--Спробуйте вставити запис до `Assignments` з неіснуючим `EmployeeID` або `DepartmentID`, щоб перевірити FOREIGN KEY обмеження

INSERT INTO Assignments (AssignmentID, EmployeeID, DepartmentID)
VALUES (2, 999, 1); -- Це викличе помилку через FOREIGN KEY обмеження