SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Diego F Laverde V
-- Create date: 18/05/2016
-- Description:	Procedimiento que lista todos los servicios
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE name ='GetAllServices' AND SCHEMA_NAME(schema_id)= 'referential') 
BEGIN
	DROP PROCEDURE referential.GetAllServices
END
GO
CREATE PROCEDURE referential.GetAllServices
	
AS
BEGIN
	SET NOCOUNT ON;
    
    SELECT ServiceId, Code, RTRIM(LTRIM(Name)) AS Name
    FROM referential.Services
    ORDER BY Name
END
GO
