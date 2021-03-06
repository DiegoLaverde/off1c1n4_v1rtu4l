USE [PortalReal]
GO
/****** Object:  StoredProcedure [interface].[GetAllDepartments]    Script Date: 05/02/2016 16:28:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ===============================================================
-- Author:		Aleida Coste.
-- Create date: 15/07/2015.
-- Description:	Obtener todas los Departamentos.
-- ===============================================================
IF EXISTS (SELECT * FROM sys.objects WHERE name ='GetAllDepartments' AND SCHEMA_NAME(schema_id)= 'interface')
BEGIN
	DROP PROCEDURE [interface].[GetAllDepartments]
END
GO
CREATE PROCEDURE [interface].[GetAllDepartments]
	
AS
	BEGIN
	
		SET NOCOUNT ON;

			 SELECT		 c.[DepartmentId]
						,c.[Code]
						,c.[Name]
						,c.[DepartmentId]
						,c.[CreatedBy]
						,c.[CreationDate]
						,c.[UpdateBy]
						,c.[UpdateDate]
			 FROM		[interface].[Departments] AS c
			 ORDER BY	c.[Name]
	END
