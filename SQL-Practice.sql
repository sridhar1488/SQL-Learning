---------- SQL PRACTICE ----------------
/*
Table – EmployeeDetails

EmpId	|FullName		|ManagerId	|DateOfJoining	|City
121		|John Snow		|321		|01/31/2019		|Toronto
321		|Walter White	|986		|01/30/2020		|California
421		|Kuldeep Rana	|876		|27/11/2021		|New Delhi

Table – EmployeeSalary

EmpId	|Project |Salary	|Variable
121		|P1		 |8000		|500
321		|P2		 |10000		|1000
421		|P1		 |12000		|0

*/

 -- SQL query to fetch the EmpId and FullName of all the employees working under the Manager with id – ‘986’.
 SELECT  EmpId, FullName FROM EmployeeDetails WHERE ManagerId = 986;

 --SQL query to fetch the different projects available from the EmployeeSalary table.
SELECT DISTINCT(Project) FROM EmployeeSalary; --(usisg the distinct clause to get the unique values of the Project)

-- SQL query to fetch the count of employees working in project ‘P1’.
SELECT COUNT(*) FROM EmployeeSalary WHERE Project = 'P1';

-- SQL query to find the maximum, minimum, and average salary of the employees.
SELECT Max(Salary), Min(Salary), AVG(Salary) FROM EmployeeSalary;

-- SQL query to find the employee id whose salary lies in the range of 9000 and 15000.

SELECT EmpId, Salary
FROM EmployeeSalary
WHERE Salary BETWEEN 9000 AND 15000; -- (To get values by the range BETWEEN operators can be used)

-- SQL query to fetch those employees who live in Toronto and work under the manager with ManagerId – 321.

SELECT EmpId, City, ManagerId
FROM EmployeeDetails
WHERE City='Toronto' AND ManagerId='321';

-- SQL query to fetch all the employees who either live in California or work under a manager with ManagerId – 321

SELECT EmpId, City, ManagerId
FROM EmployeeDetails
WHERE City='California' OR ManagerId='321';

-- SQL query to fetch all those employees who work on Projects other than P1.

SELECT EmpId
FROM EmployeeSalary
WHERE Project <> 'P1';

-- SQL query to display the total salary of each employee adding the Salary with Variable value.

SELECT EmpId,
Salary+Variable as TotalSalary 
FROM EmployeeSalary;

-- SQL query to fetch the employees whose name begins with any two characters, followed by a text “hn” and ends with any sequence of characters.

SELECT FullName
FROM EmployeeDetails
WHERE FullName LIKE ‘__hn%’;

-- SQL query to fetch the EmpIds that are present in EmployeeDetails but not in EmployeeSalary. (Sub Queries)
SELECT EmpId FROM 
EmployeeDetails 
where EmpId Not IN 
(SELECT EmpId FROM EmployeeSalary);

-- SQL query to fetch only the first name(string before space) from the FullName column of the EmployeeDetails table.
SELECT MID(FullName, 1, LOCATE(' ',FullName)) FROM EmployeeDetails;

SELECT SUBSTRING(FullName, 1, CHARINDEX(' ',FullName)) FROM EmployeeDetails;

-- SQL query to fetch all the Employee details from the EmployeeDetails table who joined in the Year 2020.

SELECT * FROM EmployeeDetails
WHERE DateOfJoining BETWEEN '2020/01/01' AND '2020/12/31';

SELECT * FROM EmployeeDetails WHERE YEAR(DateOfJoining) = '2020'; -- MySQL

-- SQL query to fetch the project-wise count of employees sorted by project’s count in descending order.
SELECT Project, count(EmpId) EmpProjectCount
FROM EmployeeSalary
GROUP BY Project
ORDER BY EmpProjectCount DESC;

-- SQL query to fetch employee names and salary records. Display the employee details even if the salary record is not present for the employee.
SELECT E.FullName, S.Salary 
FROM EmployeeDetails E 
LEFT JOIN 
EmployeeSalary S
ON E.EmpId = S.EmpId;

-- SQL query to fetch all the Employees who are also managers from the EmployeeDetails table. 
SELECT DISTINCT E.FullName
FROM EmployeeDetails E
INNER JOIN EmployeeDetails M
ON E.EmpID = M.ManagerID;



-- SQL query to fetch top n records. (SINGLE ROW FUNCTIONS if N=1)
SELECT *
FROM EmployeeSalary
ORDER BY Salary DESC LIMIT 5; -- MySQL

