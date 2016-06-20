---CREAMOS ROLES AFILIADO
INSERT INTO [PortalReal].[security].[Rols] (Name,CreatedBy,CreationDate,UpdateBy,UpdateDate,IsActive,IsSyncActive) 
VALUES ('AFILIADO','developer',GETDATE(),'developer',GETDATE(),1,0)

INSERT INTO [PortalReal].[security].[Rols] (Name,CreatedBy,CreationDate,UpdateBy,UpdateDate,IsActive,IsSyncActive) 
VALUES ('PRESTADOR','developer',GETDATE(),'developer',GETDATE(),1,0)

INSERT INTO [PortalReal].[security].[Rols] (Name,CreatedBy,CreationDate,UpdateBy,UpdateDate,IsActive,IsSyncActive) 
VALUES ('EMPLEADOR','developer',GETDATE(),'developer',GETDATE(),1,0)

--CREAMOS MENUS
--Creamos padre de oficinaVirtual
INSERT INTO [PortalReal].[security].[Menus] (MenuId,Name,IsActive,CreatedBy,CreationDate,UpdateBy,UpdateDate,AppType,PositionMenu, Option1, Option2, Option3)
VALUES('MVCModule.Module.Views.OfficeVirtual','-',1,'desarrollo',GETDATE(),'desarrollo',GETDATE(),5,0,'1', '1', '1')

--Creamos hijos de oficina virtual
--Opcion: Actualizacion datos afiliado
INSERT INTO [PortalReal].[security].[Menus] (MenuId,Name,IsActive,CreatedBy,CreationDate,UpdateBy,UpdateDate,AppType,PositionMenu, URL, Option1, Option2, Option3)
VALUES('MVCModule.Module.Views.OfficeVirtual.UpdateAffiliate','Actualizar Datos Afiliado',1,'desarrollo',GETDATE(),'desarrollo',GETDATE(),5,1, '/SiteAdmin','1', '1', '0')
--Opcion: Consulta Afiliacion
INSERT INTO [PortalReal].[security].[Menus] (MenuId,Name,IsActive,CreatedBy,CreationDate,UpdateBy,UpdateDate,AppType,PositionMenu, URL, Option1, Option2, Option3)
VALUES('MVCModule.Module.Views.OfficeVirtual.StateAffiliate','Consulta Afiliación',1,'desarrollo',GETDATE(),'desarrollo',GETDATE(),5,2, '/Query/InformationAffiliation','1', '1', '0')
--Opcion: Certificado afiliacion
INSERT INTO [PortalReal].[security].[Menus] (MenuId,Name,IsActive,CreatedBy,CreationDate,UpdateBy,UpdateDate,AppType,PositionMenu, URL, Option1, Option2, Option3)
VALUES('MVCModule.Module.Views.OfficeVirtual.CertAfiliation','Certificado Afiliación',1,'desarrollo',GETDATE(),'desarrollo',GETDATE(),5,3, '/GeneralCertificate','1', '1', '1')
--Opcion: Carnet afiliado
INSERT INTO [PortalReal].[security].[Menus] (MenuId,Name,IsActive,CreatedBy,CreationDate,UpdateBy,UpdateDate,AppType,PositionMenu, URL, Option1, Option2, Option3)
VALUES('MVCModule.Module.Views.OfficeVirtual.Carnet','Carné de Afiliado',1,'desarrollo',GETDATE(),'desarrollo',GETDATE(),5,4, '/GeneralCarnet','1', '1', '0')
--Opcion: Consulta Red de Prestadores
INSERT INTO [PortalReal].[security].[Menus] (MenuId,Name,IsActive,CreatedBy,CreationDate,UpdateBy,UpdateDate,AppType,PositionMenu, URL, Option1, Option2, Option3)
VALUES('MVCModule.Module.Views.OfficeVirtual.Network','Consulta Red de Prestadores',1,'desarrollo',GETDATE(),'desarrollo',GETDATE(),5,5, '/NetworkProviders/Index','1', '1', '0')
--Opcion: Traslados
INSERT INTO [PortalReal].[security].[Menus] (MenuId,Name,IsActive,CreatedBy,CreationDate,UpdateBy,UpdateDate,AppType,PositionMenu, URL, Option1, Option2, Option3)
VALUES('MVCModule.Module.Views.OfficeVirtual.TrMoPo','Novedades',1,'desarrollo',GETDATE(),'desarrollo',GETDATE(),5,6, '/Request/TransferMobilityPortability','1', '1', '0')
--Opcion: Estado Cartera
INSERT INTO [PortalReal].[security].[Menus] (MenuId,Name,IsActive,CreatedBy,CreationDate,UpdateBy,UpdateDate,AppType,PositionMenu, URL, Option1, Option2, Option3)
VALUES('MVCModule.Module.Views.OfficeVirtual.StatePortFolio','Estado Cartera',1,'desarrollo',GETDATE(),'desarrollo',GETDATE(),5,7, '/GeneralStatePortFolio','0', '1', '0')
--Opcion: Instructivo
INSERT INTO [PortalReal].[security].[Menus] (MenuId,Name,IsActive,CreatedBy,CreationDate,UpdateBy,UpdateDate,AppType,PositionMenu, URL, Option1, Option2, Option3)
VALUES('MVCModule.Module.Views.OfficeVirtual.Instructive','Instructivo',1,'desarrollo',GETDATE(),'desarrollo',GETDATE(),5,8, '/Manuals/Instructive','1', '1', '0')

