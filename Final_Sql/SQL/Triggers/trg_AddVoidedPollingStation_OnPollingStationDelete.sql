SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Description:	Inserting values inside VoidedPollingStation after deleting it from PollingStation table
-- =============================================
CREATE OR ALTER TRIGGER trg_AddVoidedPollingStation_OnPollingStationDelete
   ON Polling_Station
   AFTER DELETE
AS 
BEGIN
	SET NOCOUNT ON;

    INSERT INTO Voided_PollingStation
	SELECT *
	FROM Deleted
END
GO
