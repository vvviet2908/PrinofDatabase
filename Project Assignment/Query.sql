/* TOPIC 17 - EMPLOYMENT AGENCY */
--Create Database
USE [master]
GO
IF  EXISTS (SELECT name FROM sys.databases WHERE name = N'EmploymentAgency_17')
DROP DATABASE [EmploymentAgency_17]
GO
CREATE DATABASE EmploymentAgency_17;
--Create tables
USE [EmploymentAgency_17]
GO
CREATE TABLE EMPLOYEE (
	E_ID int,
	E_name nvarchar(225) not null,
	E_address nvarchar(225),
	E_phone nvarchar(10),
	E_email nvarchar(225) not null,
	Primary key(E_ID)
);

CREATE TABLE RESUME (
	R_ID int,
	Expect_salary int,
	Background nvarchar(225),
	Aca_level nvarchar(225), 
	Exp  nvarchar(225) not null,
	E_ID INT FOREIGN KEY REFERENCES EMPLOYEE(E_ID),
	Primary key(R_ID)
);

CREATE TABLE Skills(
	Skill nvarchar(225),
	R_ID INT FOREIGN KEY REFERENCES RESUME(R_ID),
);

CREATE TABLE COMPANY(
	Company_Name nvarchar(225) not null,
	C_Address nvarchar(225) not null,
	C_Email nvarchar(225) not null,
	Rating int not null,
	Field nvarchar(225) not null,
	Primary key (Company_Name)
);

CREATE TABLE STAFF(
	S_ID int,
	S_Email nvarchar(225) not null,
	S_Name nvarchar(225) not null,
	S_Phone int not null,
	Company_Name nvarchar(225) FOREIGN KEY references COMPANY(Company_Name),
	M_ID INT FOREIGN KEY references STAFF(S_ID),
	Primary key(S_ID)
);

CREATE TABLE VACANCY(
	V_ID int,
	Position nvarchar(100) not null,
	Field nvarchar(225) not null,
	Required_Aca_Level nvarchar(225),
	Required_Exp nvarchar(225) not null,
	Start_Salary int not null,
	Publish_day date,
	S_ID int FOREIGN KEY REFERENCES STAFF(S_ID),
	Company_Name nvarchar(225) FOREIGN KEY references COMPANY(Company_Name),
	Primary key(V_ID)
);

CREATE TABLE R_Like(
	R_ID INT FOREIGN KEY REFERENCES RESUME(R_ID),
	S_ID INT FOREIGN KEY REFERENCES STAFF(S_ID),
	Invite nvarchar(225)
);

CREATE TABLE V_Like(
	E_ID INT FOREIGN KEY REFERENCES EMPLOYEE(E_ID),
	V_ID INT FOREIGN KEY references VACANCY(V_ID),
	Apply varchar(225) not null
);

--Input the databto the tables
INSERT INTO dbo.EMPLOYEE
(E_ID,E_name,E_address,E_phone,E_email)
VALUES 
(1,'A','CMT8','0909888808','a@gmail.com'),
(2,'B','NTL','0909999909','b@gmail.com'),
(3,'C','XVNT','0909777707','c@gmail.com')

INSERT INTO EMPLOYEE VALUES 
(4,'D','PVÐ','0909888809','d@gmail.com'),
(5,'E','THÐ','0909999908','e@gmail.com')

INSERT INTO dbo.RESUME
(R_ID,Expect_salary,Background,Aca_level,Exp,E_ID)
VALUES 
(1,700,'Java','doctor','2',1),
(2,800,'SQL','master','2.5',2),
(3,700,'R','bachelor','3',3)

INSERT INTO RESUME VALUES 
(4,700,'C++','master','2',4),
(5,800,'C#','doctor','3.5',5)

INSERT INTO dbo.Skills
(Skill,R_ID)
VALUES 
('Game programming',1),
('Web Programing',2)

INSERT INTO dbo.COMPANY
(Company_Name,C_Address,C_Email,Rating,Field)
VALUES 
('FPT','CMT8','fpt@gmail.com',7,'R'),
('DCSL','NTT','dcsl@gmail.com',8,'C++'),
('DOCKYARD','DBP','dockyard@gmail.com',9,'SQL')

--Update
UPDATE COMPANY 
SET Field = 'C#'
WHERE Company_Name = 'FPT'; 
--Update
UPDATE COMPANY 
SET Field = 'Java'
WHERE Company_Name = 'DOCKYARD'; 
--Input tha data to the tables
INSERT INTO dbo.STAFF
(S_ID,S_Email,S_Name,S_Phone,Company_Name,M_ID)
VALUES 
(1,'s1@gmail.com','S1','0909666606','FPT',1),
(2,'s2@gmail.com','S2','0909555505','DCSL',2),
(3,'s3@gmail.com','S3','0909444404','DOCKYARD',3)

INSERT INTO dbo.VACANCY
(V_ID,Position,Field,Required_Aca_Level,Required_Exp,Start_Salary,Publish_day,S_ID,Company_Name)
VALUES 
(1,'programer','Java','doctor','2',800,'20200420',1,'FPT'),
(2,'Developer','SQL','master','2.5',900,'20200421',2,'DCSL'),
(3,'Analysis','R','bachelor','2',1500,'20191129',3,'DOCKYARD')

INSERT INTO VACANCY VALUES 
(4,'programer','C#','doctor','3',500,'20200401',1,'FPT'),
(5,'Developer','C++','master','2',1000,'20191221',2,'DCSL')


INSERT INTO dbo.R_Like
(R_ID,S_ID,Invite)
VALUES 
(1,1,'Y'),
(2,2,'Y'),
(3,3,'N')

INSERT INTO dbo.V_Like
(E_ID,V_ID,Apply)
VALUES 
(1,1,'programer'),
(2,2,'Developer'),
(4,4,'Analysis')

--Delete the outdate vacancies
DELETE dbo.VACANCY WHERE (YEAR(GETDATE()) - YEAR(Publish_day) > 0) OR (MONTH(GETDATE()) - MONTH(Publish_day) >=2) 

--Select the suitable job 
SELECT va.Company_Name, va.Position, va.Field, va.Required_Aca_Level, va.Required_Exp, va.Start_Salary 
FROM dbo.RESUME AS re, dbo.VACANCY AS va
WHERE re.Expect_salary<=va.Start_Salary AND re.Background = va.Field AND re.Aca_level=va.Required_Aca_Level AND re.Exp>=va.Required_Exp

--Select the employee and the company that have tha same street address
SELECT em.E_name,em.E_address, co.Company_Name
FROM dbo.EMPLOYEE AS em, dbo.COMPANY AS co
WHERE em.E_address = co.C_Address

--Select the jobs that have salary larger than 800 
SELECT va.Position,va.Start_Salary, va.Company_Name
FROM dbo.VACANCY AS va
WHERE va.Start_Salary > 800 

--Select the employees who have background in SQL
SELECT re.R_ID, em.E_Name
FROM dbo.RESUME AS re, dbo.EMPLOYEE AS em
WHERE re.Background = 'SQL' AND re.E_ID = em.E_ID

--Select the employees who have bachelor degree and work experience > 2.5 years
SELECT re.R_ID, em.E_Name
FROM dbo.RESUME AS re, dbo.EMPLOYEE AS em
WHERE re.E_ID = em.E_ID AND re.Aca_level = 'bachelor' AND re.Exp > 2.5