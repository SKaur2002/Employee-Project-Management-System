-- 20 January 2025
Create database CompanyDB;

Use CompanyDB;

Create table Employees
( EmployeeID int Primary Key,
  FirstName varchar(20),
  LastName varchar(20),
  DateOfBirth date,
  Gender varchar(6),
  DepartmentID varchar(10),
  HireDate date,
  Salary decimal(10,2));
  
Create table Departments
( DepartmentID varchar(10) Primary Key,
  DepartmentName varchar(20),
  ManagerID varchar(10)
);

Create table Projects
( ProjectID varchar(10) Primary Key,
  ProjectName varchar(30),
  StartDate Date,
  EndDate Date,
  Budget decimal(10,2)
);

Create Table EmployeeProjects
( EmployeeID int,
 ProjectsID varchar(10),
HoursWorked int
);


INSERT INTO Employees VALUES
(1, 'John', 'Doe', '1985-06-15', 'Male', 'D001', '2010-01-05', 75000.00),
(2, 'Jane', 'Smith', '1990-11-20', 'Female', 'D002', '2015-03-22', 68000.00),
(3, 'Mike', 'Johnson', '1988-09-10', 'Male', 'D001', '2012-07-18', 72000.00),
(4, 'Emily', 'Davis', '1992-05-25', 'Female', 'D003', '2018-10-01', 65000.00),
(5, 'Chris', 'Brown', '1980-01-15', 'Male', 'D002', '2008-09-12', 85000.00),
(6, 'Sarah', 'Wilson', '1995-03-14', 'Female', 'D003', '2020-02-11', 59000.00),
(7, 'David', 'Taylor', '1987-07-08', 'Male', 'D004', '2013-11-05', 70000.00),
(8, 'Anna', 'Moore', '1993-12-22', 'Female', 'D001', '2017-06-25', 64000.00),
(9, 'James', 'Anderson', '1982-04-04', 'Male', 'D004', '2009-05-15', 87000.00),
(10, 'Laura', 'Thomas', '1991-08-19', 'Female', 'D002', '2016-01-30', 67000.00);

INSERT INTO Departments VALUES
('D001', 'HR', 'M1'),
('D002', 'Finance', 'M2'),
('D003', 'IT', 'M3'),
('D004', 'Marketing', 'M4');


INSERT INTO Projects VALUES
('P001', 'Website Redesign', '2023-01-15', '2023-06-30', 25000.00),
('P002', 'App Development', '2023-02-01', '2023-12-31', 50000.00),
('P003', 'Marketing Campaign', '2023-03-01', '2023-09-30', 30000.00),
('P004', 'Cloud Migration', '2023-04-15', '2023-10-31', 40000.00),
('P005', 'Data Analysis', '2023-05-01', '2023-11-15', 35000.00);



INSERT INTO EmployeeProjects VALUES
(1, 'P001', 120),
(2, 'P002', 150),
(3, 'P001', 100),
(4, 'P003', 140),
(5, 'P004', 160),
(6, 'P002', 110),
(7, 'P005', 130),
(8, 'P003', 100),
(9, 'P004', 200),
(10, 'P005', 170);

-- Select only the FirstName and Salary of employees whose salaries are above 50,000.
Select FirstName, Salary from Employees where Salary>50000;

-- List the distinct departments in the Departments table.
Select distinct DepartmentName from Departments;

-- Retrieve the FirstName and LastName of all employees who were hired after January 1, 2020.
Select FirstName, LastName , HireDate from Employees where HireDate>'2020-01-1';

-- Find the top 5 highest-paid employees.
Select FirstName, LastName , Salary from Employees Order by Salary DESC limit 5;

-- Retrieve all female employees and sort them by their LastName in ascending order.
Select FirstName, LastName from Employees where Gender = 'Female' Order by LastName;
 
-- List employees in the "Finance" department who earn more than 60,000.
-- First way 
Select * from Departments;
Select FirstName , LastName , DepartmentID , Salary from Employees where DepartmentID ='D002' and Salary > 60000 ;

-- Second way
Select e.FirstName, e.LastName , e.DepartmentID , e.Salary
from Employees e
Join Departments d ON e.DepartmentID = d.DepartmentID
Where DepartmentName = 'Finance' and Salary > 60000;

-- Calculate the total number of employees in each department.
-- First way 
Select DepartmentID , count(*) AS 'No_of_Employees' from Employees group by DepartmentID;

-- Second Way   
SELECT e.DepartmentID, d.DepartmentName, count(*) AS 'No_of_Employees'
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY e.DepartmentID, d.DepartmentName;

-- Find the average salary of employees in the "IT" department.
-- First way 
Select * from Departments;
Select avg(Salary) from Employees where DepartmentID ='D003';

-- Second way
-- AVG() function requires grouping when other columns are selected.
Select d.DepartmentName, e.DepartmentID, avg(e.Salary) as 'Avg Salary'
from Employees e
Join Departments d ON e.DepartmentID = d.DepartmentID
Where DepartmentName = 'IT'
GROUP BY d.DepartmentName, e.DepartmentID;

