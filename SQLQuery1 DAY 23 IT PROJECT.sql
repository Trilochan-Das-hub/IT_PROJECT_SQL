create database ITPROJECT;

CREATE TABLE EMPLOYEE (
	EmployeeID INT PRIMARY KEY IDENTITY(1,1),
	EmployeeName VARCHAR(100),
	Department VARCHAR(100),
	Salary DECIMAL(10,2),
	HireDate DATE
);

INSERT INTO EMPLOYEE (EmployeeName, Department, Salary, HireDate)
VALUES 
('TRILOCHAN', 'STRATEGY', 40000, '2023-07-23'),
('Amit Sharma', 'IT', 55000, '2022-01-15'),
('Priya Das', 'HR', 40000, '2021-03-10'),
('Rahul Verma', 'Finance', 60000, '2020-07-20'),
('Sneha Reddy', 'IT', 65000, '2019-11-05'),
('Vikram Singh', 'Marketing', 45000, '2023-02-18'),
('Anjali Mehta', 'Finance', 70000, '2018-09-25'),
('Rohit Kumar', 'IT', 50000, '2022-06-12'),
('Pooja Nair', 'HR', 42000, '2021-12-01'),
('Arjun Patel', 'Marketing', 48000, '2023-04-22'),
('Neha Joshi', 'IT', 75000, '2017-08-30');


UPDATE EMPLOYEE
SET EmployeeName = 'Trilochan Das'
WHERE EmployeeName = 'TRILOCHAN';

SELECT * FROM EMPLOYEE;

CREATE TABLE ProjectManagement (
	ProjectID INT PRIMARY KEY IDENTITY(1,1),
	ProjectName VARCHAR(100),
	EmployeeID INT,
	ProjectStartDate DATE,
	ProjectEndDate DATE,
	Budget DECIMAL(12,2),
	FOREIGN KEY(EmployeeID) REFERENCES Employee(EmployeeID)
);

INSERT INTO ProjectManagement (ProjectName, EmployeeID, ProjectStartDate, ProjectEndDate, Budget) VALUES
('Website Development', 1, '2024-01-01', '2024-06-30', 200000),
('Recruitment Drive', 2, '2024-02-01', '2024-05-30', 50000),
('Financial Audit', 3, '2024-03-15', '2024-07-15', 150000),
('Mobile App Project', 4, '2024-01-20', '2024-08-20', 300000),
('Digital Marketing Campaign', 5, '2024-04-01', '2024-09-30', 120000),
('Investment Planning', 6, '2024-02-10', '2024-06-10', 180000),
('Cloud Migration', 7, '2024-05-01', '2024-12-01', 250000),
('Employee Training', 8, '2024-03-01', '2024-04-30', 40000),
('Product Launch', 9, '2024-06-01', '2024-10-01', 220000),
('Cyber Security Upgrade', 10, '2024-01-10', '2024-07-10', 270000);

SELECT * FROM ProjectManagement;
SELECT * FROM EMPLOYEE;


--Total Project Budget per Department (GROUP BY + JOIN)
SELECT 
	E.Department,
	count(P.ProjectID) AS TotalProjects,
	sum(P.Budget) as Total_Budget
FROM EMPLOYEE E
INNER JOIN ProjectManagement P
ON E.EmployeeID = P. ProjectID
GROUP BY E.Department
ORDER BY Total_Budget DESC;
--Shows which department handles highest budget.


--Highest Paid Employee with Project Details (Subquery)

SELECT
    E.EmployeeName,
    E.Salary,
    P.ProjectName,
    P.Budget
FROM Employee E
INNER JOIN ProjectManagement P
    ON E.EmployeeID = P.EmployeeID
WHERE E.Salary = (SELECT MAX(Salary) FROM Employee);

--MAX SALARY
SELECT MAX(SALARY) FROM EMPLOYEE;
--Check Who Has That Salary
SELECT * FROM EMPLOYEE
WHERE SALARY = 75000;
--Check If That Employee Has Project
SELECT * FROM ProjectManagement
WHERE EmployeeID = 11;

--LEFT JOIN SAME TABLE
SELECT
    E.EmployeeName,
    E.Salary,
    P.ProjectName,
    P.Budget
FROM Employee E
LEFT JOIN ProjectManagement P
    ON E.EmployeeID = P.EmployeeID
WHERE E.Salary = (SELECT MAX(Salary) FROM Employee);
--Finds highest salary employee + their projects.

--Employees Working on More Than 1 Project (HAVING)
SELECT 
	E.EmployeeName,
	count(P.ProjectID) as ProjectCount
FROM EMPLOYEE E
INNER JOIN ProjectManagement P
	ON E.EmployeeID = P.EmployeeID
GROUP BY E.EmployeeName
HAVING COUNT(P.ProjectID) > 1;

--No employee has more than 1 project
SELECT EmployeeID, COUNT(*)
FROM ProjectManagement
GROUP BY EmployeeID;

--Try removing HAVING condition------------Employees Working on More Than 1 Project
SELECT 
    e.EmployeeName,
    COUNT(p.ProjectID) AS ProjectCount
FROM Employee e
INNER JOIN ProjectManagement p
    ON e.EmployeeID = p.EmployeeID
GROUP BY e.EmployeeName;

--Project Duration in Days (DATEDIFF Function)
SELECT 
	ProjectName,
	DATEDIFF(DAY, ProjectStartDate, ProjectEndDate) as Project_Duration
FROM ProjectManagement;

