SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Description:	Inserting values inside QuittedCandidate after deleting it from Candidate table
-- =============================================
CREATE OR ALTER TRIGGER trg_AddQuittedCandidate_OnCandidateDelete
   ON Candidate
   AFTER DELETE
AS 
BEGIN
	SET NOCOUNT ON;

    INSERT INTO Quitted_Candidate
	SELECT *
	FROM Deleted
END
GO
