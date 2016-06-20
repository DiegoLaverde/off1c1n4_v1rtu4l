USE [PortalReal]
GO

/****** Object:  Table [referential].[RequestOfficeVirtual]    Script Date: 06/16/2016 14:53:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE name ='RequestOfficeVirtual' AND SCHEMA_NAME(schema_id)= 'referential') 
BEGIN
	DROP TABLE referential.RequestOfficeVirtual
END
GO

CREATE TABLE [referential].[RequestOfficeVirtual](
	[requestOfficeVirualId] [int] IDENTITY(1,1) NOT NULL,
	[typeRequestId] [int] NOT NULL,
	[AffiliateId] [uniqueidentifier] NOT NULL,
	[RegimeId] [uniqueidentifier] NULL,
	[CityId] [uniqueidentifier] NULL,
	[DestinationCity] [uniqueidentifier] NULL,
	[isEpsChange] [bit] NULL,
	[IpsId] [uniqueidentifier] NULL,
	[TimePortability] [varchar](50) NULL,
	[isGestante] [bit] NULL,
	[isDiseaseHighCost] [bit] NULL,
	[isLessOneYear] [bit] NULL,
	[isAdultHigher] [bit] NULL,
	[isNoneOfTheAbove] [bit] NULL,
	[Observation] [varchar](max) NULL,
	[createDate] [datetime] NULL,
 CONSTRAINT [PK_RequestOfficeVirtual] PRIMARY KEY CLUSTERED 
(
	[requestOfficeVirualId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [referential].[RequestOfficeVirtual]  WITH CHECK ADD  CONSTRAINT [FK_RequestOfficeVirtual_Affiliates] FOREIGN KEY([AffiliateId])
REFERENCES [affiliation].[Affiliates] ([AffiliateId])
GO

ALTER TABLE [referential].[RequestOfficeVirtual] CHECK CONSTRAINT [FK_RequestOfficeVirtual_Affiliates]
GO

ALTER TABLE [referential].[RequestOfficeVirtual]  WITH CHECK ADD  CONSTRAINT [FK_RequestOfficeVirtual_Cities] FOREIGN KEY([CityId])
REFERENCES [interface].[Cities] ([CityId])
GO

ALTER TABLE [referential].[RequestOfficeVirtual] CHECK CONSTRAINT [FK_RequestOfficeVirtual_Cities]
GO

ALTER TABLE [referential].[RequestOfficeVirtual]  WITH CHECK ADD  CONSTRAINT [FK_RequestOfficeVirtual_Cities1] FOREIGN KEY([DestinationCity])
REFERENCES [interface].[Cities] ([CityId])
GO

ALTER TABLE [referential].[RequestOfficeVirtual] CHECK CONSTRAINT [FK_RequestOfficeVirtual_Cities1]
GO

ALTER TABLE [referential].[RequestOfficeVirtual]  WITH NOCHECK ADD  CONSTRAINT [FK_RequestOfficeVirtual_Ips] FOREIGN KEY([IpsId])
REFERENCES [contract].[Ips] ([IpsId])
NOT FOR REPLICATION 
GO

ALTER TABLE [referential].[RequestOfficeVirtual] CHECK CONSTRAINT [FK_RequestOfficeVirtual_Ips]
GO

ALTER TABLE [referential].[RequestOfficeVirtual]  WITH CHECK ADD  CONSTRAINT [FK_RequestOfficeVirtual_OfficeVirtualRequestType] FOREIGN KEY([typeRequestId])
REFERENCES [referential].[OfficeVirtualRequestType] ([typeRequestId])
GO

ALTER TABLE [referential].[RequestOfficeVirtual] CHECK CONSTRAINT [FK_RequestOfficeVirtual_OfficeVirtualRequestType]
GO

ALTER TABLE [referential].[RequestOfficeVirtual]  WITH NOCHECK ADD  CONSTRAINT [FK_RequestOfficeVirtual_Regimes] FOREIGN KEY([RegimeId])
REFERENCES [referential].[Regimes] ([RegimeId])
NOT FOR REPLICATION 
GO

ALTER TABLE [referential].[RequestOfficeVirtual] CHECK CONSTRAINT [FK_RequestOfficeVirtual_Regimes]
GO

GRANT SELECT, INSERT, UPDATE, DELETE ON [referential].[RequestOfficeVirtual] TO [redprestadores]


