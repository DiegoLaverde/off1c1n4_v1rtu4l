USE [PortalReal]
GO
/****** Object:  StoredProcedure [referential].[GetOfficeVirtualRequestType]    Script Date: 05/18/2016 16:11:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Diego F Laverde V
-- Create date: 20/04/2016
-- Description:	Procedimiento almacenado que muestra los tipos de solicitud disponibles
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE name ='GetOfficeVirtualRequestType' AND SCHEMA_NAME(schema_id)= 'referential') 
BEGIN
	DROP PROCEDURE [referential].[GetOfficeVirtualRequestType]
END
GO
CREATE PROCEDURE [referential].[GetOfficeVirtualRequestType]
	@IdentificationNumber VARCHAR(50)
AS
BEGIN
	
	SET NOCOUNT ON;
	DECLARE @presentRegimeId UNIQUEIDENTIFIER
	DECLARE @newRegimeId UNIQUEIDENTIFIER
	DECLARE @newRegimeDesc VARCHAR(100)
	DECLARE @descCity VARCHAR(100)
		
	SELECT @presentRegimeId = AA.RegimeId, @descCity = IC.Name 
	FROM affiliation.Affiliates	AA	
		INNER JOIN interface.Cities IC ON AA.CityId = IC.CityId
	WHERE IdentificationNumber =@IdentificationNumber
		
	SELECT @newRegimeId = RegimeId, @newRegimeDesc = Name
	FROM referential.Regimes
	WHERE RegimeId <> @presentRegimeId
	
    SELECT typeRequestId, Guion_1,
		CASE WHEN typeRequestId =1 THEN requestTypeDesc + ' A ' + @newRegimeDesc ELSE requestTypeDesc END AS requestTypeDesc, 
		CASE WHEN typeRequestId =1 THEN @newRegimeId END AS newRegimeId,
		CASE WHEN typeRequestId =1 THEN @newRegimeDesc END AS newRegimeDesc,
		responseTime
    FROM referential.OfficeVirtualRequestType
    WHERE isActive = 1  
    
END
