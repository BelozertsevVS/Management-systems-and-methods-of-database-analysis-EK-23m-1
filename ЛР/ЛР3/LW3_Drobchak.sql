-- Створення БД "Студенти"

CREATE DATABASE STUDENTS; 

-- Перехід до БД "Студенти"

USE STUDENTS;

-- Створення таблиць з персональною, контактною та академічною інформацією студента

CREATE TABLE PersonalInfo (
        StudentID INT PRIMARY KEY,
        FirstName NVARCHAR(50),
        LastName NVARCHAR(50),
        DateOfBirth DATE
    );

	CREATE TABLE AcademicInfo (
        RecordID INT PRIMARY KEY,
        StudentID INT FOREIGN KEY REFERENCES PersonalInfo(StudentID),
        Faculty NVARCHAR(100),
        Curator NVARCHAR(100),
        EnrollmentYear INT
    );

	CREATE TABLE ContactInfo (
        ContactID INT PRIMARY KEY,
        StudentID INT FOREIGN KEY REFERENCES PersonalInfo(StudentID),
        Email NVARCHAR(100),
        PhoneNumber NVARCHAR(15)
    );

/* 
Операції зі структурою таблиці "ContactInfo":
Додавання стовбця "Address":
*/

ALTER TABLE ContactInfo ADD Address NVARCHAR(200);

-- Видалення стовбця "PhoneNumber"

ALTER TABLE ContactInfo DROP COLUMN PhoneNumber;

-- Зміна ім'я стовбця "Email" на "EmailAddress"

EXEC sp_rename 'ContactInfo.Email', 'EmailAddress', 'COLUMN';

-- Змінення типу даних стовбця "Faculty" у таблиці "AcademicInfo" на NVARCHAR(150)

ALTER TABLE AcademicInfo
ALTER COLUMN Faculty NVARCHAR(150);

-- Додавання нової таблиці
CREATE TABLE Extracurricular (
        ActivityID INT PRIMARY KEY,
        StudentID INT FOREIGN KEY REFERENCES PersonalInfo(StudentID),
        ActivityName NVARCHAR(100),
        JoinDate DATE
    );

-- Перевірка 

SELECT * FROM Extracurricular

-- Видалення таблиці

DROP TABLE Extracurricular;

-- Перевірка 

SELECT * FROM Extracurricular;

-- Створення та видалення БД 

CREATE DATABASE TEACHER;

DROP DATABASE TEACHER;

-- Переключення на потрібну БД

USE STUDENTS;

-- Додавання відповідних рядків

INSERT INTO PersonalInfo (StudentID, FirstName, LastName, DateOfBirth)
VALUES 
    (1, 'Олександр', 'Петров', '2000-05-15'),
    (2, 'Марія', 'Іваненко', '2001-03-22'),
    (3, 'Василь', 'Коваленко', '1999-10-10');

-- Перевірка

SELECT * FROM PersonalInfo