SELECT c.AccountNumber,c.CustomerFirstName,c.CustomerOtherInitials, 
	tt.TransactionDescription,t.DateEntered,t.Amount,t.ReferenceDetails 
FROM CustomerDetails.Customers c
JOIN TransactionDetails.Transactions t ON t.CustomerId = c.CustomerId
JOIN TransactionDetails.TransactionTypes tt ON 
	tt.TransactionTypeId = t.TransactionType 
ORDER BY c.AccountNumber ASC, t.DateEntered DESC;

CREATE VIEW CustomerDetails.vw_CustTrans 
AS 
SELECT TOP 100 PERCENT 
	c.AccountNumber,c.CustomerFirstName,c.CustomerOtherInitials, 
	tt.TransactionDescription,t.DateEntered,t.Amount,t.ReferenceDetails 
FROM CustomerDetails.Customers c 
JOIN TransactionDetails.Transactions t ON t.CustomerId = c.CustomerId 
JOIN TransactionDetails.TransactionTypes tt ON 
	tt.TransactionTypeId = t.TransactionType 
ORDER BY c.AccountNumber ASC, t.DateEntered DESC; 

SELECT c.CustomerFirstName + ' ' + c.CustomerLastName AS
CustomerName,
c.AccountNumber, fp.ProductName, cp.AmountToCollect, cp.Frequency,
cp.LastCollected 
FROM CustomerDetails.Customers c 
JOIN CustomerDetails.CustomerProducts cp ON cp.CustomerId = 
c.CustomerId 
JOIN CustomerDetails.FinancialProducts fp ON 
fp.ProductId = cp.FinancialProductId;

INSERT INTO CustomerDetails.FinancialProducts (ProductId,ProductName) 
VALUES (1,'Regular Savings') 
INSERT INTO CustomerDetails.FinancialProducts (ProductId,ProductName) 
VALUES (2,'Bonds Account') 
INSERT INTO CustomerDetails.FinancialProducts (ProductId,ProductName) 
VALUES (3,'Share Account') 
INSERT INTO CustomerDetails.FinancialProducts (ProductId,ProductName)
VALUES (4,'Life Insurance') 

SET IDENTITY_INSERT CustomerDetails.CustomerProducts ON
INSERT INTO CustomerDetails.CustomerProducts 
(CustomerFinancialProductId, CustomerId,FinancialProductId,
AmountToCollect,Frequency,LastCollected,LastCollection,Renewable) 
VALUES (1, 1,1,200,1,'31 October 2005','31 October 2025',0) 
INSERT INTO CustomerDetails.CustomerProducts 
(CustomerFinancialProductId, CustomerId,FinancialProductId, 
AmountToCollect,Frequency,LastCollected,LastCollection,Renewable) 
VALUES (2, 1,2,50,1,'24 October 2005','24 March 2008',0) 
INSERT INTO CustomerDetails.CustomerProducts 
(CustomerFinancialProductId, CustomerId,FinancialProductId, 
AmountToCollect,Frequency,LastCollected,LastCollection,Renewable) 
VALUES (3, 2,4,150,3,'20 October 2005','20 October 2005',1) 
INSERT INTO CustomerDetails.CustomerProducts 
(CustomerFinancialProductId, CustomerId,FinancialProductId, 
AmountToCollect,Frequency,LastCollected,LastCollection,Renewable) 
VALUES (4,3,3,500,0,'24 October 2005','24 October 2005',0) 
SET IDENTITY_INSERT CustomerDetails.CustomerProducts OFF

IF EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS
WHERE TABLE_NAME = N'vw_CustFinProducts' 
AND TABLE_SCHEMA = N'CustomerDetails') 
DROP VIEW CustomerDetails.vw_CustFinProducts 
GO 
CREATE VIEW CustomerDetails.vw_CustFinProducts WITH SCHEMABINDING 
AS 
SELECT c.CustomerFirstName + ' ' + c.CustomerLastName AS CustomerName, 
c.AccountNumber, fp.ProductName, cp.AmountToCollect, cp.Frequency, 
cp.LastCollected 
FROM CustomerDetails.Customers c 
JOIN CustomerDetails.CustomerProducts cp ON cp.CustomerId = c.CustomerId 
JOIN CustomerDetails.FinancialProducts fp ON 
fp.ProductId = cp.FinancialProductId 

ALTER TABLE CustomerDetails.Customers 
ALTER COLUMN CustomerFirstName nvarchar(100) 

 

 