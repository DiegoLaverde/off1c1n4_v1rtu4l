SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Diego F Laverde V
-- Create date: 13/05/2016
-- Description:	Procedimiento permite obtener periodos mora de un afiliado
-- =============================================
DROP PROCEDURE sp_GetAffiliatePeriodMust;  
GO  
CREATE PROCEDURE sp_GetAffiliatePeriodMust
	@IdentificationNumber VARCHAR(100),
	@IdentificationType INT 
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT AC.tercodter AS Nit, AC.aconombre AS Contributor, ACA.acpperpag AS PeriodMust, ACA.acpValsal AS Balance
	FROM aeafilia AF
		INNER JOIN aeCartera ACA ON AF.aafcodigo = ACA.aafCodigo
		INNER JOIN aecontra AC ON ACA.acocodigo = AC.acocodigo
	WHERE RIGHT(AF.aafnumide, LEN(@IdentificationNumber)) = @IdentificationNumber
		AND AF.aaftipide = @IdentificationType
	
END
GO
