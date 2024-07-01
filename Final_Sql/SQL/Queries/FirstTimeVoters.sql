--First Time Voters

-- In Country
SELECT *
FROM Voter
	WHERE Age < 22

-- In Province
SELECT P.Province_Name AS [Province Name], COUNT(*) AS [Count]
FROM Vote AS V 
	INNER JOIN
	Voter AS VO ON V.ID = VO.ID 
	INNER JOIN 
	Polling_Station AS PS 
	ON PS.ID = V.PS_ID
	INNER JOIN 
	Constituency AS C 
	ON C.ID = PS.ID 
	INNER JOIN 
	Province AS P 
	ON P.ID = C.P_ID
	WHERE VO.Age < 22
	GROUP BY P.Province_Name

-- In Constituency
SELECT C.C_Name AS [Constituency Name] , COUNT(*) AS [Count]
FROM Vote AS V 
	INNER JOIN 
	Voter AS VO
	ON V.ID = VO.ID 
	INNER JOIN 
	Polling_Station AS PS 
	ON PS.ID = V.PS_ID 
	INNER JOIN 
	Constituency AS C 
	ON C.ID = PS.ID
	WHERE VO.Age < 22
	GROUP BY C.C_Name



