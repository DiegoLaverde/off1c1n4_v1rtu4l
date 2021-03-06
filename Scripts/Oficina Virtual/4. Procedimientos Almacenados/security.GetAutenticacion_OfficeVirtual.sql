USE [PortalReal]
GO
/****** Object:  StoredProcedure [security].[GetAutenticacion]    Script Date: 04/26/2016 09:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================================================
-- Author: Aleida Coste.
-- Create date: 2015-09-18
-- Description:	Obtiene la información del usuario a iniciar sesion 

-- Fields Documentation:
--
-- > @Login:	Login del usuario a iniciar sesion.
-- > @Pass:	Contraseña encriptada del usuario a iniciar sesion.
-- ==========================================================================
IF EXISTS (SELECT * FROM sys.objects WHERE name ='GetAutenticacion_OfficeVirtual' AND SCHEMA_NAME(schema_id)= 'security')  
BEGIN
	DROP PROCEDURE [security].[GetAutenticacion_OfficeVirtual] 
END
GO
CREATE PROCEDURE [security].[GetAutenticacion_OfficeVirtual]
  @Login VARCHAR(50)
 ,@Pass VARCHAR(50)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT  a.UserId
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
		,AA.AffiliateId
		,RR.RegimeId
		,RR.Name as Regimen
		,AA.ResidenceAddress
		,CI.TradeName
		,RN.Name codeState
	FROM security.Users as a 
		INNER JOIN security.Rols b ON 	a.RoleId = b.RoleId
		INNER JOIN referential.IdentificationTypes c ON a.IdentificationTypeId = c.IdentificationTypeId
		LEFT JOIN [security].[UserDatas] ud ON a.UserId  = ud.UserId
		INNER JOIN [security].[UserOffices] d ON a.UserId = d.UserId
		INNER JOIN [interface].[Offices] e ON d.OfficeId = e.OfficeId
		INNER JOIN [interface].[Zonal] f ON e.ZonalId = f.ZonalId
		INNER JOIN [interface].[Cities] g ON e.CityId = g.CityId
		INNER JOIN [interface].[Departments] h ON g.DepartmentId = h.DepartmentId 
		INNER JOIN affiliation.Affiliates AA ON a.IdentificationNumber = AA.IdentificationNumber
		INNER JOIN referential.Regimes RR ON AA.RegimeId = RR.RegimeId 	
		INNER JOIN contract.Ips CI ON AA.IpsId = CI.IpsId
		INNER JOIN referential.Nodes RN ON AA.NodeId = RN.NodeId
	WHERE UPPER(a.Login) = @Login
		AND UPPER(a.Password) = @Pass
		AND a.RoleId  = (SELECT RoleId FROM security.Rols WHERE Name='AFILIADO')
		AND a.IsActive =1

END
GO

GRANT EXECUTE ON [security].[GetAutenticacion_OfficeVirtual] TO [redprestadores]
