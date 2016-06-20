SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Diego F Laverde V
-- Create date: 23/05/2016
-- Description:	Procedimiento que permite listar todos los tipos de regimen
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE name ='GetAllRegimes' AND SCHEMA_NAME(schema_id)= 'referential') 
BEGIN
	DROP PROCEDURE referential.GetAllRegimes
END
GO
CREATE PROCEDURE referential.GetAllRegimes
	
AS
BEGIN
	SET NOCOUNT ON;

    SELECT RegimeId, Code, Name
    FROM referential.Regimes
END
GO
