USE [PortalReal]
GO
-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Miguel Mesa>
-- Create date: <Create Date,16/02/2016,>
-- Description:	<Description,Procedure ,>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE name ='getEmailForRecovery' AND SCHEMA_NAME(schema_id)= 'security') 
BEGIN
	DROP PROCEDURE [security].[getEmailForRecovery]
END
GO
CREATE PROCEDURE [security].[getEmailForRecovery] 
	-- Add the parameters for the stored procedure here
	(@Email Varchar(50),
	@IdentificationNumber varchar(50),
	@IdentificationType uniqueidentifier)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select count (EMail) from security.UserDatas ud
	inner join security.Users u on u.UserId = ud.UserId
	inner join referential.IdentificationTypes it on u.IdentificationTypeId = it.IdentificationTypeId
	where ud.EMail = @Email and u.IdentificationNumber = @IdentificationNumber and it.IdentificationTypeId = @IdentificationType
END
GO