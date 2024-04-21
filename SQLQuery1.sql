create database Academy

use Academy



CREATE TABLE Departments (
    Id INT PRIMARY KEY identity(1,1),
    Financing MONEY NOT NULL check(Financing>=0) DEFAULT 0,
    Name NVARCHAR(100) NOT NULL check(Name<>'') UNIQUE,
    FacultyId INT NOT NULL,	
    FOREIGN KEY (FacultyId) REFERENCES Faculties(Id)
);



CREATE TABLE Faculties 
(
    Id INT PRIMARY KEY identity(1,1),
    Name NVARCHAR(100) NOT NULL check(Name<>'') UNIQUE,
);



CREATE TABLE Groups (
    Id INT PRIMARY KEY identity(1,1),
    Name NVARCHAR(10) NOT NULL check(Name<>'') UNIQUE,
    Year INT NOT NULL CHECK (Year BETWEEN 1 AND 5),
    DepartmentId INT NOT NULL,
    FOREIGN KEY (DepartmentId) REFERENCES Departments(Id)
);



CREATE TABLE GroupsLectures (
    Id INT PRIMARY KEY identity(1,1),
    GroupId INT NOT NULL,
    LectureId INT NOT NULL,
    FOREIGN KEY (GroupId) REFERENCES Groups(Id),
    FOREIGN KEY (LectureId) REFERENCES Lectures(Id)
);



CREATE TABLE Lectures (
    Id INT PRIMARY KEY identity(1,1),
    DayOfWeek INT NOT NULL CHECK (DayOfWeek BETWEEN 1 AND 7),
    LectureRoom NVARCHAR(MAX) NOT NULL check(LectureRoom<>''),
    SubjectId INT NOT NULL,
    TeacherId INT NOT NULL,
    FOREIGN KEY (SubjectId) REFERENCES Subjects(Id),
    FOREIGN KEY (TeacherId) REFERENCES Teachers(Id)
);



CREATE TABLE Subjects (
    Id INT PRIMARY KEY identity(1,1),
    Name NVARCHAR(100) check(Name<>'') NOT NULL UNIQUE
);



CREATE TABLE Teachers (
    Id INT PRIMARY KEY identity(1,1),
    Name NVARCHAR(MAX) check(Name<>'') NOT NULL,
    Salary MONEY NOT NULL CHECK (Salary > 0),
    Surname NVARCHAR(MAX) check(Surname<>'') NOT NULL	
);



DROP TABLE GroupsLectures;
DROP TABLE Lectures;
DROP TABLE Groups;
DROP TABLE Departments;
DROP TABLE Faculties;
DROP TABLE Subjects;
DROP TABLE Teachers;


SELECT *
FROM Departments
WHERE Name = 'Software Development';





-- Вставка даних в таблицю Faculties
INSERT INTO Faculties (Name) 
VALUES 
('Факультет Інформаційних Технологій'),
('Факультет Економіки'),
('Факультет Мовознавства'),
('Факультет Мистецтв'),
('Факультет Математики'),
('Факультет Фізики'),
('Факультет Біології'),
('Факультет Медицини'),
('Факультет Права'),
('Факультет Географії'),
('Факультет Хімії'),
('Факультет Психології'),
('Факультет Історії'),
('Факультет Філософії'),
('Факультет Геології'),
('Факультет Соціології'),
('Факультет Маркетингу'),
('Факультет Архітектури'),
('Факультет Фармації'),
('Факультет Педагогіки');

-- Вставка даних в таблицю Departments
INSERT INTO Departments (Financing, Name, FacultyId) 
SELECT 
    ROUND(RAND() * 100000 + 100000, 2) AS Financing,
    CONCAT('Кафедра ', F.Id) AS Name,
    F.Id AS FacultyId
FROM Faculties F;

-- Вставка даних в таблицю Subjects
INSERT INTO Subjects (Name) 
VALUES 
('Основи Програмування'),
('Міжнародні Фінанси'),
('Лінгвістика'),
('Історія Живопису'),
('Лінійна Алгебра'),
('Квантова Фізика'),
('Мікробіологія Організмів'),
('Хірургічні Техніки'),
('Кримінальне Право України'),
('Картографія України'),
('Хімічні Процеси'),
('Основи Психотерапії'),
('Давня Історія'),
('Філософія Науки'),
('Мінералогічний Аналіз'),
('Методологія Соціологічних Досліджень'),
('Маркетинг Туризму'),
('Дизайн Інтерєру'),
('Фармацевтична Хімія'),
('Основи Виховання');

-- Вставка даних в таблицю Teachers
INSERT INTO Teachers (Name, Salary, Surname) 
SELECT 
    CONCAT('Викладач ', F.Id) AS Name,
    ROUND(RAND() * 2000 + 2000, 2) AS Salary,
    CONCAT('Прізвище ', F.Id) AS Surname
FROM Faculties F;

-- Вставка даних в таблицю Lectures
INSERT INTO Lectures (DayOfWeek, LectureRoom, SubjectId, TeacherId) 
SELECT 
    ROUND(RAND() * 6 + 1, 0) AS DayOfWeek,
    CONCAT('Аудиторія ', F.Id) AS LectureRoom,
    F.Id AS SubjectId,
    F.Id AS TeacherId
FROM Subjects F;

-- Вставка даних в таблицю Groups
INSERT INTO Groups (Name, Year, DepartmentId) 
SELECT 
    CONCAT('Група ', F.Id) AS Name,
    ROUND(RAND() * 4 + 1, 0) AS Year,
    F.Id AS DepartmentId
FROM Departments F;

-- Вставка даних в таблицю GroupsLectures
INSERT INTO GroupsLectures (GroupId, LectureId) 
SELECT 
    ROUND(RAND() * 20 + 1, 0) AS GroupId,
    ROUND(RAND() * 20 + 1, 0) AS LectureId
FROM Lectures;
