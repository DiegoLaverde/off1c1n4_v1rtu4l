USE [PortalReal]
GO

/****** Object:  View [auditory].[ViewAffiliateById]    Script Date: 05/03/2016 10:23:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =====================================================================
 Author:		Aleida Coste.
 Create date: 10/09/2015.
 Description:	Obtiene informacion de los afiliados del maestro.
 =====================================================================*/
DROP VIEW [auditory].[ViewAffiliateById]
GO
CREATE VIEW [auditory].[ViewAffiliateById]
AS
SELECT     ISNULL(Aff.AffiliateId, '00000000-0000-0000-0000-000000000000') AS AffiliateId, ISNULL(Aff.IdentificationNumber, '') AS IdentificationNumberAff, ISNULL(Aff.FatherLastName, '') AS FatherLastName, 
                      ISNULL(Aff.MotherLastName, '') AS MotherLastName, ISNULL(Aff.FirstName, '') AS FirstName, ISNULL(Aff.SecondName, '') AS SecondName, ISNULL(Aff.BirthDate, '') AS BirthDate, DATEDIFF(day, 
                      Aff.BirthDate, GETDATE()) / 365 AS Age, ISNULL(Aff.SGSSSAffiliationDate, '') AS SGSSSAffiliationDate, ISNULL(Aff.IdentificationTypeId, '00000000-0000-0000-0000-000000000000') 
                      AS IdentificationTypeAff, ISNULL(TypeAff.Code, '') AS IdentificationCodeAff, ISNULL(TypeAff.Name, '') AS IdentificationNameAff, ISNULL(Aff.GenderId, '00000000-0000-0000-0000-000000000000') 
                      AS GenderId, ISNULL(Gen.Code, '') AS GenderCode, ISNULL(Gen.Name, '') AS GenderName, ISNULL(Reg.RegimeId, '00000000-0000-0000-0000-000000000000') AS RegimeId, ISNULL(Reg.Code, '') 
                      AS RegimeCode, ISNULL(Reg.Name, '') AS RegimeName, ISNULL(Node.NodeId, '00000000-0000-0000-0000-000000000000') AS NodeIdAff, ISNULL(Node.Code, '') AS NodeCodeAff, 
                      ISNULL(Node.Name, '') AS NodeNameAff, ISNULL(CONVERT(nvarchar(36), Aff.CityId), '') AS CityIdAff, ISNULL(CTAff.Code, '') AS CityCodeAff, ISNULL(CTAff.Name, '') AS CityNameAff, 
                      ISNULL(CONVERT(nvarchar(36), Zaff.ZonalId), '') AS ZonalIdAff, ISNULL(Zaff.Code, '') AS ZonalCodeAff, ISNULL(Zaff.Name, '') AS ZonalNameAff, ISNULL(Aff.CellPhone, '') AS CellPhone, 
                      ISNULL(Aff.ResidenceAddress, '') AS ResidenceAddress, ISNULL(Aff.Email, '') AS Email, ISNULL(Aff.AffiliateConsecutive, '') AS AffiliateConsecutive, ISNULL(Aff.IpsId, 
                      '00000000-0000-0000-0000-000000000000') AS AffIpsId, ISNULL(Aff.Fosyga, '') AS Fosyga, Aff.IdentificationDate, Aff.ResidencePhone
FROM         affiliation.Affiliates AS Aff INNER JOIN
                      interface.Cities AS CTAff ON Aff.CityId = CTAff.CityId LEFT OUTER JOIN
                      interface.Zonal AS Zaff ON Aff.ZonalId = Zaff.ZonalId INNER JOIN
                      referential.Genders AS Gen ON Aff.GenderId = Gen.GenderId INNER JOIN
                      referential.IdentificationTypes AS TypeAff WITH (NOLOCK) ON Aff.IdentificationTypeId = TypeAff.IdentificationTypeId INNER JOIN
                      referential.Regimes AS Reg WITH (NOLOCK) ON Aff.RegimeId = Reg.RegimeId INNER JOIN
                      referential.Nodes AS Node ON Aff.NodeId = Node.NodeId

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[38] 4[18] 2[25] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[25] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Aff"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 126
               Right = 282
            End
            DisplayFlags = 280
            TopColumn = 118
         End
         Begin Table = "CTAff"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 246
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Zaff"
            Begin Extent = 
               Top = 126
               Left = 236
               Bottom = 246
               Right = 434
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Gen"
            Begin Extent = 
               Top = 246
               Left = 38
               Bottom = 366
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TypeAff"
            Begin Extent = 
               Top = 246
               Left = 236
               Bottom = 366
               Right = 449
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Reg"
            Begin Extent = 
               Top = 366
               Left = 38
               Bottom = 486
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Node"
            Begin Extent = 
               Top = 366
               Left = 236
               Bottom = 486
               Right = 396
            End
            DisplayFlags = 280
            TopCo' , @level0type=N'SCHEMA',@level0name=N'auditory', @level1type=N'VIEW',@level1name=N'ViewAffiliateById'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'lumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'auditory', @level1type=N'VIEW',@level1name=N'ViewAffiliateById'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'auditory', @level1type=N'VIEW',@level1name=N'ViewAffiliateById'
GO


