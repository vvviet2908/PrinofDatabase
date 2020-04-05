CREATE DATABASE Student;
CREATE TABLE Students(
	Sid NVARCHAR(10),
	sname NVARCHAR(30),
	Dob DATE,
	Address NVARCHAR(50),
	ID_card NVARCHAR(12),
	PRIMARY KEY(Sid)
);
CREATE TABLE Course(
	Cid NVARCHAR(10),
	cname NVARCHAR(30),
	credit int
	PRIMARY KEY(Cid)
);
CREATE TABLE Enrolled(
	Sid NVARCHAR(10),
	Cid NVARCHAR(10),
	day DATE,
	PRIMARY KEY(day),
	FOREIGN KEY(Sid) REFERENCES dbo.Students(Sid),
	FOREIGN KEY(Cid) REFERENCES dbo.Course(Cid)
);

