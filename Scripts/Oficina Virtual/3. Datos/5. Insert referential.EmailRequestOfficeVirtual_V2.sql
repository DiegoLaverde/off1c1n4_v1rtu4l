TRUNCATE TABLE referential.EmailRequestOfficeVirtual

--Cambio ciudad origen 2
INSERT INTO referential.EmailRequestOfficeVirtual (RequestTypeId, RegimeId, CityId, EMail)
SELECT '2', (SELECT RegimeId FROM referential.Regimes WHERE Code='S'), CityId, 'portabilidad@saludvidaeps.com'
FROM interface.Cities 

INSERT INTO referential.EmailRequestOfficeVirtual (RequestTypeId, RegimeId, CityId, EMail)
SELECT '2', (SELECT RegimeId FROM referential.Regimes WHERE Code='C'), CityId, 'portabilidad@saludvidaeps.com'
FROM interface.Cities 

--Cambio IPS
INSERT INTO referential.EmailRequestOfficeVirtual (RequestTypeId, RegimeId, CityId, EMail)
SELECT '4', (SELECT RegimeId FROM referential.Regimes WHERE Code='S'), CityId, 'OficinaVirtual.CambioIPS@saludvidaeps.com'
FROM interface.Cities 

INSERT INTO referential.EmailRequestOfficeVirtual (RequestTypeId, RegimeId, CityId, EMail)
SELECT '4', (SELECT RegimeId FROM referential.Regimes WHERE Code='C'), CityId, 'mariacamargo@saludvidaeps.com'
FROM interface.Cities 

