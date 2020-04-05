CREATE DATABASE testDB;
CREATE TABLE CUSTOMERS(
   ID   INT              NOT NULL,
   NAME VARCHAR (20)     NOT NULL,
   AGE  INT              NOT NULL,
   ADDRESS  CHAR (25) ,
   SALARY   DECIMAL (18, 2),       
   PRIMARY KEY (ID)
);
INSERT INTO dbo.CUSTOMERS
        ( ID, NAME, AGE, ADDRESS, SALARY )
VALUES  ( 123, -- ID - int
          'Viet', -- NAME - varchar(20)
          20, -- AGE - int
          'Dalat', -- ADDRESS - char(25)
          500  -- SALARY - decimal
          );
INSERT INTO dbo.CUSTOMERS
        ( ID, NAME, AGE, ADDRESS, SALARY )
VALUES  ( 233, -- ID - int
          'Dan', -- NAME - varchar(20)
          20, -- AGE - int
          'Baoloc', -- ADDRESS - char(25)
          NULL  -- SALARY - decimal
          );
SELECT * FROM dbo.CUSTOMERS;