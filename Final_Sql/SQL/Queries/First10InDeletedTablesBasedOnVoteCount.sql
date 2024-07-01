-- Order first 10 candidates who have quitted, based on the total votes recieved.
SELECT TOP 10 CO.C_Name AS [Constituency Name], (QC.First_Name + ' ' + QC.Last_Name) AS [Full Name],
				  (CASE WHEN QC.Political_Faction = 'E' THEN 'Eslah Talab'
				   WHEN QC.Political_Faction = 'O' THEN 'Osoul Gara' 
				   WHEN QC.Political_Faction = 'A' THEN 'Aghaliat Dini'
				   WHEN QC.Political_Faction = 'I' THEN 'Indepenant' END) AS [Political Faction]
				   , (QC.F_Votes_no + QC.S_votes_no) AS [Total Votes], QC.Sex AS Gender
FROM Quitted_Candidate AS QC
	 JOIN Constituency AS CO ON CO.ID = QC.CO_ID
ORDER BY QC.F_Votes_no + QC.S_votes_no DESC

-- Order first 10 Polling stations that are voided, based on the total votes submitted.
SELECT TOP 10 CO.C_Name AS [Constituency Name], VP.City, VP.[Address], (VP.F_Votes_no + VP.S_Votes_no) AS [Total Votes]
FROM Voided_PollingStation AS VP
	 JOIN Constituency AS CO ON CO.ID = VP.CO_ID
ORDER BY VP.F_Votes_no + VP.S_Votes_no DESC