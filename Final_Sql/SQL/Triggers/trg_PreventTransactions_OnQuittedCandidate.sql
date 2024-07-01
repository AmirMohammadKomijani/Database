SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Description:	This trigger prevents any operation
--				on the Quitted_Candidate table.
-- ================================================
CREATE OR ALTER TRIGGER trg_PreventTransactions_OnQuittedCandidate
   ON  Quitted_Candidate
   INSTEAD OF DELETE,UPDATE
AS 
BEGIN
	SET NOCOUNT ON;
	RAISERROR('You can not make any transaction on Quitted_Candidate table.', 16, 10);
END
GO
