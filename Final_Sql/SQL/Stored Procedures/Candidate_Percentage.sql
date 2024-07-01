CREATE PROC Candidate_Percentage @filter INT
AS
BEGIN
	DECLARE @num1 FLOAT 
	set @num1 = 
		( SELECT COUNT(t1.ID)
		  FROM (
				SELECT Candidate.ID, Candidate.F_Votes_no + Candidate.S_votes_no AS total
				FROM Candidate
				WHERE  Candidate.F_Votes_no + Candidate.S_votes_no < @filter ) AS t1)

	--print @num1

	DECLARE @num2 FLOAT
	SET @num2 =
		( SELECT COUNT(t2.ID)
		  FROM (
				SELECT Candidate.ID, Candidate.F_Votes_no + Candidate.S_votes_no AS total
				FROM Candidate ) AS t2)

	--print @num2

	PRINT (@num1 / @num2)*100
END

GO

EXEC Candidate_Percentage @filter = 10
EXEC Candidate_Percentage @filter = 5
EXEC Candidate_Percentage @filter = 48
EXEC Candidate_Percentage @filter = 50
EXEC Candidate_Percentage @filter = 100


