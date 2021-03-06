USE [PortalReal]
GO
/****** Object:  StoredProcedure [security].[InsertUsers]    Script Date: 02/24/2016 16:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==================================================================================================================
-- Author:		Diego F Laverde V
-- Create date: 19/05/2016.
-- Description:	Guarda información del usuario creado. Solo permite crear en esta opcion no se puede actualizar.

-- Parameters description:
--
--		> @Login:					Nombre de usuario que se asignará para el inicio de sesion	
--		> @Domain:					Dominio al que pertenece el usuario a registrar.	
--		> @Password:				Contraseña encriptada para el inicio de sesion.
--		> @RoleId:					Identificador del rol asignado al usuario a registrar.
--		> @CreatedBy:				Usuario que realiza realzia el registro.
--		> @UpdateBy:				Usuario que realiza actualiza el registro.
--		> @IsActive:				Indicador si el usuario esta activo.
--		> @TradeName:				Nombre del usuario a registrar (Solo IPS).
--		> @IdentificationTypeId:	Identificador del tipo de documento.
--		> @IdentificationNumber:	Número de identificación del usuario a registrar.
--		> @IsExternal:				Indicador si es un usuario externo.
--		> @Names:					Nombres del usuario a registrar (Solo Afiliado).
--		> @FatherLastName:			Primer apellido del usuario a registrar (Solo Afiliado). 
--		> @MotherLastName:			Segundo apellido del usuario a registrar (Solo Afiliado).
--		> @CityId:					Identificador de la Ciudad a la que pertence el usuario a registrar.
--		> @RequestTypeId:			Identificador del tipo de solicitante.
--		> @NodeId:					Indicador o estado del afiliado (SA => Sin Autorización por defecto ).
--		> @@DateExpedition			Fecha de expedicion de la cedula
-- ==================================================================================================================
IF EXISTS (SELECT * FROM sys.objects WHERE name ='InsertUsers' AND SCHEMA_NAME(schema_id)= 'security') 
BEGIN
	DROP PROCEDURE [security].[InsertUsers]
END
GO
CREATE PROCEDURE [security].[InsertUsers]
		 @Login						VARCHAR(50)
		,@Domain					VARCHAR(50)
		,@Password					VARCHAR(50)
		,@RoleId					UNIQUEIDENTIFIER
		,@CreatedBy					VARCHAR(50)
		,@UpdateBy					VARCHAR(50)
		,@IsActive					BIT
		,@TradeName					VARCHAR(50)
		,@IdentificationTypeId		UNIQUEIDENTIFIER
		,@IdentificationNumber		VARCHAR(16)
		,@IsExternal				BIT
		,@Names						VARCHAR(60)
		,@FatherLastName			VARCHAR(30)
		,@MotherLastName			VARCHAR(30)
		,@CityId				 	UNIQUEIDENTIFIER
		,@RequestTypeId				UNIQUEIDENTIFIER
		,@Area						VARCHAR(60)
		,@Email						VARCHAR(60)
		,@Phone						VARCHAR(60)
		--,@NodeId					UNIQUEIDENTIFIER
		,@DateExpedition			DATETIME =NULL
		,@CellPhone					VARCHAR(60) =NULL

AS
BEGIN
	
	SET NOCOUNT ON;
	
	DECLARE @OfficeId	UNIQUEIDENTIFIER
	DECLARE @NameTypeAffiliate VARCHAR(50)
	
	IF NOT EXISTS(SELECT * FROM  [security].[Users] WHERE Login = @Login)
	BEGIN
		SELECT @NameTypeAffiliate = Name 
		FROM referential.TypesAffiliateOfficeVirtual
		WHERE RequestTypeId = @RequestTypeId	
		
		IF @NameTypeAffiliate ='AFILIADO'
		BEGIN
					
			SELECT @OfficeId = OfficeId FROM interface.Offices WHERE ZonalId='88FE8FEA-88F3-E011-9B34-001A64900F54'
			SELECT @RequestTypeId = RequestTypeId FROM referential.RequestTypes WHERE Name='AFILIADO'
			SELECT @RoleId = RoleId FROM security.Rols WHERE Name='AFILIADO'			
				
		END
		ELSE
		BEGIN
			IF  @NameTypeAffiliate = 'PRESTADORES'
			BEGIN
				SELECT @OfficeId = OfficeId FROM interface.Offices WHERE CityId = @CityId
			END
		END
		
		--//**  Registro de usuario **//--

		INSERT INTO [security].[Users]
				   ([Login]
				   ,[Domain]
				   ,[Password]
				   ,[RoleId]
				   ,[CreatedBy]
				   ,[CreationDate]
				   ,[UpdateBy]
				   ,[UpdateDate]
				   ,[IsActive]
				   ,[TradeName]
				   ,[IdentificationTypeId]
				   ,[IdentificationNumber]
				   ,[IsExternal]
				   ,[Names]
				   ,[FatherLastName]
				   ,[MotherLastName]
				   ,[CityId]
				   ,[VerificationDigit]
				   ,[RequestTypeId]
				   ,[IsAgentCallCenter]
				   ,[NodeId])
		VALUES(		 @Login
					,@Domain
					,@Password
					,@RoleId
					,@CreatedBy
					,GETDATE()
					,@UpdateBy
					,GETDATE()
					,@IsActive
					,@TradeName
					,@IdentificationTypeId
					,@IdentificationNumber
					,@IsExternal
					,@Names
					,@FatherLastName
					,@MotherLastName
					,@CityId
					,0
					,@RequestTypeId
					,0
					,(SELECT NodeId FROM referential.Nodes WHERE Code = 'SA') )

		--//*	Guarda el email y telefono en la tabla UserDatas *//--
		INSERT INTO [security].[UserDatas]
				   ([Area]
				   ,[EMail]
				   ,[Phone]
				   ,[CreatedBy]
				   ,[CreationDate]
				   ,[UpdateBy]
				   ,[UpdateDate]
				   ,[UserId])
			 VALUES
				   (@Area
				   ,@EMail
				   ,@Phone
				   ,@CreatedBy
				   ,GETDATE()
				   ,@UpdateBy
				   ,GETDATE()
				   ,(SELECT UserId FROM security.Users WHERE Login = @Login))

		--//*	Asigna la oficina al usuario por defecto Nivel Central *//--
		INSERT INTO [security].[UserOffices]
				   ([UserId]
				   ,[OfficeId]
				   ,[IsDefault]
				   ,[CreatedBy]
				   ,[CreationDate]
				   ,[UpdateBy]
				   ,[UpdateDate]
				   ,[IsActive])
		 VALUES    ( (SELECT UserId FROM security.Users WHERE Login = @Login)
					,@OfficeId
					,1
					,@CreatedBy
					,GETDATE()
					,@UpdateBy
					,GETDATE()
					,1)

			SELECT	UserId,RoleId
			FROM	[security].[Users]
			WHERE	[Login] = @Login	
			
			IF @NameTypeAffiliate ='AFILIADO'
			BEGIN
				UPDATE [PortalReal].[affiliation].[Affiliates] 
				SET IdentificationDate = @DateExpedition,
					Email = @Email,
					CellPhone = @CellPhone,
					ResidencePhone = @Phone
				WHERE IdentificationNumber = @IdentificationNumber
			END		
	END
END

