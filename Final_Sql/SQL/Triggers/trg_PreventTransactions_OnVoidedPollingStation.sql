SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Description:	This trigger prevents any operation
--				on the Voided_PollingStation table.
-- ================================================
CREATE OR ALTER TRIGGER trg_PreventTransactions_OnVoidedPollingStation
   ON  Voided_PollingStation
   INSTEAD OF DELETE, UPDATE
AS 
BEGIN
	SET NOCOUNT ON;
	RAISERROR('You can not make any transaction on Voided_PollingStation table.', 16, 10);
END
GO
