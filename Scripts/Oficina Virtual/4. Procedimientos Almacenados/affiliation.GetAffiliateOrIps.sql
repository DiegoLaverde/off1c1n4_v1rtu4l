USE [PortalReal]
GO
/****** Object:  StoredProcedure [affiliation].[GetAffiliateOrIps]    Script Date: 02/02/2016 11:14:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ========================================================================================================================
-- Author:		Aleida Coste.
-- Create date: 2015-08-10
-- Description:	Obtiene y valida la información del afiliado o Ips antes registrarse como usuario para acceder al aplicativo.

-- Parameters documentation:
--
--		> @TypeIdentificationId:		Identificador del tipo de afiliado a buscar.
--		> @IdentificationNumber:		Número de identificación del afiliado a  buscar.
--		> @RequestName:					Tipo de solicitante (IPS/Afiliado).
--		> @Login:						Usuario o login de afiliado o ips a registrar.
-- ========================================================================================================================
IF EXISTS (SELECT * FROM sys.objects WHERE name ='GetAffiliateOrIps' AND SCHEMA_NAME(schema_id)= 'affiliation')  
BEGIN
	DROP PROCEDURE [affiliation].[GetAffiliateOrIps] 
END
GO
CREATE PROCEDURE [affiliation].[GetAffiliateOrIps] 
	 @TypeIdentificationId		UNIQUEIDENTIFIER 
	,@IdentificationNumber		VARCHAR(16) 
	,@RequestName				VARCHAR(50) 
	,@Login						VARCHAR(50) 

AS
BEGIN

	SET NOCOUNT ON;

	IF(@RequestName ='AFILIADO' )
	BEGIN
		DECLARE @regimenId UNIQUEIDENTIFIER
		DECLARE @regimenCode VARCHAR(5)
		DECLARE @regimenName VARCHAR(50)
		DECLARE @typeAffiliateCode VARCHAR(5)
		DECLARE @Pass BIT
		SET @Pass =1
		
		SELECT @regimenId = AA.RegimeId, @regimenCode = RR.Code, @typeAffiliateCode = RAT.Code
		FROM affiliation.Affiliates AA
			INNER JOIN referential.Regimes RR ON AA.RegimeId = RR.RegimeId
			INNER JOIN referential.AffiliateTypes RAT ON AA.AffiliateTypeId = RAT.AffiliateTypeId
		WHERE AA.IdentificationNumber = @IdentificationNumber
			AND AA.IdentificationTypeId = @TypeIdentificationId
			
		IF @regimenCode ='C' AND @typeAffiliateCode <> 'C'
		BEGIN
			SET @Pass =0
		END
		
		IF @Pass=1
		BEGIN
			SELECT	Aff.IdentificationTypeAff
				,Aff.IdentificationCodeAff
				,Aff.IdentificationNameAff
				,Aff.IdentificationNumberAff
				,Aff.FirstName + ' ' + Aff.SecondName Names
				,Aff.FatherLastName
				,Aff.MotherLastName
				,Aff.CityIdAff
				,Aff.CityCodeAff
				,Aff.CityNameAff
				,Aff.Email
				,Aff.CellPhone
				,Aff.ResidencePhone
				,Aff.IdentificationDate --Miguel Mesa, se agrego campo de FEcha de expedicion de documento.
				,(SELECT CASE COUNT (*) 
						WHEN 0  THEN ''
						ELSE 'Ya existe el usuario ' +  @IdentificationNumber + ' .No se puede crear, por favor intente con otro usuario.'	
						END
				  FROM  [security].[Users] 
				  WHERE IdentificationNumber = @IdentificationNumber
					AND IdentificationTypeId = @TypeIdentificationId
					AND RoleId = (SELECT RoleId FROM security.Rols WHERE Name='AFILIADO') ) MessageValidation
			FROM	[auditory].[ViewAffiliateById] Aff
			WHERE	IdentificationNumberAff = @IdentificationNumber
				AND	IdentificationTypeAff = @TypeIdentificationId
				AND	AFF.RegimeId = @regimenId
			
		END
		ELSE
		BEGIN
			SELECT	 Aff.IdentificationTypeAff
					,Aff.IdentificationCodeAff
					,Aff.IdentificationNameAff
					,Aff.IdentificationNumberAff
					,Aff.FirstName + ' ' + Aff.SecondName Names
					,Aff.FatherLastName
					,Aff.MotherLastName
					,Aff.CityIdAff
					,Aff.CityCodeAff
					,Aff.CityNameAff
					,Aff.Email
					,Aff.CellPhone
					,Aff.ResidencePhone
					,Aff.IdentificationDate --Miguel Mesa, se agrego campo de FEcha de expedicion de documento.
					,'El afiliado ' +  @IdentificationNumber + ' .No es el cotizante.' MessageValidation
				FROM	[auditory].[ViewAffiliateById] Aff
				WHERE	IdentificationNumberAff = @IdentificationNumber
					AND	IdentificationTypeAff = @TypeIdentificationId
					AND	AFF.RegimeId = @regimenId
			END
	END	
	ELSE
	BEGIN
		SELECT	*
				,(SELECT CASE COUNT (*) 
						WHEN 0  THEN ''
						ELSE 'Ya existe el usuario ' +  @Login + ' .No se puede crear, por favor intente con otro usuario.'	
						END
				  FROM  [security].[Users] WHERE Login = @Login) MessageValidation
		FROM	[auditory].[ViewIpsById] ips
		WHERE	1=1
		AND		ips.IdentificationNumberIps = @IdentificationNumber    
		AND		ips.IdentificationTypeIps = @TypeIdentificationId
		ORDER BY ips.IpsId ASC 
	END

END
GO

GRANT EXECUTE ON [affiliation].[GetAffiliateOrIps] TO [redprestadores]
