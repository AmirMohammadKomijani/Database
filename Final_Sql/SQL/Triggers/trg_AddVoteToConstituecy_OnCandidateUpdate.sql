SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Description:	when f_votes_no or s_votes_no of 
--				candidate is updated, the same 
--				columns of constituency will be
--				increased too.
-- =============================================
CREATE OR ALTER TRIGGER trg_AddVoteToConstituecy_OnCandidateUpdate
   ON Candidate
   AFTER Update
AS 
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		DECLARE @id INT
		SELECT TOP 1 @id = CO.ID
		FROM Constituency AS CO
			 JOIN inserted AS I ON I.CO_ID = CO.ID;

		IF (UPDATE(F_votes_no))
			BEGIN
				UPDATE Constituency
				SET F_Votes_no = ISNULL(F_Votes_no, 0) + 1
				WHERE Constituency.ID = @id
			END
		ELSE IF (UPDATE(S_votes_no))
			BEGIN
				UPDATE Constituency
				SET S_Votes_no = ISNULL(S_Votes_no, 0) + 1
				WHERE Constituency.ID = @id
			END
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
