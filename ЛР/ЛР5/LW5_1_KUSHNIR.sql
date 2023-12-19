CREATE DATABASE UniversityDB;

USE UniversityDB;

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

ALTER TABLE Departments ADD CONSTRAINT PK_Department PRIMARY KEY (DepartmentID);

ALTER TABLE Professors ADD CONSTRAINT PK_Professor PRIMARY KEY (ProfessorID);

ALTER TABLE Professors ADD CONSTRAINT UQ_Professor_Email UNIQUE (Email);

ALTER TABLE Professors ADD CONSTRAINT FK_Professor_Department FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID);

ALTER TABLE Professors ADD CONSTRAINT CK_Age CHECK (Age > = 20);

ALTER TABLE Professors ALTER COLUMN FirstName VARCHAR(50) NOT NULL;

ALTER TABLE Professors ALTER COLUMN LastName VARCHAR(50) NOT NULL;

ALTER TABLE Departments ADD CONSTRAINT DF_DepartmentName DEFAULT 'General' FOR DepartmentName;

INSERT INTO Departments (DepartmentID) VALUES (1);

INSERT INTO Professors (ProfessorID, FirstName, LastName, Age, DepartmentID, Email)
VALUES (1, 'John', 'Smith', 57, 1, 'john.smith@university.com');

INSERT INTO Professors (ProfessorID, FirstName, LastName, DepartmentID, Email)
VALUES (2, 'Jane', 'Doe', 1, 35, 'john.smith@university.com');

INSERT INTO Professors (ProfessorID, FirstName, LastName, DepartmentID, Email)
VALUES (3, 'Bob', 'Doe', 1, 17, 'bob@university.com');

DROP TABLE Professors;
DROP TABLE Departments;

DROP DATABASE UniversityDB;