SELECT TOP 1 *
FROM EmployeeSalary
ORDER BY Salary DESC; -- MS SQL

-- SQL query to find the nth highest salary from a table.

SELECT TOP 1 Salary
FROM (
      SELECT DISTINCT TOP N Salary
      FROM Employee
      ORDER BY Salary DESC
      )
ORDER BY Salary ASC;


-- SQL query to fetch records that are present in one table but not in another table.
/*
Table1 (id, name)
Table2 (id, name)
*/ 

--Select all the records of Table A  which are not in table B using join
--Select all the records of Table B which are not in table A using join


SELECT A.id, A.name
FROM Table1 AS A
LEFT JOIN Table2 AS B
ON A.id = B.id
WHERE B.id IS NULL

SELECT B.id, B.name
FROM Table2 AS B
LEFT JOIN Table1 AS A
ON B.id = A.id
WHERE A.id IS NULL


/* Table: employees
EMPNO	ENAME	MGR	HIREDATE		SAL		DEPTNAME
1		JHON	3	12/17/1990		800		BANKING
2		MILEN		2/20/1991		1600	INSURANCE
3		CARD	1 	2/22/1991		1250	BANKING
*/ 
 
--Find the department with highest number of employees.
SELECT TOP 1 DEPTNAME, COUNT (*) AS NUM_EMPLOYEES
FROM employees
GROUP BY DEPTNAME
ORDER BY COUNT (*) DESC; 



/*
Consider a table Transactions with columns – TransactionID, CustomerID, ProductID, TransactionDate, Amount. 
Write a query to find the total transaction amount for each month.
*/

SELECT MONTH(TransactionDate) AS Month, 
SUM(Amount) AS TotalAmount 
FROM Transactions 
GROUP BY MONTH(TransactionDate);

/*
Consider a table EmployeeAttendance with columns – AttendanceID, EmployeeID, Date, Status. 
Write a query to find employees with more than 5 absences in a month. */

SELECT EmployeeID, 
MONTH(Date) AS Month, 
COUNT(*) AS Absences 
FROM EmployeeAttendance 
WHERE Status = 'Absent' 
GROUP BY EmployeeID, MONTH(Date) 
HAVING COUNT(*) > 5;

/*
Consider a table FoodOrders with columns – OrderID, TableID, MenuItemID, OrderTime, Quantity. 
Write a query to find the most ordered menu item. */

SELECT MenuItemID 
FROM FoodOrders 
GROUP BY MenuItemID 
ORDER BY COUNT(*) DESC LIMIT 1;

/*
For a table FlightBookings with columns – BookingID, FlightID, PassengerID, BookingDate, TravelDate, Class, 
write a query to count the number of bookings for each flight class. */

SELECT Class, COUNT(*) AS NumberOfBookings 
FROM FlightBookings 
GROUP BY Class;

/*
Consider a table PatientVisits with Columns VisitID, PatientID, DoctorID, VisitDate, Diagnosis. 
Write a query to find the latest visit date for each patient. */

SELECT PatientID, MAX(VisitDate) AS LatestVisitDate 
FROM PatientVisits 
GROUP BY PatientID;

/* Consider a table OrderDetails with columns – OrderID, CustomerID, ProductID, OrderDate, Quantity, Price. 
Write a query to find the average order value for each customer. */

SELECT CustomerID, AVG(Quantity * Price) AS AvgOrderValue 
FROM OrderDetails 
GROUP BY CustomerID;

/* Consider a SalesData with columns SaleID, ProductID, RegionID, SaleAmount. 
Write a query to find the total sales amount for each product in each region. */

SELECT ProductID, RegionID, SUM(SaleAmount) AS TotalSales 
FROM SalesData 
GROUP BY ProductID, RegionID;

-- SQL a query to find employees who earn more than their managers. 

SELECT E.Name AS EmployeeName, 
M.Name AS ManagerName, 
E.Salary AS EmployeeSalary, 
M.Salary AS ManagerSalary 
FROM EmployeeDetails E JOIN EmployeeDetails M 
ON E.ManagerID = M.EmployeeID 
WHERE E.Salary > M.Salary;

/* Consider a StudentGrades table with columns – StudentID, CourseID, Grade. 
Write a query to find students who have scored an ‘A’ in more than three courses. */

SELECT StudentID FROM StudentGrades 
WHERE Grade = 'A' 
GROUP BY StudentID 
HAVING COUNT(*) > 3;