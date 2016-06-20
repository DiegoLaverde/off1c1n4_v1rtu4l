SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Diego F Laverde V
-- Create date: 09/06/2016
-- Description:	Procedimiento almacenado que almacena el registro de cada vez que se genera o se solicita el servicio
--				Generacion estado de cartera en la Oficina Virtual
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE name ='InsertHistoricLetterStatePortfolio' AND SCHEMA_NAME(schema_id)= 'Contract') 
BEGIN
	DROP PROCEDURE affiliation.InsertHistoricLetterStatePortfolio
END
GO
CREATE PROCEDURE affiliation.InsertHistoricLetterStatePortfolio
	@IdentificationNumber VARCHAR(50),
	@IdentificationTypeId VARCHAR(5),
	@DisplayLetter BIT
AS
BEGIN
	SET NOCOUNT ON;
	
	INSERT INTO affiliation.HistoricLetterStatePortfolio (IdentificationNumber, IdentificationTypeId, CreateDate, DisplayLetter)
    VALUES (@IdentificationNumber, (SELECT IdentificationTypeId FROM referential.IdentificationTypes WHERE Code = @IdentificationTypeId), GETDATE(), @DisplayLetter)
    
    SELECT @@IDENTITY AS Consecutive
    
END
GO
