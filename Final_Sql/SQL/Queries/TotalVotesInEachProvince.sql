--Total Votes Ranking In Each Province

SELECT Province_Name, SUM(F_Votes_no + S_Votes_no) AS [Votes]
FROM Province
	GROUP BY Province_Name
	ORDER BY SUM(F_Votes_no + S_Votes_no) DESC