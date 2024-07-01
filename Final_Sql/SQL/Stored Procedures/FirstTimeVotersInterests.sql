-- Count Of FirstTime @Political_Faction Voters in Desired @Province
USE [Parliament]
GO
/****** Object:  StoredProcedure [dbo].[ProvinceRankings]    Script Date: 7/1/2022 3:33:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROC [dbo].[FirstTimeVotersInterest]
    @P INT,
	@PF NCHAR(1)
AS

BEGIN
	
	SELECT Vo.ID, Vo.Age, C.First_Name, C.Last_Name, C.Political_Faction, P.ID, P.Province_Name
	FROM Voter AS Vo
		 INNER JOIN VOTE AS V ON V.Voter_ID = Vo.ID
		 INNER JOIN Candidate_List AS CL ON CL.Vote_ID = V.ID
		 INNER JOIN Candidate AS C ON C.ID = CL.Candidate_ID
		 INNER JOIN Constituency AS Co ON Co.ID = C.CO_ID
		 INNER JOIN Province AS P ON Co.P_ID = P.ID
	WHERE Vo.Age < 22 AND P.ID = @P AND C.Political_Faction = @PF
END

EXEC FirstTimeVotersInterest
@P = 2, @PF = 'A'