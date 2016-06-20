SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Diego F Laverde V
-- Create date: 15/04/2016
-- Description:	Procedimiento permite obtener la informacion que permite diligenciar el carnet de un afiliado
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE name ='GetLicenseDocument' AND SCHEMA_NAME(schema_id)= 'affiliation') 
BEGIN
	DROP PROCEDURE affiliation.GetLicenseDocument
END
GO
CREATE PROCEDURE affiliation.GetLicenseDocument
	@IdNumber AS VARCHAR(50),
	@IdIdentificationType AS VARCHAR(50)
AS
BEGIN
	
	SET NOCOUNT ON;

    SELECT AffiliateConsecutive,af.FatherLastName,af.MotherLastName,af.FirstName,af.SecondName,af.IdentificationNumber, 
		it.Code, BirthDate, c.Name as city , sl.Name as sisbenLevel , g.Name as gender, d.Name as disability, 
		aft.Name as afiliateTipe, ips.TradeName,af.ContractStartingDate
	FROM [PortalReal].[affiliation].[Affiliates] af
		LEFT OUTER JOIN[PortalReal].referential.IdentificationTypes it on it.IdentificationTypeId = af.IdentificationTypeId
		LEFT OUTER JOIN[PortalReal].interface.Cities c on c.CityId = af.CityId
		LEFT OUTER JOIN[PortalReal].referential.SisbenLevels sl on sl.SisbenLevelId = af.SisbenLevelId
		LEFT OUTER JOIN[PortalReal].referential.Genders g on g.GenderId = af.GenderId
		LEFT OUTER JOIN[PortalReal].referential.Disabilities d on d.DisabilityId = af.DisabilityId
		LEFT OUTER JOIN[PortalReal].referential.AffiliateTypes aft on aft.AffiliateTypeId = af.AffiliateTypeId
		LEFT OUTER JOIN[portalReal].contract.Ips ips on af.IpsId = ips.IpsId
	WHERE af.IdentificationNumber = @IdNumber 
		AND it.Code = @IdIdentificationType

END
GO
