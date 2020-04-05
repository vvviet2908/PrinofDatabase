USE [ApressFinancial]
GO

INSERT INTO [ShareDetails].[Shares]
           ([ShareDesc]
           ,[ShareTickerId]
           ,[CurrentPrice])
     VALUES
           (<ShareDesc, nvarchar(50),>
           ,<ShareTickerId, nvarchar(50),>
           ,<CurrentPrice, numeric(18,5),>)
GO


SET QUOTED_IDENTIFIER OFF 
GO 
INSERT INTO [ApressFinancial].[ShareDetails].[Shares] 
		([ShareDesc] ,
		[ShareTickerId] ,
		[CurrentPrice])
		VALUES 
		("ACME'S HOMEBAKE COOKIES INC",
		'AHCI',
		2.34125) 

INSERT INTO [ApressFinancial].[ShareDetails].[Shares] 
			([ShareDesc]  ,
			[CurrentPrice])
			VALUES ("ACME'S HOMEBAKE COOKIES INC",
			2.34125) 
 
USE ApressFinancial
GO
ALTER TABLE CustomerDetails.CustomerProducts
ADD CONSTRAINT PK_CustomerProducts
PRIMARY KEY CLUSTERED (CustomerFinancialProductId) 
ON [PRIMARY]
GO 

ALTER TABLE CustomerDetails.CustomerProducts WITH NOCHECK 
ADD CONSTRAINT CK_CustProds_AmtCheck 
CHECK ((AmountToCollect > 0)) 
GO

ALTER TABLE CustomerDetails.CustomerProducts WITH NOCHECK
ADD CONSTRAINT DF_CustProd_Renewable
DEFAULT (0) 
FOR Renewable

INSERT INTO CustomerDetails.CustomerProducts 
(CustomerFinancialProductId,CustomerId,FinancialProductId ,AmountToCollect,Frequency, LastCollected,LastCollection,Renewable) 
VALUES (1,1,1,-100,0,'24 Aug 2005','24 Aug 2005',0)

INSERT INTO CustomerDetails.CustomerProducts
(CustomerFinancialProductId,CustomerId,FinancialProductId ,AmountToCollect,Frequency, LastCollected,LastCollection)
VALUES (1,1,1,100,0,'24 Aug 2005','23 Aug 2005')  

INSERT INTO CustomerDetails.Customers 
(CustomerTitleId,CustomerFirstName,CustomerOtherInitials, CustomerLastName,AddressId,AccountNumber,AccountTypeId, ClearedBalance,UnclearedBalance)
VALUES 
(3,'Bernie','I','McGee',314,65368765,1,6653.11,0.00), 
(2,'Julie','A','Dewson',2134,81625422,1,53.32,-12.21),
(1,'Kirsty',NULL,'Hull',4312,96565334,1,1266.00,10.32) 

SELECT TOP 2 [CustomerId]
      ,[CustomerTitleId]
      ,[CustomerFirstName]
      ,[CustomerOtherInitials]
      ,[CustomerLastName]
      ,[AddressId]
      ,[AccountNumber]
      ,[AccountTypeId]
      ,[ClearedBalance]
      ,[UnclearedBalance]
      ,[DateAddedd]
  FROM [ApressFinancial].[CustomerDetails].[Customers]

SELECT * FROM CustomerDetails.Customers 

SELECT CustomerFirstName,CustomerLastName,ClearedBalance 
FROM CustomerDetails.Customers 

SELECT CustomerFirstName AS 'First Name', CustomerLastName AS 'Surname', ClearedBalance Balance 
FROM CustomerDetails.Customers 

INSERT INTO ShareDetails.Shares (ShareDesc, ShareTickerId,CurrentPrice) 
VALUES ('FAT-BELLY.COM','FBC',45.20) 
INSERT INTO ShareDetails.Shares (ShareDesc, ShareTickerId,CurrentPrice) 
VALUES ('NetRadio Inc','NRI',29.79) 
INSERT INTO ShareDetails.Shares (ShareDesc, ShareTickerId,CurrentPrice) 
VALUES ('Texas Oil Industries','TOI',0.455)  
INSERT INTO ShareDetails.Shares (ShareDesc, ShareTickerId,CurrentPrice)
VALUES ('London Bridge Club','LBC',1.46) 

SELECT ShareDesc,CurrentPrice 
FROM ShareDetails.Shares 
WHERE ShareDesc = 'FAT-BELLY.COM' 

SELECT ShareDesc,CurrentPrice 
FROM ShareDetails.Shares 
WHERE ShareDesc > 'FAT-BELLY.COM' AND ShareDesc < 'TEXAS OIL INDUSTRIES' 

SELECT ShareDesc,CurrentPrice 
FROM ShareDetails.Shares 
WHERE ShareDesc <> 'FAT-BELLY.COM' 
SELECT ShareDesc,CurrentPrice 
FROM ShareDetails.Shares 
WHERE NOT ShareDesc = 'FAT-BELLY.COM' 

