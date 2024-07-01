--Political Faction Ranking In Each Province

SELECT Co.C_Name AS [Constituency Name], (CASE WHEN C.Political_Faction = 'E' THEN 'Eslah Talab'
		   WHEN C.Political_Faction = 'O' THEN 'Osoul Gara' 
		   WHEN C.Political_Faction = 'A' THEN 'Aghaliat Dini'
		   WHEN C.Political_Faction = 'I' THEN 'Indepenant' END) AS [Political Faction],
		   COUNT(C.Political_Faction) AS [Count]
FROM Candidate_List AS CL
	INNER JOIN 
	Candidate AS C
	ON C.ID = CL.Candidate_ID
	INNER JOIN 
	Constituency AS Co
	ON Co.ID = C.CO_ID
	INNER JOIN 
	Province AS P
	ON Co.P_ID = P.ID
	GROUP BY C.Political_Faction, C_Name
	ORDER BY COUNT(C.Political_Faction) DESC
