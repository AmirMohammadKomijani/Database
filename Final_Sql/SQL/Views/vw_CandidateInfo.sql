CREATE OR ALTER VIEW vw_CandidateInfo
AS
SELECT CA.First_Name AS [First Name], CA.Last_Name AS [Last Name], P.Province_Name AS [Province Name],
	   CO.C_Name AS Constitueny, CA.Birth_Date AS [Birth Date], DATEDIFF(YY, CA.Birth_Date, GETDATE()) AS Age, 
	   ISNULL(CA.ProfileImage, 'No Image') AS [Profile Image], CA.Sex, CA.Religion, CA.is_Married AS [is Married], 
	   CA.Nationality, CA.Resume_Desc AS [Resume Description], 
	   (Select ISNULL(SUBSTRING((SELECT  ',' + D.Degree_Name AS [text()] 
		FROM    Degree AS D
		WHERE   CA.ID = D.Candidate_ID
		FOR XML PATH ('')), 2, 10000000),'No Degree')) AS [Degrees]
FROM Candidate AS CA
     JOIN Constituency AS CO ON CA.CO_ID = CO.ID
	 JOIN Province AS P ON P.ID = CO.P_ID