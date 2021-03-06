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
IF EXISTS (SELECT * FROM sys.objects WHERE name ='getAllProviderClass' AND SCHEMA_NAME(schema_id)= 'affiliation') 
BEGIN
	DROP PROCEDURE [affiliation].[getAllProviderClass]
END
GO
CREATE PROCEDURE [affiliation].[getAllProviderClass] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT [ProviderClassId]
      ,[Code]
      ,[Name]
      ,[CreatedBy]
      ,[CreationDate]
      ,[UpdateBy]
      ,[UpdateDate]
  FROM [PortalReal].[referential].[ProviderClass]
END