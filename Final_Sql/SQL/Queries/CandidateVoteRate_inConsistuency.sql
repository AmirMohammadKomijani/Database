SELECT Constituency.ID AS [Constituency ID],
	   Candidate.ID AS [Candidate ID],
	   Candidate.F_Votes_no AS [First Votes Number],
	   Candidate.S_votes_no AS [Second Votes Number],
	   Candidate.F_Votes_no + Candidate.S_votes_no AS Total
FROM Candidate
JOIN Constituency ON Candidate.CO_ID = Constituency.ID
ORDER BY Constituency.ID, Total