-- Identify the department with the highest average salary.
Select d. DepartmentName , e.DepartmentID, Avg(e.Salary) as 'Average Salary' 
from Employees e
Join Departments d ON e.DepartmentID = d.DepartmentID
group by DepartmentID Order by Avg(Salary) desc limit 1;

-- Count the total hours worked by all employees on all projects.
SELECT p.ProjectName, SUM(ep.HoursWorked) AS 'Total Hours Worked'
FROM EmployeeProjects ep
JOIN Projects p ON ep.ProjectsID = p.ProjectID
GROUP BY p.ProjectName;

-- join Employees and Departments to display employee names along with their department names.
Select e.FirstName , e.Lastname , d.DepartmentName, d.DepartmentID
From Employees e
Join Departments d ON e.DepartmentID = d.DepartmentID;

-- Join Employees and EmployeeProjects to find out which projects each employee is working on.
Select e.FirstName , e.Lastname , ep.ProjectsID as ProjectID , p.ProjectName
From Employees e
Join EmployeeProjects ep ON e.EmployeeID = ep.EmployeeID
Join Projects p ON p.ProjectID = ep.ProjectsID;

-- Join Employee , Projects and employeeProjects to get employee woking on data analysis Project
Select e.FirstName , e.Lastname , ep.ProjectsID as ProjectID , p.ProjectName
From Employees e
Join EmployeeProjects ep ON e.EmployeeID = ep.EmployeeID
Join Projects p ON p.ProjectID = ep.ProjectsID
Where ProjectName = 'Data Analysis';


-- Combine Projects and EmployeeProjects to list project names and the total hours worked on each project.
Select ep.ProjectsID as ProjectID , p.ProjectName , ep.HoursWorked
From Projects p
Join EmployeeProjects ep ON p.ProjectID = ep.ProjectsID;

-- Find employees who earn more than the average salary of all employees.
Select FirstName, LastName , Salary from Employees where Salary > (Select Avg(Salary) from Employees );

-- List employees who work in departments managed by "John Doe".
Select e.FirstName, e.LastName , e.DepartmentID , d.DepartmentName 
from Employees e
Join Departments d ON d.DepartmentID=e.DepartmentID
where e.DepartmentID = (Select DepartmentID from Employees where FirstName='John' and LastName = 'Doe');

-- Identify projects that started after the oldest employee's hire date.
Select ProjectID, ProjectName from Projects Where StartDate > (Select HireDate from Employees order by Hiredate ASC limit 1);


-- 21 January 2025

-- Total salary expenditure for the entire company.
Select Sum(Salary) as 'Total Salary Expenditure' from Employees;

-- Average hours worked by employees on each project.
Select ep.ProjectsID,  p.ProjectName, Avg(ep.HoursWorked) as 'Average Hours Worked'
from EmployeeProjects ep
Join Projects p ON p.ProjectID = ep.ProjectsID
Group by ProjectID;

-- Determine the maximum and minimum salaries in each department.
Select e.DepartmentID, d.DepartmentName , MIN(e.Salary) as 'Min Salary' , MAX(e.Salary) as 'Max Salary'
from Employees e
Join Departments d ON d.DepartmentID = e.DepartmentID
Group by DepartmentID;

-- Count the number of employees hired in each year.
Select Count(*) as 'Total Employees Hired per year' , Year(HireDate) from Employees Group by Year(HireDate);

-- Compute the total budget utilization for all projects.
Select Sum(Budget) as 'Total budget utilization' From Projects;

-- Add a CHECK constraint to ensure that employees' salaries cannot be less than 30,000.
ALTER TABLE Employees ADD CONSTRAINT CHK_Salary CHECK (Salary >= 30000);

-- Create a view called HighEarners that lists employees earning more than 70,000, along with their department names.
Create view HighEarningEmployees as
Select e. EmployeeID , e.FirstName , e.LastName , d.DepartmentID , d.DepartmentName , e.Salary
from Employees e
Join Departments d ON d.DepartmentID = e.DepartmentID
where e.Salary > 70000;

Select * from HighEarningEmployees;

-- query using the HighEarners view to retrieve the total number of high-earning employees.
Select Count(*) as 'Total High Earning Employees' from HighEarningEmployees;

-- Define a view DepartmentSummary that displays department names, total employees, and average salary in each department.
Create view DepartmentSummary as
Select d.DepartmentName , Count(e.EmployeeID) as 'Total Employees' , Avg(e.Salary) as 'Average Salary' 
From Employees e
Join Departments d ON d.DepartmentID = e.DepartmentID
Group by d.DepartmentID;

Select * from DepartmentSummary;

-- Create a view ProjectDetails that includes project names, total hours worked, and total number of employees working on each project.
Create view ProjectDetails as
Select p.ProjectID , p.ProjectName , sum(ep.HoursWorked) as 'Total Hours Worked' 
from Projects p
Join EmployeeProjects ep ON p.ProjectID = ep.ProjectsID
Group by p.ProjectID;

