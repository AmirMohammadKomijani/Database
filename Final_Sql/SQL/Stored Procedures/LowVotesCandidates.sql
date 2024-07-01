USE [Parliament]
GO
/****** Object:  StoredProcedure [dbo].[LowVotesCandidates]    Script Date: 7/1/2022 3:18:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Candidates Who Have Less Votes Than @count
CREATE OR ALTER PROCEDURE [dbo].[LowVotesCandidates]
(
	@count int
)
AS
BEGIN
	SELECT First_Name, Last_Name , F_Votes_no + S_votes_no AS TotalVotes
	FROM Candidate 
		HAVING (F_Votes_no + S_votes_no) < @count
		ORDER BY (F_Votes_no + S_votes_no) DESC
END
