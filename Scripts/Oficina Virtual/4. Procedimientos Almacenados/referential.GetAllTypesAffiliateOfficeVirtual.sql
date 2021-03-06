USE [PortalReal]
GO
/****** Object:  StoredProcedure [referential].[GetAllRequestTypes]    Script Date: 05/19/2016 10:28:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ===============================================================
-- Author:		Diego F Laverde V.
-- Create date: 19/05/2016.
-- Description:	Obtener los tipos de solicitantes oficina virtual.
-- ===============================================================
IF EXISTS (SELECT * FROM sys.objects WHERE name ='GetAllTypesAffiliateOfficeVirtual' AND SCHEMA_NAME(schema_id)= 'referential') 
BEGIN
	DROP PROCEDURE [referential].[GetAllTypesAffiliateOfficeVirtual]
END
GO
CREATE PROCEDURE [referential].[GetAllTypesAffiliateOfficeVirtual]
	
AS
	BEGIN
	
		SET NOCOUNT ON;

			 SELECT		 rt.[RequestTypeId]
						,rt.[Code]
						,rt.[Name]
						,rt.[CreatedBy]
						,rt.[CreationDate]
						,rt.[UpdateBy]
						,rt.[UpdateDate]
			 FROM		[referential].TypesAffiliateOfficeVirtual AS rt
			 WHERE Code ='AF'
			 ORDER BY	rt.[Name]
	END
