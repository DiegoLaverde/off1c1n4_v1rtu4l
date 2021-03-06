USE [PortalReal]
GO
/****** Object:  StoredProcedure [affiliation].[GetIpsAffiliatesTransfers]    Script Date: 06/13/2016 14:54:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.objects WHERE name ='GetIpsAffiliatesTransfers' AND SCHEMA_NAME(schema_id)= 'affiliation') 
BEGIN
	DROP PROCEDURE [affiliation].[GetIpsAffiliatesTransfers] 
END
GO
CREATE PROCEDURE [affiliation].[GetIpsAffiliatesTransfers]
	@IdentificationNumber VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;

    DECLARE @idCity AS UNIQUEIDENTIFIER
    DECLARE @idIPS AS UNIQUEIDENTIFIER 
    DECLARE @idRegime AS UNIQUEIDENTIFIER
	
	/*
	Obtener regional e ips del afiliado
	*/
	SELECT TOP 1 @idCity = CIC.CityId, @idIPS= AA.IpsId, @idRegime = AA.RegimeId
	FROM affiliation.Affiliates AA
		INNER JOIN contract.Ips CI ON AA.IpsId = CI.IpsId AND AA.IdentificationNumber =@IdentificationNumber
		INNER JOIN contract.IpsContracts CIC ON CI.IpsId = CIC.IpsId
	ORDER BY
		CIC.CreatedBy
	/*
	De acuerdo a la regional obtenida, obtener las IPS de las regional en donde se encuentra el afiliado
	*/
	SELECT CI.IpsId, CI.TradeName 
	FROM contract.Ips CI
		INNER JOIN contract.IpsContracts CIC ON CI.IpsId = CIC.IpsId
				AND CIC.LowComplexity =1
				AND CIC.MediumComplexity =0
				AND CIC.HighComplexity =0
				AND CI.IsActive = 1
				AND CIC.CityId =@idCity--'8930FE3B-3247-DF11-94F5-0027134F884A'
				--AND CIC.RegimeId = @idRegime
				--AND CIC.ContractNumber ='08001-20368'
		INNER JOIN contract.IpsContractServices ICS ON CIC.IpsContractId = ICS.IpsContractId
			AND ICS.IsCapita =1
		INNER JOIN referential.Nodes RN ON CIC.NodeId = RN.NodeId AND RN.Code IN ('LE')
		INNER JOIN referential.Services RS ON ICS.ServiceId = RS.ServiceId 
			AND RS.Code = 328
		INNER JOIN (SELECT * FROM referential.ContractModalities WHERE Code <> 'E') RCM ON CIC.ContractModalityId = RCM.ContractModalityId
	WHERE CI.IpsId <> @idIPS
	GROUP BY CI.IpsId, CI.TradeName
	ORDER BY CI.TradeName
END
