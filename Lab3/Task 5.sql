USE [master]
CREATE DATABASE Employee

USE [Employee]
CREATE TABLE employee(
	employee_name VARCHAR(50),
	street VARCHAR(50),
	city VARCHAR(50),
	PRIMARY KEY (employee_name)
	);

CREATE TABLE works(
	employee_name VARCHAR(50),
	company_name VARCHAR(50),
	salary	INT,
	FOREIGN KEY (employee_name) REFERENCES employee(employee_name)
	);

CREATE TABLE company(
	company_name VARCHAR(50),
	city VARCHAR(50),
	PRIMARY KEY (company_name)
	);

CREATE TABLE manages(
	employee_name VARCHAR(50),
	manager_name VARCHAR(50),
	FOREIGN KEY (employee_name) REFERENCES employee(employee_name)
	);

INSERT INTO dbo.employee( employee_name, street, city )
	VALUES ('Vo Van Viet','No Trang Long','HCM');
INSERT INTO dbo.employee( employee_name, street, city )
	VALUES  ( 'Tran Van B', 'Nguyen Van Troi','Dalat');
INSERT INTO dbo.employee( employee_name, street, city )
	VALUES  ( 'Nguyen Van A', 'Dong Khoi','HCM');
INSERT INTO dbo.employee( employee_name, street, city )
	VALUES  ( 'Do Thi C', 'Ngo Quyen','Dalat');
INSERT INTO dbo.employee( employee_name, street, city )
	VALUES  ( 'Nguyen Van D', 'Dong Khoi','HCM');

INSERT INTO dbo.works (employee_name, company_name, salary)
	VALUES ('Vo Van Viet', 'Nielsen', 100000);
INSERT INTO dbo.works (employee_name, company_name, salary)
	VALUES ('Tran Van B', 'Small Bank Corporation', 50000);
INSERT INTO dbo.works (employee_name, company_name, salary)
	VALUES ('Nguyen Van A', 'First Bank Corporation', 25000);
INSERT INTO dbo.works (employee_name, company_name, salary)
	VALUES ('Do Thi C', 'Small Bank Corporation', 7500);
INSERT INTO dbo.works (employee_name, company_name, salary)
	VALUES ('Nguyen Van D', 'First Bank Corporation', 10000);

INSERT INTO dbo.company( company_name, city ) 
	VALUES  ( 'First Bank Corporation','HCM' );
INSERT INTO dbo.company( company_name, city ) 
	VALUES  ( 'Small Bank Corporation','HCM' );
INSERT INTO dbo.company( company_name, city ) 
	VALUES  ( 'Nielsen','HCM' );
INSERT INTO dbo.company( company_name, city ) 
	VALUES  ( 'Unilever','HCM' );
INSERT INTO dbo.company( company_name, city ) 
	VALUES  ( 'Golden Gate','Dalat' );

INSERT INTO dbo.manages(employee_name, manager_name)
	VALUES ('Vo Van Viet', 'Mark'); 
INSERT INTO dbo.manages(employee_name, manager_name)
	VALUES ('Tran Van B', 'Juan'); 
INSERT INTO dbo.manages(employee_name, manager_name)
	VALUES ('Nguyen Van A', 'Hoang Thi E'); 
INSERT INTO dbo.manages(employee_name, manager_name)
	VALUES ('Do Thi C', 'David'); 
INSERT INTO dbo.manages(employee_name, manager_name)
	VALUES ('Nguyen Van D', 'Nguyen Van A'); 

--a/ Find the names of all employees who work for First Bank Corporation. 
SELECT employee_name FROM works WHERE company_name='First Bank Corporation';

--b/ Find the names and cities of residence of all employees who work for First Bank Corporation
SELECT DISTINCT E.employee_name, E.city FROM employee E, works W
WHERE E.employee_name = W.employee_name AND W.company_name = 'First Bank Corporation';

--c/Find the names, street addresses, and cities of residence of all employees who work for First Bank Corporation and earn more than $10,000
SELECT E.employee_name, E.street, E.city FROM employee E, works W
WHERE E.employee_name = W.employee_name 
AND W.company_name = 'First Bank Corporation'
AND W.salary > '10000';

--d/Find all employees in the database who live in the same cities as the companies for which they work.
SELECT E.employee_name FROM employee E, works W, company C
WHERE E.employee_name = W.employee_name 
AND E.city = C.city
AND W.company_name = C.company_name;

--e/Find all employees in the database who live in the same cities and on the same streets as do their managers
SELECT E1.employee_name FROM employee E1, employee E2, manages M
WHERE E1.employee_name = M.employee_name
AND E2.employee_name = M.manager_name 
AND E1.city = E2.city 
AND E1.street = E2.street;

--f/Find all employees in the database who do not work for First Bank Corporation. 
SELECT employee_name FROM works
WHERE company_name <> 'First Bank Corporation';

--g/ Find all employees in the database who earn more than each employee of Small Bank Corporation.
SELECT employee_name FROM works
WHERE salary > ALL(SELECT salary FROM works WHERE company_name='Small Bank Corporation');

--h/Assume that the companies may be located in several cities. Find all companies located in every city in which Small Bank Corporation is located.
SELECT C1.company_name
FROM company C1
WHERE  not exists (
(SELECT city
 FROM  company
 WHERE  company_name = 'First Bank Corporation')
EXCEPT 
(SELECT C2.city
FROM company C2
WHERE C1.company_name = C2.company_name));

--i/ Find all employees who earn more than the average salary of all employees of their company. 
SELECT W1.employee_name
FROM works W1
WHERE salary>(SELECT AVG(W2.salary)
					FROM works W2 WHERE W1.company_name=W2.company_name);
--j/ Find the company that has the most employees
SELECT company_name FROM works
GROUP BY company_name
HAVING COUNT(DISTINCT employee_name)>=all(SELECT COUNT(DISTINCT employee_name) 
										FROM Works
										GROUP BY company_name);

--k/Find the company that has the smallest payroll.
SELECT w1.company_name
FROM works w1
GROUP BY w1.company_name
HAVING sum(w1.salary) <= ALL(SELECT SUM(w2.salary) 
							FROM works w2
							GROUP BY w2.company_name);

--l/Find those companies whose employees earn a higher salary, on average, than the average salary at First Bank Corporation
SELECT company_name
FROM works
GROUP BY company_name
HAVING avg(salary)>(SELECT avg(salary)
FROM  works
WHERE company_name='First Bank Corporation');


