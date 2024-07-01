-- 10 candidates with least recieved votes in the top 10 constituencies
-- based on the votes

SELECT TOP 10 (CA.First_Name + ' ' + CA.Last_Name) AS [Full name],
			   CA.F_Votes_no + CA.S_votes_no AS [Total Votes], 
			   CA.F_Votes_no AS [First Round Votes#], 
			   CA.S_votes_no AS [Second Round Votes#],
			   DATEDIFF(YY, CA.Birth_Date, GETDATE()) AS Age,
			   CA.Sex AS Gender,
			   CA.Political_Faction AS [Political Faction]
FROM ( SELECT TOP 10 CO.ID
	   FROM Constituency AS CO
	   ORDER BY CO.F_Votes_no + CO.S_Votes_no DESC ) AS T
	  JOIN Candidate AS CA ON CA.CO_ID = T.ID
ORDER BY CA.F_Votes_no + CA.S_votes_no, CA.F_Votes_no
