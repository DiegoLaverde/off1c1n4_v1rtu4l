SELECT * 
FROM security.Users

SELECT *
FROM security.Menus
WHERE MenuId LIKE '%OfficeVirtual%'

SELECT *
FROM security.Rols 

SELECT * FROM referential.Regimes

SELECT * FROM referential.IdentificationTypes

SELECT IdentificationDate, * FROM affiliation.Affiliates
WHERE IdentificationNumber ='88269176'

SELECT TOP 1000 RN.Name, AA.*
FROM affiliation.Affiliates AA
	INNER JOIN referential.Nodes RN ON AA.NodeId = RN.NodeId
	

UPDATE security.Menus
SET Option3 ='1'
WHERE MenuId ='MVCModule.Module.Views.OfficeVirtual'

SELECT *
FROM security.Users
WHERE IdentificationNumber ='37657358'


1051742363

SELECT TOP 1000 RIT.Code, *
FROM affiliation.Affiliates AA
	INNER JOIN referential.Regimes RR ON AA.RegimeId = RR.RegimeId
	INNER JOIN referential.AffiliateTypes RAT ON AA.AffiliateTypeId = RAT.AffiliateTypeId
	INNER JOIN referential.IdentificationTypes RIT ON AA.IdentificationTypeId = RIT.IdentificationTypeId
WHERE RR.Code = 'C' AND RAT.Code <> 'C'

(SELECT RegimeId FROM referential.Regimes WHERE Code='C')

UPDATE referential.EmailRequestOfficeVirtual
SET EMail = 'DiegoLaverde@saludvidaeps.com'

SELECT IPS.IpsId, 
	MAX(Address) AS Address, 
	MAX(TradeName) AS TradeName, 
	MAX(Phone) AS Phone, 
	MAX(S.Name) AS Description, 
	MAX(S.Code) AS Code,
	MAX(S.Name) AS Nem,
	MAX(RR.Name) AS NameRegime,
	IPC.LowComplexity,
	ICS.IsCapita
--SELECT S.*, IPS.*	
FROM [PortalReal].[contract].[Ips] IPS 
	INNER JOIN PortalReal.contract.IpsContracts IPC ON IPS.IpsId = IPC.IpsId AND IPC.LowComplexity =1 AND IPC.MediumComplexity =0 AND IPC.HighComplexity=0
	INNER JOIN PortalReal.contract.[IpsContractServices] ICS ON ICS.IpsContractId = IPC.IpsContractId AND ICS.IsCapita=1 
	INNER JOIN [PortalReal].[referential].[Services]  S ON ICS.ServiceId = S.ServiceId 
	INNER JOIN referential.Regimes RR ON IPC.RegimeId = RR.RegimeId
	INNER JOIN referential.Nodes RN ON IPC.NodeId = RN.NodeId AND RN.Code = 'LE'
WHERE IPS.CityId = '8930FE3B-3247-DF11-94F5-0027134F884A'
	AND S.Code = '328'
	AND IsActive=1
GROUP BY IPS.IpsId, IPC.LowComplexity, ICS.IsCapita	

SELECT * 
FROM interface.Cities
WHERE Name LIKE '%BARRANQUILLA%'

SELECT * 
FROM PortalReal.contract.IpsContracts IPC
	INNER JOIN PortalReal.contract.[IpsContractServices] ICS ON ICS.IpsContractId = IPC.IpsContractId AND ICS.IsCapita=0
	INNER JOIN [PortalReal].[referential].[Services]  S ON ICS.ServiceId = S.ServiceId 
	INNER JOIN referential.Nodes RN ON IPC.NodeId = RN.NodeId AND RN.Code = 'LE'
WHERE IPS.CityId = '8930FE3B-3247-DF11-94F5-0027134F884A'


SELECT * FROM referential.EmailRequestOfficeVirtual

UPDATE referential.EmailRequestOfficeVirtual
SET EMail ='monicaleon@saludvidaeps.com'


SELECT Email, * FROM affiliation.Affiliates
WHERE IdentificationNumber ='7182274'
