-- Active: 1709292013339@@127.0.0.1@3306@SQL_1

CREATE database SQL_1; 
USE SQL_1;

-- create table Students
CREATE TABLE Students (
    Snum int PRIMARY KEY,
    Name varchar(30),
    Major varchar(10),
    Level char(3) CHECK (Level IN ('UN', 'MA', 'PhD')),
    Age int CHECK (Age >= 18 AND Age <= 45)
);

-- add some rows to Students
INSERT INTO Students (Snum, Name, Major, Level, Age) 
VALUES 
(1, 'John', 'CS', 'UN', 20),
(2, 'Jane', 'Eng', 'MA', 25),
(3, 'Michael', 'Physics', 'PhD', 30);

-- CREATE TABLE Faculty
CREATE TABLE Faculty (
    Fid int PRIMARY KEY,
    Name varchar(10),
    Dept varchar(10)
);

-- add some rows to Faculty
INSERT INTO Faculty (Fid, Name, Dept) 
VALUES 
(1, 'Smith', 'CS'),
(2, 'Johnson', 'Eng'),
(3, 'Lee', 'Physics');

-- create table Class
CREATE TABLE Class (
    ClassName varchar(10) PRIMARY KEY,
    Time Datetime,
    Room char(5),
    Fid int,
    FOREIGN KEY (Fid) REFERENCES Faculty(Fid)
);

-- add some rows to table Class
INSERT INTO Class (ClassName, Time, Room, Fid) 
VALUES 
('CS101', '2024-03-01 09:00:00', 'A101', 1),
('ENG201', '2024-03-02 10:30:00', 'B202', 2),
('PHY301', '2024-03-03 13:00:00', 'C303', 3);

-- create table Enrolled
CREATE TABLE Enrolled (
    Snum int,
    ClassName varchar(10),
    PRIMARY KEY (Snum, ClassName),
    FOREIGN KEY (Snum) REFERENCES Students(Snum),
    FOREIGN KEY (ClassName) REFERENCES Class(ClassName)
);

-- add some rows to Enrolled
INSERT INTO Enrolled (Snum, ClassName) 
VALUES 
(1, 'CS101'),
(2, 'ENG201'),
(3, 'PHY301');

-- Return the list of undergraduate students
SELECT * 
FROM Students 
WHERE Level = 'UN';

-- Return the list of departments (Dept) of faculty members 
SELECT DISTINCT Dept 
FROM Faculty;

-- Return the list of classes (ClassName) which have students enroll in.  No duplicates should be printed in the answers 
SELECT DISTINCT ClassName 
FROM Enrolled;

-- Return the list of classes located in the building B (room started with “B-“; for example room B1-203, B1-204,… )
SELECT ClassName 
FROM Class 
WHERE Room LIKE 'B-%';

-- Return the names of all students in CS (Major = "CS") who are enrolled in the course "Math92" 
SELECT Students.Name
FROM Students
JOIN Enrolled ON Students.Snum = Enrolled.Snum
JOIN Class ON Enrolled.ClassName = Class.ClassName
WHERE Students.Major = 'CS' AND Class.ClassName = 'Math92';

-- Return the names of all undergraduate student in CS (Major = "CS") who are enrolled in the course "Math92" and are older than 25 years old 
SELECT Students.Name
FROM Students
JOIN Enrolled ON Students.Snum = Enrolled.Snum
JOIN Class ON Enrolled.ClassName = Class.ClassName
WHERE Students.Major = 'CS' 
AND Class.ClassName = 'Math92' 
AND Students.Level = 'UN' 
AND Students.Age > 25;

-- Return the names of all undergraduate student in CS (Major = "CS") who are enrolled in the course "Math92" and are older than some of PhD students
SELECT DISTINCT s.Name
FROM Students s
JOIN Enrolled e ON s.Snum = e.Snum
JOIN Class c ON e.ClassName = c.ClassName
WHERE s.Major = 'CS' 
AND c.ClassName = 'Math92' 
AND s.Level = 'UN' 
AND s.Age > (SELECT MIN(Age) FROM Students WHERE Level = 'PhD');

-- Return the names of all classes that either meet in room R128 or are taught by "H.Merlin".
SELECT ClassName
FROM Class
WHERE Fid IN (SELECT Fid FROM Faculty WHERE Name = 'H.Merlin')
UNION
SELECT ClassName
FROM Class
WHERE Room = 'R128';

-- Return all students who are enrolled in two classes that meet at the same time
SELECT DISTINCT s.Name
FROM Students s
JOIN Enrolled e1 ON s.Snum = e1.Snum
JOIN Enrolled e2 ON s.Snum = e2.Snum AND e1.ClassName != e2.ClassName
JOIN Class c1 ON e1.ClassName = c1.ClassName
JOIN Class c2 ON e2.ClassName = c2.ClassName
WHERE c1.Time = c2.Time;

-- Return all students who do not enroll in any class yet
SELECT Name
FROM Students
LEFT JOIN Enrolled ON Students.Snum = Enrolled.Snum
WHERE Enrolled.Snum IS NULL;

-- Return all classes that have less than 20 enrolled students 
SELECT Class.ClassName
FROM Class
LEFT JOIN Enrolled ON Class.ClassName = Enrolled.ClassName
GROUP BY Class.ClassName
HAVING COUNT(Enrolled.Snum) < 20 OR COUNT(Enrolled.Snum) IS NULL;