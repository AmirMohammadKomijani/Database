--Participation Ranking In Each Province 

SELECT ROUND (CAST (SUM (F_Votes_no + S_Votes_no) AS FLOAT) / Voter_Population * 100, 4) AS [Participation(%)]
FROM Province
	GROUP BY Province_Name , Voter_Population
	ORDER BY CAST (SUM (F_Votes_no + S_Votes_no) AS FLOAT) / Voter_Population DESC
