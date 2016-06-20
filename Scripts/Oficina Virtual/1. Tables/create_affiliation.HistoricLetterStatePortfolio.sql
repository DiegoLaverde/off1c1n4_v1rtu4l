USE [PortalReal]
GO

/****** Object:  Table [affiliation].[HistoricLetterStatePortfolio]    Script Date: 06/09/2016 07:57:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [affiliation].[HistoricLetterStatePortfolio](
	[Consecutive] [int] IDENTITY(1,1) NOT NULL,
	[IdentificationNumber] [varchar](50) NULL,
	[IdentificationTypeId] [uniqueidentifier] NULL,
	[CreateDate] [datetime] NULL,
	[DisplayLetter] [bit] NULL,
 CONSTRAINT [PK_HistoricLetterStatePortfolio] PRIMARY KEY CLUSTERED 
(
	[Consecutive] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [affiliation].[HistoricLetterStatePortfolio]  WITH CHECK ADD  CONSTRAINT [FK_HistoricLetterStatePortfolio_IdentificationTypes] FOREIGN KEY([IdentificationTypeId])
REFERENCES [referential].[IdentificationTypes] ([IdentificationTypeId])
GO

ALTER TABLE [affiliation].[HistoricLetterStatePortfolio] CHECK CONSTRAINT [FK_HistoricLetterStatePortfolio_IdentificationTypes]
GO


