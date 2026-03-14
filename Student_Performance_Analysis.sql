CREATE DATABASE EDUCATION;

USE EDUCATION;

CREATE TABLE STUDENT(
ID INT PRIMARY KEY,
NAME VARCHAR(50),
MARKS INT NOT NULL,
GRADE VARCHAR(5)
);

INSERT INTO STUDENT
(ID,NAME,MARKS,GRADE)
VALUES
(101,'GANESH',367,"A"),
(102,'GAURAV',556,"O"),
(103,'PRINCE',455,"A+"),
(104,'RANJEET',453,"A+");

SELECT * FROM STUDENT;

--- 30 SQL Analysis Questions on STUDENT Table
# 1. Show all records from the STUDENT table.
SELECT * FROM Student;

# 2. Display only NAME and MARKS columns.
SELECT Name, Marks
FROM Student;

# 3. Find all students who scored more than 400 marks.
SELECT ID, Name, Marks
FROM Student
WHERE Marks > 400
ORDER BY Marks;

# 4. Find all students who scored less than 500 marks.
SELECT ID, Name, Marks
FROM Student
WHERE Marks < 500
ORDER BY Marks DESC;

# 5. Show students who got grade 'A+'.
SELECT ID, Name,Grade
FROM Student
WHERE Grade = 'A+';

# 6. Find the highest marks scored in the class.
SELECT ID, Name, Marks
FROM Student
ORDER BY Marks DESC
LIMIT 1;

SELECT MAX(Marks) Highest_Marks
FROM Student;

# 7. Find the lowest marks scored in the class.
SELECT ID,Name, Marks
FROM Student
ORDER BY Marks
LIMIT 1;

SELECT MIN(Marks) AS Lowest_Marks
FROM Student;

# 8. Find the total number of students in the table.
SELECT COUNT(*) AS Total_Students
FROM Student;

# 9. Find the average marks of all students.
SELECT ROUND(AVG(Marks),2) AS Avg_Marks
FROM Student;

# 10. Find the sum of all marks in the class.
SELECT SUM(Marks) AS Total_Marks
FROM Student;

# 11. Show the details of the student who scored the highest marks.
SELECT ID, Name, Marks
FROM Student 
WHERE Marks = (SELECT Max(Marks)
			   FROM Student);
		
# 12. Show the details of the student who scored the lowest marks.
SELECT ID, Name, Marks
FROM Student
WHERE Marks = (SELECT MIN(Marks)
               FROM Student);
               
# 13. Find students whose marks are greater than the average marks of the class.
SELECT ID, Name, Marks
FROM Student
WHERE Marks > (SELECT AVG(Marks)
               FROM Student);

# 14. Find students whose marks are less than the average marks of the class.
SELECT ID, Name, Marks
FROM Student
WHERE Marks < (SELECT AVG(Marks)
               FROM Student);

# 15. Count how many students are there in each grade.
SELECT Grade, COUNT(*) Total_Students
FROM Student
GROUP BY Grade;

# 16. Find the average marks for each grade.
SELECT Grade, ROUND(AVG(Marks)) Avg_Marks
FROM Student
GROUP BY Grade;

# 17. Find the maximum marks in each grade.
SELECT Grade, MAX(Marks) AS  Maximum_Marks
FROM Student
GROUP BY Grade;

# 18. Find the minimum marks in each grade.
SELECT Grade, MIN(Marks) Minimun_Marks
FROM Student
GROUP BY Grade;

# 19. Display all students sorted by marks in descending order.
SELECT Name,Marks
FROM Student
ORDER BY Marks DESC;

# 20. Display all students sorted by name in ascending order.
SELECT Name 
FROM Student
ORDER BY Name;

# 21. Find the second highest marks in the table.
SELECT MAX(Marks) Second_Highest_Marks
FROM Student
WHERE Marks <(SELECT MAX(Marks) FROM Student);

# 22. Show the details of the student who scored the second highest marks.
SELECT ID, Name,Marks 
FROM Student
WHERE Marks = (SELECT MAX(Marks) Second_Highest_Marks
			   FROM Student
               WHERE Marks <(SELECT MAX(Marks) FROM Student));

# 23. Rank all students based on their marks from highest to lowest.
SELECT ID,NAME,Marks,
RANK() OVER(ORDER BY Marks DESC) AS 'Rank'
FROM Student;

# 24. Assign a dense rank to all students based on marks.
SELECT ID, Name, Marks,
DENSE_RANK() OVER(ORDER BY Marks DESC) AS 'Rank'
FROM Student;

# 25. Find the difference between each student’s marks and the highest marks in the class.
SELECT ID,NAME,Marks,
MAX(Marks) OVER() 'Highest_Marks',
MAX(Marks) OVER() - Marks AS 'Std_diff_marks'
FROM Student;



# 26. Find the difference between each student’s marks and the average marks of the class.
SELECT ID, Name, Marks,
AVG(Marks) OVER() AS 'Avg_Marks',
AVG(Marks) OVER() - Marks AS 'Avg_Mark_Diff'
FROM Student;

# 27. Show each student’s marks as a percentage of total class marks.
SELECT ID,Name,Marks,ROUND(Marks / (SELECT SUM(Marks) FROM Student) * 100) AS 'Percentage'
FROM Student;


# 28. Categorize students into: Excellent → marks >= 500, Good → marks between 450 and 499, Average → marks below 450, else Low.
SELECT ID, Name, Marks,
CASE
    WHEN Marks >= 500 THEN 'Excellent'
	WHEN Marks > 450 AND Marks < 500 THEN 'Good'
    WHEN Marks < 450 THEN 'Average'
END AS 'Performance'
FROM Student;

# 29. Count how many students fall into each performance category (Excellent / Good / Average).
SELECT 
CASE
    WHEN Marks >= 500 THEN 'Excellent'
	WHEN Marks > 450 AND Marks < 500 THEN 'Good'
    WHEN Marks < 450 THEN 'Average'
END AS 'Performance', COUNT(*) AS 'Total_Student'
FROM Student
GROUP BY CASE
    WHEN Marks >= 500 THEN 'Excellent'
	WHEN Marks > 450 AND Marks < 500 THEN 'Good'
    WHEN Marks < 450 THEN 'Average'
END;

# 30. Create a report showing: NAME, MARKS, GRADE, RANK, Performance Category, Above Average / Below Average
SELECT Name, Marks, Grade,
RANK() OVER(ORDER BY Marks DESC) as 'Rank',
CASE
    WHEN Marks >= 500 THEN 'Excellent'
	WHEN Marks > 450 AND Marks < 500 THEN 'Good'
    WHEN Marks < 450 THEN 'Average'
END AS 'Performance_Category',
CASE 
    WHEN Marks > (SELECT AVG(Marks) FROM Student) THEN 'Above_Avg'
    ELSE 'Below_Avg'
END AS 'Comparision'
FROM Student;


