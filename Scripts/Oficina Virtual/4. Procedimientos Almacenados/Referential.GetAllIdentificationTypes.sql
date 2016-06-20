SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Diego F Laverde V
-- Create date: 01/06/2015
-- Description:	Procedimiento que muestra todos los tipos de identificacion
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE name ='GetAllIdentificationTypes' AND SCHEMA_NAME(schema_id)= 'Referential') 
BEGIN
	DROP PROCEDURE [Referential].[GetAllIdentificationTypes]
END
GO
CREATE PROCEDURE [Referential].[GetAllIdentificationTypes] 
	
AS
BEGIN
	SET NOCOUNT ON;

    SELECT IdentificationTypeId, Code, UPPER(Name) AS Name, Length, IsForContributorRS, IsForContributorRC, ReferentialCode, CompanyId, IsForSuscriberRC, IsForSuscriberRS, 
		IsForLegalRepresentative, IsForIPS, CreatedBy, CreationDate, UpdateBy, UpdateDate  
	FROM PortalReal.referential.IdentificationTypes
	ORDER BY Name
	
END
GO
