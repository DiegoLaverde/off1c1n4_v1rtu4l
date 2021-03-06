USE [PortalReal]
GO
/****** Object:  StoredProcedure [referential].[GetAllRequestTypes]    Script Date: 05/02/2016 16:26:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ===============================================================
-- Author:		Aleida Coste.
-- Create date: 24/09/2015.
-- Description:	Obtener los tipos de solicitantes.
-- ===============================================================
IF EXISTS (SELECT * FROM sys.objects WHERE name ='GetAllRequestTypes' AND SCHEMA_NAME(schema_id)= 'referential') 
BEGIN
	DROP PROCEDURE [referential].[GetAllRequestTypes]
END
GO
CREATE PROCEDURE [referential].[GetAllRequestTypes]
	
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
			 FROM		[referential].[RequestTypes] AS rt
			 ORDER BY	rt.[Name]
	END
