INSERT INTO referential.TypesAffiliateOfficeVirtual (RequestTypeId, Code, Name, CreatedBy, CreationDate, UpdateBy, UpdateDate, RoleId)
VALUES (NEWID(), 'AF', 'AFILIADO', 'GENERAL\DIEGO', GETDATE(), 'GENERAL\DIEGO', GETDATE(), (SELECT RoleId FROM security.Rols WHERE Name='AFILIADO'))

INSERT INTO referential.TypesAffiliateOfficeVirtual (RequestTypeId, Code, Name, CreatedBy, CreationDate, UpdateBy, UpdateDate, RoleId)
VALUES (NEWID(), 'PR', 'PRESTADOR', 'GENERAL\DIEGO', GETDATE(), 'GENERAL\DIEGO', GETDATE(), (SELECT RoleId FROM security.Rols WHERE Name='PRESTADOR'))

INSERT INTO referential.TypesAffiliateOfficeVirtual (RequestTypeId, Code, Name, CreatedBy, CreationDate, UpdateBy, UpdateDate, RoleId)
VALUES (NEWID(), 'EMP', 'EMPLEADOR', 'GENERAL\DIEGO', GETDATE(), 'GENERAL\DIEGO', GETDATE(), (SELECT RoleId FROM security.Rols WHERE Name='EMPLEADOR'))