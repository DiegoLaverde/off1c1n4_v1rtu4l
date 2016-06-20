USE [PortalReal]
GO
/****** Object:  StoredProcedure [affiliation].[getBeneficiariesPdf]    Script Date: 04/05/2016 15:28:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Miguel Mesa>
-- Create date: <Create Date,16/02/2016,>
-- Description:	<Description,Procedure ,>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE name ='GetIps' AND SCHEMA_NAME(schema_id)= 'Contract') 
BEGIN
	DROP PROCEDURE [Contract].[GetIps]
END
GO
CREATE PROCEDURE [Contract].[GetIps] 
	-- Add the parameters for the stored procedure here
	(@CityId as uniqueidentifier,
	@ProviderClassId as uniqueidentifier)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT [IpsId]
      ,[IdentificationNumber]
      ,[VerificationDigit]
      ,[AssignedCode]
      ,[Address]
      ,[Fax]
      ,[IsApproved]
      ,[RegisterDate]
      ,[LapsetDate]
      ,[InternalCode]
      ,[TradeName]
      ,[IsSocialEnterprise]
      ,[OfficialDocumentNumber]
      ,[OfficialDocumentDate]
      ,[ExpeditionEntity]
      ,[FatherLastName]
      ,[MotherLastName]
      ,[FirstName]
      ,[SecondName]
      ,[IsRural]
      ,[Area]
      ,[Website]
      ,[ManagerIdentificationNumber]
      ,[ManagerName]
      ,[VillageName]
      ,[SmallTownName]
      ,[Phone]
      ,[HoursCare]
      ,[IdentificationTypeId]
      ,[LegalNatureId]
      ,[CityId]
      ,[LegalRepresentativeId]
      ,[OfficialNatureId]
      ,[MainIpsId]
      ,[ProviderTypeId]
      ,[ProviderClassId]
      ,[OfficialDocumentId]
      ,[NodeId]
      ,[TypeOfPerson]
      ,[Registered]
      ,[Enabled]
      ,[Certified]
      ,[LowComplexity]
      ,[MediumComplexity]
      ,[HighComplexity]
      ,[HasIntentionLetter]
      ,[CreatedBy]
      ,[CreationDate]
      ,[UpdateBy]
      ,[UpdateDate]
      ,[IsAmbulatory]
      ,[IsHospitaler]
      ,[InfoCreate]
      ,[InfoUpdate]
      ,[IpsClub]
      ,[IsActive]
  FROM [PortalReal].[contract].[Ips]
  
  where CityId = @CityId and ProviderClassId = @ProviderClassId 





END