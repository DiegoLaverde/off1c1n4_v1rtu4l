SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Diego F Laverde V
-- Create date: 02/05/2016
-- Description:	Procedimiento rescatado, creo que actualiza ingreso
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE name ='UpdateUsers' AND SCHEMA_NAME(schema_id)= 'Security') 
BEGIN
	DROP PROCEDURE [Security].[UpdateUsers]
END
GO
CREATE PROCEDURE [Security].[UpdateUsers] 
	@UserId UNIQUEIDENTIFIER,
	@UpdateBy VARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON;

    UPDATE security.Users
    SET UpdateBy = @UpdateBy
    WHERE UserId = @UserId
END
GO
