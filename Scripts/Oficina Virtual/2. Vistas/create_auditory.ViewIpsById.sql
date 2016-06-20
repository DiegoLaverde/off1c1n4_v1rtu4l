USE [PortalReal]
GO

/****** Object:  View [auditory].[ViewIpsById]    Script Date: 05/03/2016 10:17:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP VIEW [auditory].[ViewIpsById]


-- =====================================================================
-- Author:		Aleida Coste.
-- Create date: 10/09/2015.
-- Description:	Obtiene informacion de las IPS desde el maestro.
-- =====================================================================

CREATE VIEW [auditory].[ViewIpsById]
AS	
			SELECT		ISNULL(Ips.IpsId,'00000000-0000-0000-0000-000000000000')  IpsId
						,ISNULL(Ips.IdentificationNumber,'') IdentificationNumberIps
						,ISNULL(Ips.Address,'') AddressIps
						,ISNULL(Ips.TradeName,'') TradeName
						,ISNULL(Ips.Phone,'') Phone
						,ISNULL(Ips.IdentificationTypeId,'00000000-0000-0000-0000-000000000000')  IdentificationTypeIps
						,ISNULL(TypeIps.Code,'') IdentificationCodeIps
						,ISNULL(TypeIps.Name,'') IdentificationNameIps
						,ISNULL(CT.CityId,'00000000-0000-0000-0000-000000000000')   CityIdIps
						,ISNULL(CT.Code,'') CityCodeIps
						,ISNULL(CT.Name,'') CityNameIps
						,ISNULL(DP.DepartmentId,'00000000-0000-0000-0000-000000000000')   DeptartmentIdIps
						,ISNULL(DP.Code,'') DeptartmentCodeIps
						,ISNULL(DP.Name,'') DeptartmentNameIps
						,ISNULL(ZIps.ZonalId,'00000000-0000-0000-0000-000000000000')  ZonalIps
						,ISNULL(ZIps.Code,'')  ZonalCodeIps
						,ISNULL(ZIps.Name,'')  ZonalNameIps
						,CT.Name + ' - ' + DP.Name Municipio
						,Ips.MainIpsId
						,ISNULL(Node.NodeId,'00000000-0000-0000-0000-000000000000')  NodeIdIps
						,ISNULL(Node.Code,'') NodeCodeIps
						,ISNULL(Node.Name,'') NodeNameIps
						,ISNULL(Ips.IsActive,0) IsActive
						--,ISNULL(E.Email,'') Email
						--,ISNULL(E.Area,'') Area
			FROM	contract.Ips as Ips
			--inner join  contract.IpsEmails E
			--ON			Ips.IpsId = E.IpsId
			inner join	interface.Cities as CT 
			ON			Ips.CityId = CT.CityId 
			inner join  interface.Departments as DP 
			ON			CT.DepartmentId = DP.DepartmentId
			inner join	interface.Offices Offi
			ON			CT.CityId = Offi.CityId
			inner join	interface.Zonal ZIps 
			ON			Offi.ZonalId = ZIps.ZonalId
			inner join	referential.IdentificationTypes as TypeIps
			ON			Ips.IdentificationTypeId = TypeIps.IdentificationTypeId
			inner join  referential.Nodes as Node
			ON			Ips.NodeId = Node.NodeId

GO


