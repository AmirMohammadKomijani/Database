CREATE PROCEDURE Political_Faction_Rate_InProvince @province INT
AS
SELECT Province.ID AS province_ID,Province.Province_Name,Candidate.Political_Faction, SUM(Candidate.F_Votes_no + Candidate.S_votes_no) AS total
FROM Candidate
JOIN Constituency ON Candidate.CO_ID = Constituency.ID
JOIN Province ON Constituency.P_ID = Province.ID
WHERE Province.ID = @province
GROUP BY Candidate.Political_Faction,Province.ID,Province.Province_Name
ORDER BY total DESC
GO

EXEC Political_Faction_Rate_InProvince @province = 2
EXEC Political_Faction_Rate_InProvince @province = 9
EXEC Political_Faction_Rate_InProvince @province = 6
EXEC Political_Faction_Rate_InProvince @province = 3

GO



Create procedure Political_Faction_Rate_InConstituency @Consistuency INT
AS
SELECT Constituency.ID AS Constituency_ID,Constituency.C_Name,Candidate.Political_Faction, SUM(Candidate.F_Votes_no + Candidate.S_votes_no) AS total
FROM Candidate
JOIN Constituency ON Candidate.CO_ID = Constituency.ID
WHERE Constituency.ID = @Consistuency
GROUP BY Candidate.Political_Faction,Constituency.ID,Constituency.C_Name
ORDER BY total DESC
GO

EXEC Political_Faction_Rate_InConstituency @Consistuency = 2
EXEC Political_Faction_Rate_InConstituency @Consistuency = 9
EXEC Political_Faction_Rate_InConstituency @Consistuency = 6
EXEC Political_Faction_Rate_InConstituency @Consistuency = 3