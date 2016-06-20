SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Diego F Laverde V
-- Create date: 07/06/2016
-- Description:	Procedimiento que permite actualizar datos desde la oficina virtual
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE name ='sp_UpdAffiliate' AND schema_id=1) 
BEGIN
	DROP PROCEDURE sp_UpdAffiliate 
END
GO
CREATE PROCEDURE sp_UpdAffiliate
	@IdentificationNumber VARCHAR(50),
	@IdentificationType INT,
	@ResidencePhone VARCHAR(50),
	@ResidenceAddress VARCHAR(50)= NULL
AS
BEGIN
	SET NOCOUNT ON;
	
	--Cuando el usuario se registra el campo viene vacio, lo mejor es que mantenga la direccion como esta en la BD
	IF @ResidenceAddress IS NULL
	BEGIN
		SELECT @ResidenceAddress = aafdirecc 
		FROM aeafilia
		WHERE RIGHT(aafnumide, LEN(@IdentificationNumber)) = @IdentificationNumber
			AND aaftipide = @IdentificationType
	END

	UPDATE aeafilia
	SET aafdirecc = @ResidenceAddress, aaftelef1 = @ResidencePhone
	WHERE RIGHT(aafnumide, LEN(@IdentificationNumber)) = @IdentificationNumber
		AND aaftipide = @IdentificationType
		
    
END
GO
