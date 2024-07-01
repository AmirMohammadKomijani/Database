SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER TRIGGER trg_AddVotetoPSandCA_OnCandidateListInsert
   ON  Candidate_List
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;
   
	-- ===================================================================================================================================================================

	-- Description:	when a vote is inserted one vote will be added to polling station.
	--				if the vote is for the first round, F_Votes_no will be increased.
	--				otherwise S_Votes_no will be increased.

	DECLARE @ps_id INT;
	SELECT TOP 1 @ps_id = P.ID
	FROM inserted AS I
			JOIN Vote AS V ON V.ID = I.Vote_ID
			JOIN Polling_Station AS P ON P.ID = V.PS_ID

	IF (SELECT TOP 1 V.is_First_RD FROM inserted AS I JOIN Vote AS V ON V.ID = I.Vote_ID) = 1
		UPDATE Polling_Station
		SET F_Votes_no = ISNULL(F_Votes_no, 0) + 1
		WHERE Polling_Station.ID = @ps_id
	ELSE
		UPDATE Polling_Station
		SET S_Votes_no = ISNULL(S_Votes_no, 0) + 1
		WHERE Polling_Station.ID = @ps_id

	-- ===================================================================================================================================================================

	-- Description:	when a candidate is observed in the candidate_List instance,
	--				one vote will be added to the candidate. if the vote is for
	--				for the first round, F_Votes_no will be increased. otherwise
	--				S_Votes_no will be increased.

	DECLARE @ca_id INT;
	SELECT TOP 1 @ca_id = C.ID
	FROM Candidate AS C
			JOIN inserted AS I ON C.ID = I.Candidate_ID;

	IF (SELECT TOP 1 V.is_First_RD FROM inserted AS I JOIN Vote AS V ON V.ID = I.Vote_ID) = 1
		UPDATE Candidate
		SET F_Votes_no = ISNULL(F_Votes_no, 0) + 1
		WHERE Candidate.ID = @ca_id
	ELSE
		UPDATE Candidate
		SET S_Votes_no = ISNULL(S_Votes_no, 0) + 1
		WHERE Candidate.ID = @ca_id

END
GO
