SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Description:	Reduces votes when there is a delete
--				on the candidate.
-- =============================================
CREATE OR ALTER TRIGGER trg_ReduceVotes_OnCandidateDelete
   ON Candidate
   AFTER DELETE
AS 
BEGIN
	SET NOCOUNT ON

	BEGIN TRY
		-- finding count of votes inserted in first round or second round
		DECLARE @fVotesNo INT,
				@sVotesNo INT;

		SELECT @fVotesNo = D.F_Votes_no
		FROM deleted as D

		SELECT @sVotesNo = D.S_Votes_no
		FROM deleted AS D

		-- Finding id of candidate, constituency and province of the candidate
		DECLARE @CA_ID INT,
				@CO_ID INT,
				@P_ID INT

		SELECT TOP 1 @CA_ID = D.ID, @CO_ID = CO.ID, @P_ID = CO.P_ID
		FROM deleted AS D 
			 JOIN Constituency AS CO ON CO.ID = D.CO_ID

		-- finding number of votes for first round and second round for province
		DECLARE @p_f_votes INT,
				@p_s_votes INT
		SELECT TOP 1 @p_f_votes = P.F_Votes_no - @fVotesNo, @p_s_votes = P.S_Votes_no - @sVotesNo
		FROM Province AS P
		WHERE P.ID = @P_ID

		-- reducing number of votes from constituency and province
		UPDATE Constituency
		SET F_Votes_no = F_Votes_no - @fVotesNo, S_Votes_no = S_Votes_no - @sVotesNo
		WHERE ID = @CO_ID

		UPDATE Province
		SET F_Votes_no = @p_f_votes, S_Votes_no = @p_s_votes
		WHERE ID = @P_ID

		-- deleting degrees of the deleted candidate
		DELETE
		FROM Degree
		WHERE Candidate_ID = @CA_ID

		-- reducing number of votes from the polling stations.
		DECLARE @PS_table TABLE (ID INT, f_vote BIT, totalCount INT)

		INSERT INTO @PS_table
		SELECT V.PS_ID AS ID, V.is_First_RD AS f_vote, COUNT(*) AS totalCount
		FROM Candidate_List AS CL
			 JOIN Vote AS V ON V.ID = CL.Vote_ID
		WHERE CL.Candidate_ID = @CA_ID
		GROUP BY V.PS_ID, V.is_First_RD

		Update Polling_Station
		SET F_Votes_no = F_Votes_no - (CASE WHEN PS1.f_vote = 1 THEN PS1.totalCount ELSE 0 END), S_Votes_no = S_Votes_no - (CASE WHEN PS1.f_vote = 0 THEN PS1.totalCount ELSE 0 END)
		FROM Polling_Station AS PS
			 JOIN @PS_table AS PS1 ON PS1.ID = PS.ID
	END TRY
	BEGIN CATCH
		SELECT   
			ERROR_NUMBER() AS ErrorNumber  
			,ERROR_SEVERITY() AS ErrorSeverity  
			,ERROR_STATE() AS ErrorState  
			,ERROR_PROCEDURE() AS ErrorProcedure  
			,ERROR_LINE() AS ErrorLine  
			,ERROR_MESSAGE() AS ErrorMessage;

		IF (@@TRANCOUNT > 0)
			ROLLBACK TRAN
	END CATCH
END
GO