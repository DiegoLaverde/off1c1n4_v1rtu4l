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
CREATE PROCEDURE [affiliation].[getBeneficiariesPdf] 
	-- Add the parameters for the stored procedure here
	(@guid uniqueidentifier)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select at.Name as Tipo, IdentificationNumber,FirstName, SecondName, FatherLastName, MotherLastName, ks.Name as kindship , Af.ContractStartingDate, nod.Name as Statu 
	from [PortalReal].affiliation.Affiliates Af
	inner join [PortalReal].[referential].[AffiliateTypes] At on Af.AffiliateTypeId = At.AffiliateTypeId
	left outer join [PortalReal].[referential].Kinships Ks on af.KinshipId = ks.KinshipId
	inner join [PortalReal].[referential].[Nodes] Nod on Af.NodeId = Nod.NodeId 
	where Af.SuscriberId = @guid
END
GO