Select * from ProjectDetails;

-- Create an index on the LastName column in the Employees table to optimize searches.
CREATE INDEX idx_LastName ON Employees(LastName);

EXPLAIN SELECT * FROM Employees WHERE LastName = 'Smith';

-- Updates the salary of an employee based on their EmployeeID and the new salary value.
Delimiter //
Create Procedure UpdateSalary(IN empID int, IN newSalary Decimal(10,2))
Begin
     Update Employees
     Set Salary=newSalary
     Where EmployeeID=empID;
END //
Delimiter //

Call UpdateSalary(3,35700);

Select * from Employees where EmployeeID = 3;

 -- Retrieves an employee's project details based on their EmployeeID.
Delimiter //
Create procedure EmployeeProjectSummary(IN empID int)
Begin
     Select e.EmployeeID, e.FirstName , e.LastName , e.Salary , p.ProjectID , p.ProjectName , ep.HoursWorked
     from Employees e
     join EmployeeProjects ep on ep.EmployeeID = e.EmployeeID
     join Projects p on p.ProjectID = ep.ProjectsID
     Where e.EmployeeID=empID;
END //
Delimiter ;

call EmployeeProjectSummary(4); 

-- Total Salary Expenditure
DELIMITER //
CREATE PROCEDURE CalculateTotalSalary(IN deptID Varchar(10),OUT totalSalary DECIMAL(10, 2))
BEGIN
    Set totalSalary = 0 ;
    SELECT SUM(Salary) INTO totalSalary
    FROM Employees
    WHERE DepartmentID = deptID;
END //
DELIMITER ;

SET @totalSalary = 0;
call CalculateTotalSalary ('D003' , @totalSalary);
SELECT @totalSalary AS TotalSalaryExpenditure;

-- Total Hours Worked on a Project
DELIMITER //
CREATE PROCEDURE TotalHoursWorked(IN projectID varchar(10), OUT totalHours INT)
BEGIN
    Set totalHours = 0;
    SELECT SUM(HoursWorked) INTO totalHours
    FROM EmployeeProjects
    WHERE ProjectID = projectID;
END //
DELIMITER ;
Set @totalHours = 0;
CALL TotalHoursWorked('P003', @totalHours);
SELECT @totalHours AS TotalHoursWorked;

-- Trigger to Prevent Negative Salary
DELIMITER //
CREATE TRIGGER PreventNegativeSalary
BEFORE UPDATE ON Employees
FOR EACH ROW
BEGIN
    IF NEW.Salary < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary cannot be negative.';
    END IF;
END //

-- This should throw an error
UPDATE Employees SET Salary = -5000 WHERE EmployeeID = 1;


-- Trigger to log new employee
DELIMITER //

CREATE TRIGGER LogNewEmployee
AFTER INSERT ON Employees
FOR EACH ROW
BEGIN
    INSERT INTO EmployeeLog (EmployeeID, FullName, ActionDate)
    VALUES (NEW.EmployeeID, CONCAT(NEW.FirstName, ' ', NEW.LastName), NOW());
END //

DELIMITER ;

CREATE TABLE EmployeeLog (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT,
    FullName VARCHAR(100),
    ActionDate DATETIME
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, DateOfBirth, Gender, DepartmentID, HireDate, Salary)
VALUES (101, 'John', 'Smith', '1990-05-15', 'Male', 'D001', '2023-01-10', 75000);

-- Check the log table
SELECT * FROM EmployeeLog;

-- Retrieve employees whose names start with the letter 'A'.
Select * from Employees where FirstName Like 'A%';

-- Retrieve employees whose last names end with 'n'.
Select * from Employees where FirstName Like '%a';

-- Retrieve customers whose names have exactly five characters and start with 'J'.
Select * from Employees where LastName Like 'M____';

-- Find all employees whose names do not start with 'A'.
Select * from Employees where LastName not like 'T%';

-- Find all employees who were hired in specific year
SELECT * FROM Employees WHERE HireDate LIKE '2013%';

-- case statement
SELECT EmployeeID, FirstName, LastName, Salary,
       CASE 
           WHEN Salary >= 80000 THEN 'High Salary'
           WHEN Salary >= 50000 THEN 'Medium Salary'
           ELSE 'Low Salary'
       END AS SalaryClassification
FROM Employees;

-- if statement
SELECT EmployeeID, FirstName, LastName, Salary,
       IF(Salary >= 50000, Salary * 0.10, Salary * 0.05) AS Bonus
FROM Employees;

-- between statement
SELECT * FROM Employees WHERE Salary BETWEEN 50000 AND 66000;

SELECT * FROM Employees WHERE HireDate BETWEEN '2018-01-01' AND '2023-12-31';

SELECT * FROM Employees
WHERE LastName BETWEEN 'A' AND 'S' order by LastName,EmployeeID asc;



