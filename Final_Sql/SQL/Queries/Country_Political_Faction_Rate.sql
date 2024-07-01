SELECT DISTINCT Candidate.Political_Faction AS [Political Faction], Sum(Candidate.F_Votes_no + Candidate.S_votes_no) as Total
FROM Candidate
WHERE Candidate.Political_Faction in ('I','A','O','E')
GROUP BY Candidate.Political_Faction
ORDER BY total DESC