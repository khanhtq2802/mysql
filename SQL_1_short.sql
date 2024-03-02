CREATE TABLE Students (
    Snum int PRIMARY KEY,
    Name varchar(30),
    Major varchar(10),
    Level char(3) CHECK (Level IN ('UN', 'MA', 'PhD')),
    Age int CHECK (Age >= 18 AND Age <= 45)
);

CREATE TABLE Faculty (
    Fid int PRIMARY KEY,
    Name varchar(10),
    Dept varchar(10)
);

CREATE TABLE Class (
    ClassName varchar(10) PRIMARY KEY,
    Time Datetime,
    Room char(5),
    Fid int,
    FOREIGN KEY (Fid) REFERENCES Faculty(Fid)
);

CREATE TABLE Enrolled (
    Snum int,
    ClassName varchar(10),
    PRIMARY KEY (Snum, ClassName),
    FOREIGN KEY (Snum) REFERENCES Students(Snum),
    FOREIGN KEY (ClassName) REFERENCES Class(ClassName)
);

SELECT * 
FROM Students 
WHERE Level = 'UN';

SELECT DISTINCT Dept 
FROM Faculty;

SELECT DISTINCT ClassName 
FROM Enrolled;

SELECT ClassName 
FROM Class 
WHERE Room LIKE 'B%';

SELECT DISTINCT Students.Name
FROM Students
JOIN Enrolled ON Students.Snum = Enrolled.Snum
JOIN Class ON Enrolled.ClassName = Class.ClassName
WHERE Students.Major = 'CS' AND Class.ClassName = 'Math92';

SELECT DISTINCT Students.Name
FROM Students
JOIN Enrolled ON Students.Snum = Enrolled.Snum
JOIN Class ON Enrolled.ClassName = Class.ClassName
WHERE Students.Major = 'CS' 
AND Class.ClassName = 'Math92' 
AND Students.Level = 'UN' 
AND Students.Age > 25;

SELECT DISTINCT s.Name
FROM Students s
JOIN Enrolled e ON s.Snum = e.Snum
JOIN Class c ON e.ClassName = c.ClassName
WHERE s.Major = 'CS' 
AND c.ClassName = 'Math92' 
AND s.Level = 'UN' 
AND s.Age > (SELECT MIN(Age) FROM Students WHERE Level = 'PhD');

SELECT ClassName
FROM Class
WHERE Fid IN (SELECT Fid FROM Faculty WHERE Name = 'H.Merlin')
UNION
SELECT ClassName
FROM Class
WHERE Room = 'R128';

SELECT DISTINCT s.Name
FROM Students s
JOIN Enrolled e1 ON s.Snum = e1.Snum
JOIN Enrolled e2 ON s.Snum = e2.Snum AND e1.ClassName != e2.ClassName
JOIN Class c1 ON e1.ClassName = c1.ClassName
JOIN Class c2 ON e2.ClassName = c2.ClassName
WHERE c1.Time = c2.Time;

SELECT Name
FROM Students
LEFT JOIN Enrolled ON Students.Snum = Enrolled.Snum
WHERE Enrolled.Snum IS NULL;

SELECT Class.ClassName
FROM Class
LEFT JOIN Enrolled ON Class.ClassName = Enrolled.ClassName
GROUP BY Class.ClassName
HAVING COUNT(Enrolled.Snum) < 20 OR COUNT(Enrolled.Snum) IS NULL;