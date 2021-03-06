USE [PortalReal]
GO
/****** Object:  StoredProcedure [security].[GetMenuUserByRol]    Script Date: 06/01/2016 08:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =================================================================================
-- Author:		Diego F Laverde V
-- Create date: 01/06/2016
-- Description:	Obtiene los Menus asociados al rol y tipo de regimen del usuario.

-- Fields Documentation:
--
--		> @IdentificationNumber: No de identificacion del usuario.
--      > @IdentificationTypeId: Tipo de identificacion.
-- =================================================================================
IF EXISTS (SELECT * FROM sys.objects WHERE name ='GetMenuUserByRolByRegime' AND SCHEMA_NAME(schema_id)= 'security') 
BEGIN
	DROP PROCEDURE [security].[GetMenuUserByRolByRegime]
END
GO
CREATE PROCEDURE [security].[GetMenuUserByRolByRegime]
		@IdentificationNumber VARCHAR(50),
		@IdentificationTypeId UNIQUEIDENTIFIER		
AS
	BEGIN
		DECLARE @Query NVARCHAR(MAX)
		DECLARE @codeRegime NVARCHAR(5)
		DECLARE @codeNode NVARCHAR(5)
		DECLARE @RolId	UNIQUEIDENTIFIER
		DECLARE @RolIdV NVARCHAR(MAX)
		
		--Obtiene variables base del afiliado
		SELECT @RolId = SU.RoleId, @codeRegime = RR.Code, @codeNode = RN.Code
		FROM affiliation.Affiliates AA
			INNER JOIN security.Users SU ON AA.IdentificationNumber = SU.IdentificationNumber AND AA.IdentificationTypeId = SU.IdentificationTypeId
			INNER JOIN referential.Regimes RR ON AA.RegimeId = RR.RegimeId
			INNER JOIN referential.Nodes RN ON AA.NodeId = RN.NodeId
		WHERE AA.IdentificationNumber = @IdentificationNumber AND AA.IdentificationTypeId = @IdentificationTypeId 
		
		SET @RolIdV = CONVERT(NVARCHAR(36), @RolId)
				
		SET NOCOUNT ON;
		
		SET @Query ='SELECT	RP.RolePermissionId
			,RP.IsActive RolPerm_IsActive
			,ISNULL(RP.Saves,0)   RolPerm_Saves
			,ISNULL(RP.Updates,0) RolPerm_Updates
			,ISNULL(RP.Deletes,0) RolPerm_Deletes
			,ISNULL(RP.Queries,0) RolPerm_Queries
			,ISNULL(RP.Prints,0)  RolPerm_Prints
			,ISNULL(RP.Option1,0) RolPerm_Option1
			,ISNULL(RP.Option2,0) RolPerm_Option2
			,ISNULL(RP.Option3,0) RolPerm_Option3
			,ISNULL(RP.Option4,0) RolPerm_Option4
			,ISNULL(RP.Option5,0) RolPerm_Option5
			,ISNULL(RP.Option6,0) RolPerm_Option6
			,ISNULL(RP.Option7,0) RolPerm_Option7
			,ISNULL(RP.Option8,0) RolPerm_Option8
			,ISNULL(RP.Option9,0) RolPerm_Option9
			,ISNULL(RP.Option10,0) RolPerm_Option10
			,M.MenuId
			,IsChild = CASE WHEN LEN(M.MenuId)- LEN(REPLACE(M.MenuId,''.'','''')) >3 
						 THEN 1
							WHEN LEN(M.MenuId)- LEN(REPLACE(M.MenuId,''.'','''')) <=3 
						 THEN 0
						 END
			,ISNULL(M.Name,'''') Menu_Name
			,M.IsActive Menu_IsActive
			,ISNULL(M.Option1,0) Menu_Option1
			,ISNULL(M.Option2,0) Menu_Option2
			,ISNULL(M.Option3,0) Menu_Option3
			,ISNULL(M.Option4,0) Menu_Option4
			,ISNULL(M.Option5,0) Menu_Option5
			,ISNULL(M.Option6,0) Menu_Option6
			,ISNULL(M.Option7,0) Menu_Option7
			,ISNULL(M.Option8,0) Menu_Option8
			,ISNULL(M.Option9,0) Menu_Option9
			,ISNULL(M.Option10,0) Menu_Option10
			,M.AppType
			,ISNULL(M.PositionMenu,'''') Menu_PositionMenu
			,ISNULL(M.URL,'''') Menu_URL
		FROM security.RolePermissions RP
			INNER JOIN security.Menus M ON RP.MenuId = M.MenuId
		WHERE RoleId = ''' + @RolIdV + ''' ' +
			'AND RP.IsActive = 1'
		
		--Se define para el tipo de regimen
		IF @codeRegime ='S'
		BEGIN
			SET @Query = @Query + ' AND M.Option1 = ''1'' '
		END
		ELSE
		BEGIN
			SET @Query = @Query + ' AND M.Option2 = ''1'' '
		END
		
		--Se define para si el estado del afiliado es retirado
		IF @codeNode ='RE'
		BEGIN
			SET @Query = @Query + ' AND M.Option3 = ''1'' '
		END
		
		SET @Query = @Query + ' ORDER BY RP.RolePermissionId'
		
		PRINT @Query
		
		EXEC sp_executesql @Query
		
	END
