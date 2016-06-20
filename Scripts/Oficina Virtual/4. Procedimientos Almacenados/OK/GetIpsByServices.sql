USE [PortalReal]
GO
/****** Object:  StoredProcedure [affiliation].[getBeneficiariesPdf]    Script Date: 04/05/2016 15:28:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Miguel Mesa>
-- Create date: <Create Date,16/02/2016,>
-- Description:	<Description,Procedure ,>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE name ='GetIpsByServices' AND SCHEMA_NAME(schema_id)= 'Contract') 
BEGIN
	DROP PROCEDURE [Contract].[GetIpsByServices]
END
GO
CREATE PROCEDURE [Contract].[GetIpsByServices] 
	-- Add the parameters for the stored procedure here
	@CityId AS UNIQUEIDENTIFIER,
	@Code AS VARCHAR(10) = NULL,
	@CodeRegime AS VARCHAR(10)= NULL
AS
BEGIN
	SET NOCOUNT ON;
	
    DECLARE @QueryPpal NVARCHAR(MAX)
    DECLARE @CityIdV NVARCHAR(MAX)
    SET  @CityIdV = CONVERT(NVARCHAR(36), @CityId)      
	SET @QueryPpal = 'SELECT IPS.IpsId, 
		MAX(Address) AS Address, 
		MAX(TradeName) AS TradeName, 
		MAX(Phone) AS Phone, 
		MAX(S.Name) AS Description, 
		MAX(S.Code) AS Code, 
		MAX(RR.Name) AS NameRegime
	FROM [PortalReal].[contract].[Ips] IPS 
		INNER JOIN (
			SELECT RES.ContractNumber, RES.Code, RES.IpsId, RES.IpsContractId, RES.NodeId, RES.RegimeId
			FROM
			(
				SELECT CIC.ContractNumber, RN.Code, CIC.IpsId, CIC.IpsContractId, CIC.RegimeId, CIC.NodeId
				FROM contract.IpsContracts CIC
					INNER JOIN referential.Nodes RN ON CIC.NodeId = RN.NodeId
				WHERE RN.Code=''LE''
				GROUP BY CIC.ContractNumber, RN.Code, CIC.IpsId, CIC.IpsContractId, CIC.RegimeId, CIC.NodeId
			) AS RES
				LEFT JOIN 
				(
					SELECT CIC.ContractNumber, RN.Code  
					FROM contract.IpsContracts CIC
						INNER JOIN referential.Nodes RN ON CIC.NodeId = RN.NodeId
					WHERE RN.Code IN (''TE'', ''TA'')
					GROUP BY CIC.ContractNumber, RN.Code 
			) RES1 ON RES.ContractNumber = RES1.ContractNumber
			WHERE RES1.Code IS NULL
		) IPC ON IPS.IpsId = IPC.IpsId 			
		INNER JOIN PortalReal.contract.[IpsContractServices] ICS ON ICS.IpsContractId = IPC.IpsContractId
		INNER JOIN [PortalReal].[referential].[Services] S ON ICS.ServiceId = S.ServiceId 
		INNER JOIN referential.Regimes RR ON IPC.RegimeId = RR.RegimeId
		INNER JOIN referential.Nodes RN ON IPC.NodeId = RN.NodeId AND RN.Code = ''LE''
	WHERE IsActive=1 AND IPS.CityId = ''' + @CityIdV + ''' '
	
	IF @CodeRegime IS NOT NULL
	BEGIN
		SET @QueryPpal = @QueryPpal + ' AND RR.Code = ''' + @CodeRegime + ''''
	END
	
	IF @Code IS NOT NULL
	BEGIN
		SET @QueryPpal = @QueryPpal + ' AND S.Code = ''' + @Code + ''''
	END
	
	SET @QueryPpal = @QueryPpal + ' GROUP BY IPS.IpsId
		ORDER BY TradeName '
	
	PRINT @QueryPpal
	
	exec sp_executesql @QueryPpal	
	
END

