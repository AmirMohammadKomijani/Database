SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

USE Parlimant
GO
-- ======================================================
-- Description:	when an instance of Candidate is deleted,
--				all instances of CandidateList with same 
--				Canidate_SSN as SSN of Candidate, will be
--				deleted as well.
-- ======================================================
CREATE OR ALTER TRIGGER trg_DeleteCandidateList_OnCandidateDelete
   ON Candidate
   AFTER DELETE
AS 
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		DELETE CL 
		FROM Candidate_List AS CL
		WHERE EXISTS ( SELECT *	
					   FROM deleted
					   WHERE deleted.ID = CL.Candidate_ID );
	END TRY
	BEGIN CATCH
		SELECT   
			ERROR_NUMBER() AS ErrorNumber  
			,ERROR_SEVERITY() AS ErrorSeverity  
			,ERROR_STATE() AS ErrorState  
			,ERROR_PROCEDURE() AS ErrorProcedure  
			,ERROR_LINE() AS ErrorLine  
			,ERROR_MESSAGE() AS ErrorMessage; 
	END CATCH
END
GO
