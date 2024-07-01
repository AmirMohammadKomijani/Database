USE [Parliament]
GO
/****** Object:  StoredProcedure [dbo].[GetSubTrees]    Script Date: 6/6/2022 11:04:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[VoterInConstituency]
(
	@CO_ID int,
	@Base NVARCHAR(50)
)
AS
BEGIN
	IF ( @Base = 'Gender' )
	BEGIN
		SELECT VO.Sex ,COUNT(*) AS COUNT
		FROM Constituency AS C INNER JOIN Polling_Station AS P ON C.ID = P.C_ID INNER JOIN 
			Vote AS V ON P.ID = V.PS_ID INNER JOIN Voter AS VO ON V.Voter_ID = VO.ID
		WHERE C.ID = @CO_ID
		GROUP BY VO.Sex
	END
	ELSE IF ( @Base = 'Age' )
	BEGIN		
		SELECT  SUM (CASE WHEN VO.Age < 20 THEN 1 ELSE 0 END) AS [Under 20],
				SUM (CASE WHEN VO.Age < 30 THEN 1 ELSE 0 END) AS [Under 30],
				SUM (CASE WHEN VO.Age < 40 THEN 1 ELSE 0 END) AS [Under 40],
				SUM (CASE WHEN VO.Age < 50 THEN 1 ELSE 0 END) AS [Under 50],
				SUM (CASE WHEN VO.Age < 60 THEN 1 ELSE 0 END) AS [Under 60],
				SUM (CASE WHEN VO.Age >= 60 THEN 1 ELSE 0 END) AS [Over 60]
		FROM Constituency AS C INNER JOIN Polling_Station AS P ON C.ID = P.C_ID INNER JOIN 
		Vote AS V ON P.ID = V.PS_ID INNER JOIN Voter AS VO ON V.Voter_ID = VO.ID
		WHERE C.ID = @CO_ID
	END
END






