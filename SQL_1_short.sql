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

SELECT *
FROM Class
WHERE SUBSTRING(Room, 1, 1) = "B"

SELECT Students.Name
FROM Students
JOIN Enrolled ON Students.Snum = Enrolled.Snum
JOIN Class ON Enrolled.ClassName = Class.ClassName
WHERE Students.Major = 'CS' AND Class.ClassName = 'Math92';

SELECT Students.Name
FROM Students
JOIN Enrolled ON Students.Snum = Enrolled.Snum
JOIN Class ON Enrolled.ClassName = Class.ClassName
WHERE Students.Major = 'CS' 
AND Class.ClassName = 'Math92' 
AND Students.Level = 'UN' 
AND Students.Age > 25;

SELECT Students.Name
FROM Students
JOIN Enrolled ON Students.Snum = Enrolled.Snum
JOIN Class ON Enrolled.ClassName = Class.ClassName
WHERE Students.Major = 'CS'
AND Students.Level = 'UN'
AND Students.Age > 25
AND Class.ClassName = 'Math92'
------------------------------------------------

SELECT s.Name
FROM Students s
JOIN Enrolled e ON s.Snum = e.Snum
JOIN Class c ON e.ClassName = c.ClassName
WHERE s.Major = 'CS' 
AND c.ClassName = 'Math92' 
AND s.Level = 'UN' 
AND s.Age > (SELECT MIN(Age) FROM Students WHERE Level = 'PhD');

SELECT Name 
FROM Students S1 JOIN Enrolled USING(Snum)
WHERE Level = 'UN' AND MAJOR = 'CS' AND classname = 'Math92' AND EXISTS (SELECT * 
 FROM Students S2
 WHERE S1.Age > S2.Age AND S2.Level = 'PhD');

 SELECT Name 
FROM Students 
WHERE Students.Major = 'CS' 
AND Students.Level='UN'
AND Students.Snum IN (SELECT Snum FROM Enrolled WHERE ClassName = 'Math92')
AND Students.Age > ANY(SELECT Age FROM Students WHERE Level='PhD')

------------------------------------------------------------
SELECT ClassName
FROM Class
WHERE Fid IN (SELECT Fid FROM Faculty WHERE Name = 'H.Merlin')
UNION
SELECT ClassName
FROM Class
WHERE Room = 'R128';

SELECT DISTINCT c.ClassName
FROM Class c
LEFT JOIN Faculty f ON c.Fid = f.Fid
WHERE c.Room = 'R128' OR f.Name = 'H.Merlin'

SELECT ClassName FROM Class 
WHERE Room = "R128" OR Fid IN (SELECT Fid FROM Faculty WHERE Name = "H.Merlin");

SELECT ClassName
FROM Class
WHERE Room = 'R128'
UNION
SELECT ClassName
FROM Class
WHERE Fid = (SELECT Fid FROM Faculty WHERE Name = 'H.Merlin');
------------------------------------------------------------------------
SELECT DISTINCT s.Name
FROM Students s
JOIN Enrolled e1 ON s.Snum = e1.Snum
JOIN Enrolled e2 ON s.Snum = e2.Snum AND e1.ClassName != e2.ClassName
JOIN Class c1 ON e1.ClassName = c1.ClassName
JOIN Class c2 ON e2.ClassName = c2.ClassName
WHERE c1.Time = c2.Time;

SELECT Name FROM Students WHERE Snum IN (Select Snum FROM Enrolled GROUP BY Time, Snum 
HAVING COUNT(*) >= 2);

select * from Students where exists ( select * from Enrolled E1, Enrolled E2, Class S1, Class S2 where 
E1.Snum = Students.Snum and E2.Snum = Students.Snum and S1.ClassName = E1.ClassName and 
S2.ClassName = E2.ClassName and E1.ClassName != E2.ClassName and S1.Time = S2.Time );

------------------------------------------------------------------------
SELECT Name
FROM Students
LEFT JOIN Enrolled ON Students.Snum = Enrolled.Snum
WHERE Enrolled.Snum IS NULL;

SELECT * 
FROM Students 
WHERE Snum NOT IN (SELECT DISTINCT Snum FROM Enrolled);

SELECT * FROM Students 
WHERE Snum NOT IN ( SELECT Snum FROM Enrolled WHERE EXISTS (SELECT c1,c2 FROM Enrolled 
GROUP BY Snum WHERE c1 != c2 AND c1.time = c2.time) );

SELECT DISTINCT S.Name
FROM Students S
LEFT JOIN Enrolled E ON S.Snum = E.Snum
WHERE E.Snum IS NULL;

SELECT Name
FROM Students
WHERE NOT EXISTS (
 SELECT 1
 FROM Enrolled
 WHERE Enrolled.Snum = Students.Snum
);

SELECT s1.name
FROM Students s1
WHERE name NOT IN (SELECT DISTINCT s2.name FROM Students s2 JOIN Enrolled ON 
Enrolled.snum=s2.snum);
----------------------------------------------------------------------------
SELECT Class.ClassName
FROM Class
LEFT JOIN Enrolled ON Class.ClassName = Enrolled.ClassName
GROUP BY Class.ClassName
HAVING COUNT(Enrolled.Snum) < 20 OR COUNT(Enrolled.Snum) IS NULL;



SELECT ClassName FROM Class WHERE ClassName IN (SELECT Class.ClassName FROM Class LEFT JOIN 
Enrolled GROUP BY Class.ClassName HAVING COUNT (Class.ClassName) < 20);

select ClassName from Class where ( select count(*) from Enrolled,Students where 
Class.ClassName=Enrolled.ClassName and Students.Snum=Enrolled.Snum)<20;

select ClassName from Enrolled
group by ClassName
having count(*) < 20;