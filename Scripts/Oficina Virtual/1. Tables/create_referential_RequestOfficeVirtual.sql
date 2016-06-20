USE [PortalReal]
GO

/****** Object:  Table [referential].[RequestOfficeVirtual]    Script Date: 04/22/2016 16:07:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [referential].[RequestOfficeVirtual](
	[requestOfficeVirualId] [int] IDENTITY(1,1) NOT NULL,
	[typeRequestId] [int] NULL,
	[AffiliateId] [uniqueidentifier] NOT NULL,
	[RegimeId] [uniqueidentifier] NULL,
	[CityId] [uniqueidentifier] NULL,
	[DestinationCity] [uniqueidentifier] NULL,
	[isEpsChange] [bit] NULL,
	[IpsId] [uniqueidentifier] NULL,
	[TimePortability] [int] NULL,
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


