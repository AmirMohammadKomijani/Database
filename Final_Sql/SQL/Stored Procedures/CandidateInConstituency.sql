USE [Parliament]
GO
/****** Object:  StoredProcedure [dbo].[CandidateInConstituency]    Script Date: 6/30/2022 1:48:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[CandidateInConstituency]
(
	@CO_ID INT, --Specify Constituency
	@Base NVARCHAR(50) -- SPecify Filter Type On Candidates
)
AS
BEGIN
	IF (@Base = 'Gender')
	BEGIN
		SELECT Ca.First_Name , Ca.Last_Name , Ca.Sex
		FROM Constituency AS Co 
			INNER JOIN 
			Candidate AS Ca 
			ON Co.ID = Ca.CO_ID
			WHERE Co.ID = @CO_ID
			GROUP BY Ca.Sex, Ca.First_Name, Ca.Last_Name
	END
	ELSE IF (@Base = 'Age')
	BEGIN		
		SELECT Ca.First_Name , Ca.Last_Name , YEAR(GETDATE()) - YEAR(Ca.Birth_Date) AS Age
		FROM Constituency AS Co 
			INNER JOIN 
			Candidate AS Ca 
			ON Co.ID = Ca.CO_ID
			WHERE Co.ID = @CO_ID
			GROUP BY Ca.Birth_Date, Ca.First_Name, Ca.Last_Name
	END
	ELSE IF (@Base = 'Degree')
	BEGIN
		SELECT Ca.First_Name , Ca.Last_Name , D.Degree_Name
		FROM Constituency AS Co
			INNER JOIN
			Candidate AS Ca 
			ON Co.ID = Ca.CO_ID 
			INNER JOIN 
			Degree AS D
			ON D.Candidate_ID = Ca.ID
			WHERE Co.ID = @CO_ID
			GROUP BY Ca.First_Name, Ca.Last_Name , D.Degree_Name
	END
END

EXEC CandidateInConstituency @CO_ID = 1, @Base = 'Gender'