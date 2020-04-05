USE [master]
GO
IF  EXISTS (SELECT name FROM sys.databases WHERE name = N'ApressFinancial')
DROP DATABASE [ApressFinancial]
GO
CREATE DATABASE ApressFinancial 
CONTAINMENT = NONE
 ON  PRIMARY
( NAME = N'ApressFinancial', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\ApressFinancial.mdf' , SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ApressFinancial_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\ApressFinancial_log.ldf' , SIZE = 1072KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO


USE [ApressFinancial]
GO
CREATE SCHEMA TransactionDetails AUTHORIZATION dbo
GO
CREATE SCHEMA ShareDetails AUTHORIZATION dbo
GO
CREATE SCHEMA CustomerDetails AUTHORIZATION dbo

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CustomerDetails].[Customers](
	[CustomerId] [bigint] IDENTITY(1,1) NOT NULL,
	[CustomerTitleId] [int] NOT NULL,
	[CustomerFirstName] [nvarchar](50) NOT NULL,
	[CustomerOtherInitials] [nvarchar](50) NULL,
	[CustomerLastName] [nvarchar](50) NOT NULL,
	[AddressId] [bigint] NOT NULL,
	[AccountNumber] [nvarchar](15) NOT NULL,
	[AccountTypeId] [int] NOT NULL,
	[ClearedBalance] [money] NOT NULL,
	[UnclearedBalance] [money] NOT NULL,
	[DateAddedd] [datetime] NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY NONCLUSTERED 
(
	[CustomerId] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
