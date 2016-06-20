SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Diego F Laverde V
-- Create date: 22/04/2016
-- Description:	Procedimiento que permite listar los correos por procedimiento
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE name ='GetMailRequestOfficeVirtual' AND SCHEMA_NAME(schema_id)= 'referential') 
BEGIN
	DROP PROCEDURE referential.GetMailRequestOfficeVirtual
END
GO
CREATE PROCEDURE referential.GetMailRequestOfficeVirtual 
	@RequestTypeId INT = NULL,
	@IdentificationNumber VARCHAR(100) = NULL,
	@IdentificationTypeId UNIQUEIDENTIFIER = NULL,
	@RegimeId UNIQUEIDENTIFIER = NULL
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @CityId AS UNIQUEIDENTIFIER
		
	SELECT @CityId = CityId
	FROM affiliation.Affiliates
	WHERE IdentificationNumber =@IdentificationNumber AND IdentificationTypeId = @IdentificationTypeId
	
	SELECT MailOfficeVirtual_id, EMail
	FROM referential.EmailRequestOfficeVirtual
	WHERE RequestTypeId = @RequestTypeId 
		AND CityId = @CityId
		AND RegimeId = @RegimeId		
	
END
GO
