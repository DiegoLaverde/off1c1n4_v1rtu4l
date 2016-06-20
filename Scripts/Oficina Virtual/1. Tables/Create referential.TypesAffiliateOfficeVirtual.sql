USE [PortalReal]
GO

/****** Object:  Table [referential].[RequestTypes]    Script Date: 05/19/2016 10:29:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [referential].[TypesAffiliateOfficeVirtual](
	[RequestTypeId] UNIQUEIDENTIFIER  NOT NULL,
	[Code] [varchar](10) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[UpdateBy] [varchar](50) NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[RoleId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_TypesAffiliateOfficeVirtual] PRIMARY KEY CLUSTERED 
(
	[RequestTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tipo Solicitante Oficina Virtual' , @level0type=N'SCHEMA',@level0name=N'referential', @level1type=N'TABLE',@level1name=N'TypesAffiliateOfficeVirtual'
GO

ALTER TABLE [referential].[TypesAffiliateOfficeVirtual]  WITH CHECK ADD  CONSTRAINT [FK_TypesAffiliateOfficeVirtual_Rols] FOREIGN KEY([RoleId])
REFERENCES [security].[Rols] ([RoleId])
GO

ALTER TABLE [referential].[RequestTypes] CHECK CONSTRAINT [FK_RequestTypes_Rols]
GO

