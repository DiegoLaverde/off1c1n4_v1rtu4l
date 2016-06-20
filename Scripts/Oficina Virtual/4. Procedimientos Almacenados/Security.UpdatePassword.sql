USE [PortalReal]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Miguel Mesa>
-- Create date: <Create Date,16/02/2016,>
-- Description:	<Description,Procedure ,>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE name ='UpdatePassword' AND SCHEMA_NAME(schema_id)= 'security') 
BEGIN
	DROP PROCEDURE [security].[UpdatePassword] 
END
GO
CREATE PROCEDURE [security].[UpdatePassword] 
	-- Add the parameters for the stored procedure here
	@Email VARCHAR(50),
	@Password VARCHAR(50),
	@IdentificationNumber VARCHAR(50),
	@IdentificationType UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE U
	SET U.Password = @Password
	FROM Security.Users U
		INNER JOIN Security.UserDatas ud ON U.UserId = ud.UserId
		INNER JOIN referential.IdentificationTypes it ON U.IdentificationTypeId = it.IdentificationTypeId
	WHERE u.IdentificationNumber = @IdentificationNumber 
		AND it.IdentificationTypeId = @IdentificationType
		AND	u.RoleId  = (SELECT RoleId FROM security.Rols WHERE Name='AFILIADO')
END
GO

GRANT EXECUTE ON [security].[UpdatePassword] TO [redprestadores]
