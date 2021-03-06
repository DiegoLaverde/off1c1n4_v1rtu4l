USE [PortalReal]
GO
/****** Object:  StoredProcedure [referential].[GetRequestOfficeVirtualAffiliate]    Script Date: 04/21/2016 18:59:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Diego F Laverde V
-- Create date: 20/04/2016
-- Description:	Procedimiento almacenado que lista las solicitudes expuestas en oficina virtual
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE name ='GetRequestOfficeVirtualAffiliate' AND SCHEMA_NAME(schema_id)= 'referential') 
BEGIN
	DROP PROCEDURE [referential].[GetRequestOfficeVirtualAffiliate] 
END
GO
CREATE PROCEDURE [referential].[GetRequestOfficeVirtualAffiliate] 
	@AffiliateId UNIQUEIDENTIFIER
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT RROV.requestOfficeVirualId, RROV.typeRequestId, ROVRT.requestTypeDesc, RROV.AffiliateId, RROV.RegimeId, RROV.CityId, 
		RROV.isEpsChange, RROV.IpsId, 'Radicado' AS stateRequest, RROV.createDate
	FROM referential.RequestOfficeVirtual RROV
		INNER JOIN referential.OfficeVirtualRequestType ROVRT ON RROV.typeRequestId = ROVRT.typeRequestId
	WHERE AffiliateId = @AffiliateId
		
    END
