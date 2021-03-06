USE [Datafeps10]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAfiliteContributive]    Script Date: 06/08/2016 09:51:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
DROP PROCEDURE [dbo].[sp_GetAfiliteContributive]
GO
CREATE PROCEDURE [dbo].[sp_GetAfiliteContributive]
	@IdentificationNumber VARCHAR(100),
	@IdentificationType INT
AS
BEGIN
	SET NOCOUNT ON;

    SELECT AF.aafpriape AS FatherLastName, AF.aafsegape AS MotherLastName, AF.aafprinom AS FirstName, AF.aafsegnom AS SecondName, AF.aafdirecc AS ResidenceAddress, 
		AF.aaftelef1 AS ResidencePhone, AF.aaftipcot AS CotizanteTypeId, 'CONTRIBUTIVO' AS Regime, @IdentificationNumber AS IdentificationNumber, 
		CASE WHEN AF.aaftipide =1 THEN 'CC' 
			ELSE CASE WHEN AF.aaftipide =2 THEN 'CE'
			ELSE CASE WHEN AF.aaftipide =3 THEN 'PS'
			ELSE CASE WHEN AF.aaftipide =4 THEN 'TI'
			ELSE CASE WHEN AF.aaftipide =5 THEN 'RC'
			ELSE CASE WHEN AF.aaftipide =6 THEN 'ADSIN'
			ELSE CASE WHEN AF.aaftipide =7 THEN 'MENSIN'
			ELSE CASE WHEN AF.aaftipide =8 THEN 'NUMUNIQ' END END END END END END END END AS Code,			
		CASE WHEN AF.aaftipcot = 1 THEN 'DEPENDIENTE'
			ELSE CASE WHEN AF.aaftipcot = 2 THEN 'INDEPENDIENTE'
			ELSE CASE WHEN AF.aaftipcot = 3 THEN 'PENSIONADO'
			ELSE CASE WHEN AF.aaftipcot = 4 THEN 'Mixto' END END END END AS CotizanteType		
    FROM aeafilia AF
    WHERE RIGHT(AF.aafnumide, LEN(@IdentificationNumber)) = @IdentificationNumber
		AND AF.aaftipide = @IdentificationType
END
