USE [PortalReal]
GO
/****** Object:  StoredProcedure [security].[InsertUsers]    Script Date: 02/24/2016 16:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==================================================================================================================
-- Author:		Aleida Coste
-- Create date: 24/09/2015.
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

ALTER PROCEDURE [security].[InsertUsers]
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
		,@DateExpedition			datetime
		,@CellPhone					VARCHAR(60) =NULL

AS
BEGIN
	
	SET NOCOUNT ON;
	DECLARE @ExistUser INT;
	SET @ExistUser = (SELECT COUNT (*) FROM  [security].[Users] WHERE Login = @Login)

	--//**  ASIGNANDO ROL POR DEFECTO **//--
	DECLARE @Role UNIQUEIDENTIFIER;
	IF(@RoleId = null or @RoleId = '00000000-0000-0000-0000-000000000000' and @RequestTypeId = (SELECT RequestTypeId FROM [referential].[RequestTypes] WHERE Name = 'AFILIADO'))
	begin
		SET		@RoleId = (SELECT RoleId FROM security.rols WHERE Name = 'USUARIO OFICINA VIRTUAL')
	end

	IF(@RoleId = null or @RoleId = '00000000-0000-0000-0000-000000000000' and @RequestTypeId = (SELECT RequestTypeId FROM [referential].[RequestTypes] WHERE Name = 'IPS'))
	begin
		SET		@RoleId = (SELECT RoleId FROM security.rols WHERE Name = 'PRESTADOR OFICINA VIRTUAL')
	end
	 
	--//**  ASIGNANDO OFICINA **//--
	DECLARE @OfficeId	UNIQUEIDENTIFIER
	IF(@RequestTypeId = (SELECT RequestTypeId FROM [referential].[RequestTypes] WHERE Name = 'AFILIADO'))
	begin
		SET		@OfficeId = (select OfficeId from interface.Offices where ZonalId='88FE8FEA-88F3-E011-9B34-001A64900F54')
	end

	IF(@RequestTypeId = (SELECT RequestTypeId FROM [referential].[RequestTypes] WHERE Name = 'IPS'))
	begin
		SET		@OfficeId = (select OfficeId from interface.Offices where CityId = @CityId)
	end


	--//**  Registro de usuario **//--
	IF(@ExistUser = 0)
	begin 
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
						,(select NodeId from referential.Nodes where Code = 'SA') )

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
					   ,(select UserId from security.Users where Login = @Login))

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
			 VALUES    ( (select UserId from security.Users where Login = @Login)
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
			--//* Permite actualizar la tabla de afiliados Miguel Mesa. 05/02/2016
			
			IF(@RequestTypeId = (SELECT RequestTypeId FROM [referential].[RequestTypes] WHERE Name = 'AFILIADO'))
			begin
				update [PortalReal].[affiliation].[Affiliates] set IdentificationDate = @DateExpedition,
				Email = @Email,
				CellPhone = @CellPhone
				where IdentificationNumber = @IdentificationNumber
			end
			
			
	end
END
