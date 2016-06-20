
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Diego F Laverde V
-- Create date: 07/06/2016
-- Description:	Procedimiento que lista los beneficiarios de un cotizanrte
-- =============================================
CREATE PROCEDURE sp_GetBeneficiariesContributors
	@IdentificationNumber VARCHAR(50),
	@IdentificationType INT
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT CASE WHEN AB.abetipben = 1 THEN 'BENEFICIARIO' 
		ELSE CASE WHEN AB.abetipben = 2 THEN 'ADICIONAL' 
		ELSE CASE WHEN AB.abetipben = 3 THEN 'ADICIONAL ESPECIAL' END END END AS Tipo, 
	  CASE WHEN AB.abetipide =1 THEN 'CC' 
		ELSE CASE WHEN AB.abetipide =2 THEN 'CE'
		ELSE CASE WHEN AB.abetipide =3 THEN 'PS'
		ELSE CASE WHEN AB.abetipide =4 THEN 'TI'
		ELSE CASE WHEN AB.abetipide =5 THEN 'RC'
		ELSE CASE WHEN AB.abetipide =6 THEN 'ADSIN'
		ELSE CASE WHEN AB.abetipide =7 THEN 'MENSIN'
		ELSE CASE WHEN AB.abetipide =8 THEN 'NUMUNIQ' END END END END END END END END AS Code, 
	  AB.tercodter AS IdentificationNumber, LTRIM(RTRIM(AB.abepriape)) AS FatherLastName, LTRIM(RTRIM(AB.abesegape)) AS MotherLastName, RTRIM(LTRIM(AB.abeprinom)) AS FirstName, 
	  LTRIM(RTRIM(AB.abesegnom)) AS SecondName, AP.apadescri AS kindship, AB.abefecafi AS ContractStartingDate, AB.abefecest AS RetirementDate, 
	  CASE WHEN AB.abeestado = 1 THEN 'ACTIVO'
		  ELSE CASE WHEN AB.abeestado = 2 THEN 'RETIRADO'
		  ELSE CASE WHEN AB.abeestado = 3 THEN 'TRASLADO'
		  ELSE CASE WHEN AB.abeestado = 4 THEN 'SUSP X PAGO'
		  ELSE CASE WHEN AB.abeestado = 5 THEN 'DESAFILIADO'
		  ELSE CASE WHEN AB.abeestado = 6 THEN 'INACTIVO'
		  ELSE CASE WHEN AB.abeestado = 7 THEN 'SUSP X DOBLE AFIL'
		  ELSE CASE WHEN AB.abeestado = 8 THEN 'RETIRADO'
		  ELSE CASE WHEN AB.abeestado = 9 THEN 'RETIRADO'
		  ELSE CASE WHEN AB.abeestado = 10 THEN 'RETIRADO' END END END END END END END END END END AS Statu
	FROM aeafilia AF
		INNER JOIN aebenefi AB ON AF.aafcodigo= AB.aafcodigo
		INNER JOIN aeparent AP ON AB.apacodigo = AP.apacodigo
	WHERE RIGHT(AF.aafnumide, LEN(@IdentificationNumber)) = @IdentificationNumber
		AND AF.aaftipide = @IdentificationType
	ORDER BY (LTRIM(RTRIM(AB.abepriape)) + ' ' + LTRIM(RTRIM(AB.abesegape)) + ' ' + RTRIM(LTRIM(AB.abeprinom)) + ' ' + LTRIM(RTRIM(AB.abesegnom)))
END
GO
