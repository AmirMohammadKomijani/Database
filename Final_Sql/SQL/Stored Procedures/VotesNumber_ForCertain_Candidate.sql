CREATE OR ALTER PROCEDURE VotesNumber_Certain_Candidate @Id INT
AS

SELECT Candidate.ID,Candidate.First_Name + ' ' + Candidate.Last_Name AS fullName,Candidate.F_Votes_no,Candidate.S_votes_no
FROM Candidate
WHERE Candidate.ID = @Id
GO

EXEC VotesNumber_Certain_Candidate @Id = 15;
EXEC VotesNumber_Certain_Candidate @Id = 8;