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
IF EXISTS (SELECT * FROM sys.objects WHERE name ='getCitiesbyDepartment' AND SCHEMA_NAME(schema_id)= 'affiliation') 
BEGIN
	DROP PROCEDURE [affiliation].[getCitiesbyDepartment] 
END
GO
CREATE PROCEDURE [affiliation].[getCitiesbyDepartment] 
	-- Add the parameters for the stored procedure here
	(@guid uniqueidentifier)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT [CityId]
      ,[Code]
      ,[Name]
      ,[DepartmentId]
      ,[CreatedBy]
      ,[CreationDate]
      ,[UpdateBy]
      ,[UpdateDate]
  FROM [PortalReal].[interface].[Cities]
  where DepartmentId = @guid
  order by Name
END