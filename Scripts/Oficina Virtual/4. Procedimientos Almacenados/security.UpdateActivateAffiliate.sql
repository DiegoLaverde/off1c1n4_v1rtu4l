SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Diego F Laverde V
-- Create date: 02/06/2016
-- Description:	Procedimiento almacenado que activa un usuario
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE name ='UpdateActivateAffiliate' AND SCHEMA_NAME(schema_id)= 'security') 
BEGIN
	DROP PROCEDURE [security].[UpdateActivateAffiliate]
END
GO
CREATE PROCEDURE [security].[UpdateActivateAffiliate]
	@IdentificationNumber VARCHAR(50), 
	@IdentificationTypeId UNIQUEIDENTIFIER,
	@CreateDate DATETIME
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @msj VARCHAR(5)
	DECLARE @UserId UNIQUEIDENTIFIER
	
	IF EXISTS(
		SELECT *
		FROM security.Users
		WHERE IdentificationNumber = @IdentificationNumber
			AND IdentificationTypeId = @IdentificationTypeId
			AND IsActive =1
	)
	BEGIN
		SET @msj = 'EXT'
	END
	ELSE
	BEGIN
		IF EXISTS(SELECT *
			FROM security.Users
			WHERE IdentificationNumber = @IdentificationNumber
				AND IdentificationTypeId = @IdentificationTypeId
				AND YEAR(CreationDate) = YEAR(@CreateDate)
				AND MONTH(CreationDate) = MONTH(@CreateDate)
				AND DAY(CreationDate) = DAY(@CreateDate))
		BEGIN
			IF DATEDIFF(DD, @CreateDate, GETDATE()) > 1
			BEGIN			
							
				SELECT @UserId = UserId 
				FROM security.Users
				WHERE IdentificationNumber = @IdentificationNumber
					AND IdentificationTypeId = @IdentificationTypeId			
				
				DELETE FROM security.UserDatas
				WHERE UserId = @UserId

				DELETE FROM security.UserOffices
				WHERE UserId = @UserId

				DELETE FROM security.Users
				WHERE UserId = @UserId

				SET @msj = 'TIM'
			END
			ELSE
			BEGIN
				UPDATE security.Users
				SET IsActive =1
				WHERE IdentificationNumber = @IdentificationNumber
					AND IdentificationTypeId = @IdentificationTypeId
					
				SET @msj ='UPD'
			END
			
		END
		ELSE
		BEGIN
			SET @msj = 'NE'
		END
	END
	
	SELECT @msj AS msj
END
GO
