USE [PortalReal]
GO
/****** Object:  StoredProcedure [security].[GetAutenticacion]    Script Date: 05/02/2016 15:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================================================
-- Author:		Aleida Coste.
-- Create date: 2015-09-18
-- Description:	Obtiene la información del usuario a iniciar sesion 

-- Fields Documentation:
--
--		> @Login:	Login del usuario a iniciar sesion.
--		> @Pass:	Contraseña encriptada del usuario a iniciar sesion.
-- ==========================================================================

ALTER PROCEDURE [security].[GetAutenticacion]
		 @Login		VARCHAR(50)
		,@Pass		VARCHAR(50)
AS
	BEGIN
	
		SET NOCOUNT ON;

			SELECT		 a.UserId
						,a.Login
						,a.Domain
						,a.Password
						,a.IsActive IsActiveUser
						,a.IdentificationNumber
						,a.IsExternal
						,ISNULL(a.FatherLastName,'') FatherLastName
						,ISNULL(a.MotherLastName,'') MotherLastName
						,ISNULL(a.Names,'') Names
						,ISNULL(ud.EMail,'') EMail
						,ISNULL(ud.Phone,'') Phone
						--* Información del Rol *--
						,b.RoleId 
						,ISNULL(b.Name,'') NameRol
						,b.IsActive IsActiveRol
						--* Información del Tipo de Identificación *--
						,c.IdentificationTypeId
						,c.Code CodeIdt
						,c.Name NameIdt
						--* Información de la oficina del usuario *--
						,d.UserOfficeId
						,d.IsActive IsActiveOffice
						,d.OfficeId
						,e.Code CodeOffice
						,ISNULL(e.Name,'') NameOffice
						,e.State StateOffice
						,g.CityId
						,g.Code CodeCity 
						,g.Name NameCity
						,h.DepartmentId
						,h.Code CodeDepartment
						,h.Name NameDepartment
						--* Información de la Zonal *--
						,f.ZonalId
						,f.Code CodeZonal
						,f.Name NameZonal
			FROM		security.Users as a 
			inner join	security.Rols b 
			ON			a.RoleId = b.RoleId
			inner join  referential.IdentificationTypes c 
			ON			a.IdentificationTypeId = c.IdentificationTypeId
			left join	[security].[UserDatas] ud 
			ON			a.UserId  = ud.UserId
			inner join  [security].[UserOffices] d 
			ON			a.UserId = d.UserId
			inner join	[interface].[Offices] e 
			ON			d.OfficeId = e.OfficeId
			inner join	[interface].[Zonal] f 
			ON			e.ZonalId = f.ZonalId
			inner join  [interface].[Cities] g 
			ON			e.CityId = g.CityId
			inner join	[interface].[Departments] h 
			ON			g.DepartmentId = h.DepartmentId 
			WHERE	1=1              
			AND		UPPER(a.Login) = @Login
			AND		UPPER(a.Password) = @Pass
	END