--AFILIADO
--Opciones:
--Oficina Virtual
INSERT INTO [PortalReal].[security].RolePermissions (RoleId,IsActive,CreatedBy,CreationDate,UpdateBy,UpdateDate,Saves,Updates,Deletes,Queries,Prints,Option1,Option2,Option3,
	Option4,Option5,Option6,Option7,Option8,Option9,Option10,MenuId) 
VALUES((SELECT RoleId from security.Rols where Name ='AFILIADO'),1,'desarrollo',GETDATE(),'desarrollo',GETDATE(),0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	'MVCModule.Module.Views.OfficeVirtual')
--Actualizacion datos afiliado
INSERT INTO [PortalReal].[security].RolePermissions (RoleId,IsActive,CreatedBy,CreationDate,UpdateBy,UpdateDate,Saves,Updates,Deletes,Queries,Prints,Option1,Option2,Option3,
	Option4,Option5,Option6,Option7,Option8,Option9,Option10,MenuId) 
VALUES((SELECT RoleId from security.Rols where Name ='AFILIADO'),1,'desarrollo',GETDATE(),'desarrollo',GETDATE(),0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	'MVCModule.Module.Views.OfficeVirtual.UpdateAffiliate')
--Consulta Afiliacion
INSERT INTO [PortalReal].[security].RolePermissions (RoleId,IsActive,CreatedBy,CreationDate,UpdateBy,UpdateDate,Saves,Updates,Deletes,Queries,Prints,Option1,Option2,Option3,
	Option4,Option5,Option6,Option7,Option8,Option9,Option10,MenuId) 
VALUES((SELECT RoleId from security.Rols where Name ='AFILIADO'),1,'desarrollo',GETDATE(),'desarrollo',GETDATE(),0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	'MVCModule.Module.Views.OfficeVirtual.StateAffiliate')
--Certificado afiliacion
INSERT INTO [PortalReal].[security].RolePermissions (RoleId,IsActive,CreatedBy,CreationDate,UpdateBy,UpdateDate,Saves,Updates,Deletes,Queries,Prints,Option1,Option2,Option3,
	Option4,Option5,Option6,Option7,Option8,Option9,Option10,MenuId) 
VALUES((SELECT RoleId from security.Rols where Name ='AFILIADO'),1,'desarrollo',GETDATE(),'desarrollo',GETDATE(),0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	'MVCModule.Module.Views.OfficeVirtual.CertAfiliation')
--Carnet afiliado
INSERT INTO [PortalReal].[security].RolePermissions (RoleId,IsActive,CreatedBy,CreationDate,UpdateBy,UpdateDate,Saves,Updates,Deletes,Queries,Prints,Option1,Option2,Option3,
	Option4,Option5,Option6,Option7,Option8,Option9,Option10,MenuId) 
VALUES((SELECT RoleId from security.Rols where Name ='AFILIADO'),1,'desarrollo',GETDATE(),'desarrollo',GETDATE(),0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	'MVCModule.Module.Views.OfficeVirtual.Carnet')
--Consulta Red de Prestadores
INSERT INTO [PortalReal].[security].RolePermissions (RoleId,IsActive,CreatedBy,CreationDate,UpdateBy,UpdateDate,Saves,Updates,Deletes,Queries,Prints,Option1,Option2,Option3,
	Option4,Option5,Option6,Option7,Option8,Option9,Option10,MenuId) 
VALUES((SELECT RoleId from security.Rols where Name ='AFILIADO'),1,'desarrollo',GETDATE(),'desarrollo',GETDATE(),0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	'MVCModule.Module.Views.OfficeVirtual.Network')
--Traslados
INSERT INTO [PortalReal].[security].RolePermissions (RoleId,IsActive,CreatedBy,CreationDate,UpdateBy,UpdateDate,Saves,Updates,Deletes,Queries,Prints,Option1,Option2,Option3,
	Option4,Option5,Option6,Option7,Option8,Option9,Option10,MenuId) 
VALUES((SELECT RoleId from security.Rols where Name ='AFILIADO'),1,'desarrollo',GETDATE(),'desarrollo',GETDATE(),0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	'MVCModule.Module.Views.OfficeVirtual.TrMoPo')
--Estado Cartera
INSERT INTO [PortalReal].[security].RolePermissions (RoleId,IsActive,CreatedBy,CreationDate,UpdateBy,UpdateDate,Saves,Updates,Deletes,Queries,Prints,Option1,Option2,Option3,
	Option4,Option5,Option6,Option7,Option8,Option9,Option10,MenuId) 
VALUES((SELECT RoleId from security.Rols where Name ='AFILIADO'),1,'desarrollo',GETDATE(),'desarrollo',GETDATE(),0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	'MVCModule.Module.Views.OfficeVirtual.StatePortFolio')
--Instructivo
INSERT INTO [PortalReal].[security].RolePermissions (RoleId,IsActive,CreatedBy,CreationDate,UpdateBy,UpdateDate,Saves,Updates,Deletes,Queries,Prints,Option1,Option2,Option3,
	Option4,Option5,Option6,Option7,Option8,Option9,Option10,MenuId) 
VALUES((SELECT RoleId from security.Rols where Name ='AFILIADO'),1,'desarrollo',GETDATE(),'desarrollo',GETDATE(),0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	'MVCModule.Module.Views.OfficeVirtual.Instructive')
	