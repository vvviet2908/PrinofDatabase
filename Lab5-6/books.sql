USE [books]
GO

CREATE TABLE [dbo].[authorISBN](
	[authorID] [int] NULL,
	[isbn] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[authors]    Script Date: 4/24/2020 12:21:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[authors](
	[authorID] [int] NOT NULL,
	[firstName] [nvarchar](100) NULL,
	[lastName] [nvarchar](100) NULL,
 CONSTRAINT [PK_authors] PRIMARY KEY CLUSTERED 
(
	[authorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[publishers]    Script Date: 4/24/2020 12:21:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[publishers](
	[publisherID] [int] NOT NULL,
	[publisherName] [nvarchar](500) NULL,
 CONSTRAINT [PK_publishers] PRIMARY KEY CLUSTERED 
(
	[publisherID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[titles]    Script Date: 4/24/2020 12:21:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[titles](
	[isbn] [nvarchar](50) NOT NULL,
	[title] [nvarchar](500) NULL,
	[editionNumber] [int] NULL,
	[copyright] [nvarchar](500) NULL,
	[publisherID] [int] NULL,
	[imageFile] [nvarchar](500) NULL,
	[price] [decimal](18, 0) NULL,
 CONSTRAINT [PK_titles] PRIMARY KEY CLUSTERED 
(
	[isbn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[authorISBN] ([authorID], [isbn]) VALUES (1, N'0130384747')
INSERT [dbo].[authorISBN] ([authorID], [isbn]) VALUES (1, N'0130461342')
INSERT [dbo].[authorISBN] ([authorID], [isbn]) VALUES (1, N'0130895601')
INSERT [dbo].[authorISBN] ([authorID], [isbn]) VALUES (1, N'0130895725')
INSERT [dbo].[authorISBN] ([authorID], [isbn]) VALUES (1, N'0131016210')
INSERT [dbo].[authorISBN] ([authorID], [isbn]) VALUES (2, N'0130852473')
INSERT [dbo].[authors] ([authorID], [firstName], [lastName]) VALUES (1, N'Harvey', N'Deitel')
INSERT [dbo].[authors] ([authorID], [firstName], [lastName]) VALUES (2, N'Paul', N'Deitel')
INSERT [dbo].[authors] ([authorID], [firstName], [lastName]) VALUES (3, N'Tem', N'Nieto')
INSERT [dbo].[authors] ([authorID], [firstName], [lastName]) VALUES (4, N'Seam', N'Santry')
INSERT [dbo].[publishers] ([publisherID], [publisherName]) VALUES (1, N'Prentice Hall
')
INSERT [dbo].[publishers] ([publisherID], [publisherName]) VALUES (2, N'Prentice Hall PTG
')
INSERT [dbo].[titles] ([isbn], [title], [editionNumber], [copyright], [publisherID], [imageFile], [price]) VALUES (N'0130384747', N'C++ How to Program', 4, N'2002', 1, N'cpphtp4.jpg', CAST(75 AS Decimal(18, 0)))
INSERT [dbo].[titles] ([isbn], [title], [editionNumber], [copyright], [publisherID], [imageFile], [price]) VALUES (N'0130461342', N'Java Web Services for Experienced Programmers', 1, N'2002', 1, N'jwsfep1.jpg', CAST(55 AS Decimal(18, 0)))
INSERT [dbo].[titles] ([isbn], [title], [editionNumber], [copyright], [publisherID], [imageFile], [price]) VALUES (N'0130852473', N'The Complete Java 2 Training Course', 5, N'2002', 2, N'javactc5.jpg', CAST(110 AS Decimal(18, 0)))
INSERT [dbo].[titles] ([isbn], [title], [editionNumber], [copyright], [publisherID], [imageFile], [price]) VALUES (N'0130895601', N'Advanced Java 2 Platform How to Program', 1, N'2002', 1, N'advjhtp1.jpg', CAST(75 AS Decimal(18, 0)))
INSERT [dbo].[titles] ([isbn], [title], [editionNumber], [copyright], [publisherID], [imageFile], [price]) VALUES (N'0130895725', N'C How to Program', 3, N'2001', 1, N'chtp3.jpg', CAST(75 AS Decimal(18, 0)))
INSERT [dbo].[titles] ([isbn], [title], [editionNumber], [copyright], [publisherID], [imageFile], [price]) VALUES (N'0131016210', N'Java How to Program', 5, N'2003', 1, N'jhtp5.jpg', CAST(75 AS Decimal(18, 0)))
ALTER TABLE [dbo].[authorISBN]  WITH CHECK ADD  CONSTRAINT [FK_authorISBN_authors] FOREIGN KEY([authorID])
REFERENCES [dbo].[authors] ([authorID])
GO
ALTER TABLE [dbo].[authorISBN] CHECK CONSTRAINT [FK_authorISBN_authors]
GO
ALTER TABLE [dbo].[authorISBN]  WITH CHECK ADD  CONSTRAINT [FK_authorISBN_titles] FOREIGN KEY([isbn])
REFERENCES [dbo].[titles] ([isbn])
GO
ALTER TABLE [dbo].[authorISBN] CHECK CONSTRAINT [FK_authorISBN_titles]
GO
ALTER TABLE [dbo].[titles]  WITH CHECK ADD  CONSTRAINT [FK_titles_publishers] FOREIGN KEY([publisherID])
REFERENCES [dbo].[publishers] ([publisherID])
GO
ALTER TABLE [dbo].[titles] CHECK CONSTRAINT [FK_titles_publishers]
GO

SELECT title, editionNumber, copyright FROM dbo.titles WHERE copyright > 2000;

SELECT authorID,firstName, lastName FROM dbo.authors WHERE lastName LIKE '_i%';

SELECT isbn, title, editionNumber, copyright, price FROM dbo.titles WHERE title LIKE '% how to program' ORDER BY title

SELECT a.firstName, a.lastName, ai.isbn FROM dbo.authorISBN AS ai, dbo.authors AS a WHERE a.authorID=ai.authorID ORDER BY a.lastName, a.firstName 

SELECT COUNT(*) FROM dbo.titles WHERE copyright='2001'

SELECT t.title FROM dbo.titles AS t, dbo.publishers AS p WHERE t.publisherID = p.publisherID AND p.publisherName='Prentice Hall PTG
'

SELECT a.firstName, a.lastName FROM dbo.authors AS a, dbo.authorISBN AS ai, dbo.titles AS t 
WHERE a.authorID = ai.authorID AND ai.isbn = t.isbn AND t.price = (SELECT MAX(price) FROM dbo.titles)

 
SELECT a.firstName, a.lastName FROM dbo.authors AS a, dbo.authorISBN AS ai 
WHERE a.authorID = ai.authorID 
GROUP BY a.authorID, a.firstName, a.lastName
HAVING COUNT(*) >= 2