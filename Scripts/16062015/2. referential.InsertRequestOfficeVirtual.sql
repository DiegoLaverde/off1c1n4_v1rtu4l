USE [PortalReal]
GO
/****** Object:  StoredProcedure [referential].[InsertRequestOfficeVirtual]    Script Date: 04/22/2016 15:00:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Diego F Laverde V
-- Create date: 20/04/2016
-- Description:	Procedimiento que permite agregar una solicitud de oficina virtual.
--	Por ahora solo almacenara solicitudes referentes a movilidad, portabilidad, traslados
--	y cambios puerta entrada de atencion primaria
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE name ='InsertRequestOfficeVirtual' AND SCHEMA_NAME(schema_id)= 'referential') 
BEGIN
	DROP PROCEDURE [referential].[InsertRequestOfficeVirtual]
END
GO
CREATE PROCEDURE [referential].[InsertRequestOfficeVirtual] 
	@typeRequestId INT= NULL,
	@AffiliateId UNIQUEIDENTIFIER= NULL,
	@RegimeId UNIQUEIDENTIFIER= NULL,
	@CityId UNIQUEIDENTIFIER= NULL,
	@DestinationCity UNIQUEIDENTIFIER= NULL,
	@isEpsChange BIT= NULL,
	@IpsId UNIQUEIDENTIFIER= NULL,
	@TimePortability VARCHAR(50)= NULL,
	@isGestante BIT= NULL,
	@isDiseaseHighCost BIT= NULL,
	@isLessOneYear BIT= NULL,
	@isAdultHigher BIT= NULL,
	@isNoneOfTheAbove BIT= NULL,
	@Observation VARCHAR(MAX) = NULL
	
AS	
BEGIN
	
	SET NOCOUNT ON;
	
	IF (@RegimeId ='00000000-0000-0000-0000-000000000000')
	BEGIN
		SET @RegimeId = NULL
	END
	
	IF (@IpsId ='00000000-0000-0000-0000-000000000000')
	BEGIN
		SET @IpsId = NULL
	END
	
	IF (@CityId ='00000000-0000-0000-0000-000000000000')
	BEGIN
		SET @CityId = NULL
	END
	
	IF (@DestinationCity ='00000000-0000-0000-0000-000000000000')
	BEGIN
		SET @DestinationCity = NULL
	END
	
	INSERT INTO referential.RequestOfficeVirtual (typeRequestId, AffiliateId, RegimeId, CityId, DestinationCity, isEpsChange, IpsId, TimePortability, isGestante, 
		isDiseaseHighCost, isLessOneYear, isAdultHigher, isNoneOfTheAbove, createDate, Observation)     
	VALUES (@typeRequestId, @AffiliateId, @RegimeId, @CityId, @DestinationCity, @isEpsChange, @IpsId, @TimePortability, @isGestante, @isDiseaseHighCost, 
		@isLessOneYear, @isAdultHigher, @isNoneOfTheAbove, GETDATE(), @Observation)
		
	SELECT @@IDENTITY AS requestOfficeVirualId
   
END
GO

GRANT EXECUTE ON [referential].[InsertRequestOfficeVirtual] TO [redprestadores]




