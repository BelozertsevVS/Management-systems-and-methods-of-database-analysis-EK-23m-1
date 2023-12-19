CREATE DATABASE CompanyDB;
USE CompanyDB;
CREATE TABLE Employees (
EmployeeID INT PRIMARY KEY,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
Email VARCHAR(100) UNIQUE,
Position VARCHAR(50) DEFAULT 'Junior Developer'
);

CREATE TABLE Departments (
DepartmentID INT PRIMARY KEY,
DepartmentName VARCHAR(100) NOT NULL CHECK (DepartmentName <> ''),
Budget DECIMAL(10, 2) CHECK (Budget > 0),
DefaultRoomNumber INT DEFAULT 101
);

CREATE TABLE Assignments (
AssignmentID INT PRIMARY KEY,
EmployeeID INT NOT NULL,
DepartmentID INT NOT NULL,
AssignmentDate DATE DEFAULT GETDATE(),
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

INSERT INTO Departments (DepartmentID, DepartmentName, Budget)
VALUES (1, 'Human Resources', 50000);
INSERT INTO Employees (EmployeeID, FirstName, LastName, Email)
VALUES (1, 'John', 'Smith', 'john.smith@company.com');
INSERT INTO Assignments (AssignmentID, EmployeeID, DepartmentID)
VALUES (1, 1, 1);

INSERT INTO Assignments (AssignmentID, EmployeeID, DepartmentID)
VALUES (2, 999, 1);

DROP TABLE Assignments;
DROP TABLE Employees;
DROP TABLE Departments;

DROP DATABASE CompanyDB;