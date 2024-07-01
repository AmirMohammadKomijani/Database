USE [Parliament]
GO
/****** Object:  UserDefinedFunction [dbo].[AverageVoterAge]    Script Date: 7/3/2022 1:17:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[AverageVoterAge] (@ID INT)
RETURNS INT
AS
BEGIN
	DECLARE @res INT;

	SET @res = 
	(
	SELECT AVG(Vo.age)
	FROM Voter AS VO
		INNER JOIN
		Vote AS V 
		ON VO.ID = V.Voter_ID 
		INNER JOIN 
		Candidate_List AS CL
		ON 	V.ID = CL.Vote_ID
		WHERE CL.Candidate_ID = @ID
	)
	RETURN @res 
END

