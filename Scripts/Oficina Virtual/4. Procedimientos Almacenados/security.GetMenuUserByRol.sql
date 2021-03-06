USE [PortalReal]
GO
/****** Object:  StoredProcedure [security].[GetMenuUserByRol]    Script Date: 04/25/2016 14:59:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =================================================================================
-- Author:		Aleida Coste.
-- Create date: 2015-09-21
-- Description:	Obtiene los Menus asociados al rol del usuario.

-- Fields Documentation:
--
--		> @RolId:	Identificador del rol asociado al usuario que inicia sesion.
-- =================================================================================

ALTER PROCEDURE [security].[GetMenuUserByRol]
		@RolId		UNIQUEIDENTIFIER
		
AS
	BEGIN
		
		SET NOCOUNT ON;

		SELECT 		 RP.RolePermissionId
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
					,IsChild = CASE

						 WHEN LEN(M.MenuId)- LEN(REPLACE(M.MenuId,'.','')) >3 

						 THEN 1

						 WHEN LEN(M.MenuId)- LEN(REPLACE(M.MenuId,'.','')) <=3 

						 THEN 0

						 END
					,ISNULL(M.Name,'') Menu_Name
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
					,ISNULL(M.PositionMenu,'') Menu_PositionMenu
					,ISNULL(M.URL,'') Menu_URL
		FROM		security.RolePermissions RP
		inner join	security.Menus M 
		ON			RP.MenuId = M.MenuId
		WHERE		1=1
		AND			RoleId = @RolId
		AND			RP.IsActive = 1
		ORDER BY	M.PositionMenu

	END
