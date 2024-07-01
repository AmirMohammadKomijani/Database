SELECT CAST(COUNT(*) AS FLOAT) / SUM(CAST(Voter_Population AS BIGINT)) AS [Participation(%)]
	FROM Vote, Province