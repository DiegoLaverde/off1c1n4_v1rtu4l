USE [PortalReal]
GO
/****** Object:  StoredProcedure [affiliation].[getCertificatePdf]    Script Date: 06/03/2016 11:05:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Miguel Mesa>
-- Create date: <Create Date,16/02/2016,>
-- Description:	<Description,Procedure ,>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE name ='getCertificatePdf' AND SCHEMA_NAME(schema_id)= 'affiliation')  
BEGIN
	DROP PROCEDURE [affiliation].[getCertificatePdf] 
END
GO
CREATE PROCEDURE [affiliation].[getCertificatePdf] 
	-- Add the parameters for the stored procedure here
	(@IdentificationNumber VARCHAR(50))
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT AF.FirstName, AF.SecondName, AF.FatherLastName, AF.MotherLastName, AF.SGSSSAffiliationDate AS AfiliationDate, AF.IdentificationNumber, AT.Name AS Tipo, 
		REG.Name AS Regime, AF.ContractStartingDate, DATEDIFF([week], AF.SGSSSAffiliationDate, GETDATE()) AS SGSSSAweeks, DATEDIFF([week], Af.ContractStartingDate,
		GETDATE()) AS EPSweeks, NOD.Name AS Statu, AF.AffiliateId AS id, AF.ContractNumber, idtype.Code , city.Name AS city , deptos.Name AS department , RetirementDate,
		IPS.TradeName AS ipsName, ResidenceAddress , AF.ResidencePhone, AF.Email, AF.CellPhone,
		cityIPS.Name AS cityIPS, deptosIPS.Name AS deptosIPS  
	FROM [PortalReal].affiliation.Affiliates AF
		INNER JOIN [PortalReal].[referential].[AffiliateTypes] AT on AF.AffiliateTypeId = AT.AffiliateTypeId
		INNER JOIN PortalReal.referential.Regimes REG on REG.RegimeId = AF.RegimeId
		INNER JOIN [PortalReal].[referential].[Nodes] NOD on AF.NodeId = NOD.NodeId
		INNER JOIN [PortalReal].[referential].[IdentificationTypes] AS idtype on idtype.IdentificationTypeId = AF.IdentificationTypeId
		INNER JOIN [PortalReal].[interface].[Cities] AS city on city.CityId = AF.CityId
		INNER JOIN [PortalReal].[interface].Departments AS deptos on deptos.DepartmentId = city.DepartmentId
		LEFT JOIN [PortalReal].[contract].[Ips] AS IPS on IPS.IpsId = AF.IpsId
		INNER JOIN [PortalReal].[interface].[Cities] AS cityIPS on cityIPS.CityId = AF.CityId
		INNER JOIN [PortalReal].[interface].Departments AS deptosIPS on deptosIPS.DepartmentId = city.DepartmentId
	WHERE AF.IdentificationNumber =@IdentificationNumber
END
