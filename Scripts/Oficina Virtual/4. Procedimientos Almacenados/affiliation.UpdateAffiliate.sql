USE [PortalReal]
GO
/****** Object:  StoredProcedure [affiliation].[UpdateAffiliate]    Script Date: 04/26/2016 15:56:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Miguel Mesa>
-- Create date: <Create Date,25/02/2016,>
-- Description:	<Description,Procedure ,>
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE name ='UpdateAffiliate' AND SCHEMA_NAME(schema_id)= 'affiliation') 
BEGIN
	DROP PROCEDURE [affiliation].[UpdateAffiliate]
END
GO
CREATE PROCEDURE [affiliation].[UpdateAffiliate] 
	-- Add the parameters for the stored procedure here
	@IdentificationNumber Varchar(50),
	@ResidencePhone Varchar(max),
	@Email varchar(max),
	@code varchar(10),
	@CellPhone Varchar(max) = NULL,
	@ResidenceAddress VARCHAR(MAX)
AS
BEGIN
	DECLARE @UserId AS UNIQUEIDENTIFIER
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
    
    
	UPDATE Af
	SET ResidencePhone = @ResidencePhone, Email = @Email, CellPhone = @CellPhone, ResidenceAddress =@ResidenceAddress
	FROM [PortalReal].affiliation.Affiliates Af
		INNER JOIN [PortalReal].[referential].[IdentificationTypes]  as idtype on idtype.IdentificationTypeId = Af.IdentificationTypeId
	WHERE Af.IdentificationNumber = @IdentificationNumber and idtype.Code = @Code
	
	SELECT @UserId = UserId
	FROM security.Users
	WHERE IdentificationNumber =@IdentificationNumber
		
	UPDATE [security].[UserDatas]
	SET EMail = @Email
	WHERE UserId =@UserId
	
END
