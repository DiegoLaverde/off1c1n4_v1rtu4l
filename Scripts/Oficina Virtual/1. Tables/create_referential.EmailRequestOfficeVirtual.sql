USE [PortalReal]
GO

/****** Object:  Table [referential].[EmailRequestOfficeVirtual]    Script Date: 05/20/2016 10:41:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
CREATE TABLE [referential].[EmailRequestOfficeVirtual](
	[MailOfficeVirtual_id] [int] IDENTITY(1,1) NOT NULL,
	[RequestTypeId] [int] NULL,
	[RegimeId] [uniqueidentifier] NULL,
	[CityId] [uniqueidentifier] NULL,
	[EMail] [varchar](500) NULL,
 CONSTRAINT [PK_EmailRequestOfficeVirtual] PRIMARY KEY CLUSTERED 
(
	[MailOfficeVirtual_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [referential].[EmailRequestOfficeVirtual]  WITH CHECK ADD  CONSTRAINT [FK_EmailRequestOfficeVirtual_Cities] FOREIGN KEY([CityId])
REFERENCES [interface].[Cities] ([CityId])
GO

ALTER TABLE [referential].[EmailRequestOfficeVirtual] CHECK CONSTRAINT [FK_EmailRequestOfficeVirtual_Cities]
GO

ALTER TABLE [referential].[EmailRequestOfficeVirtual]  WITH CHECK ADD  CONSTRAINT [FK_EmailRequestOfficeVirtual_Regimes] FOREIGN KEY([RegimeId])
REFERENCES [referential].[Regimes] ([RegimeId])
GO

ALTER TABLE [referential].[EmailRequestOfficeVirtual] CHECK CONSTRAINT [FK_EmailRequestOfficeVirtual_Regimes]
GO
