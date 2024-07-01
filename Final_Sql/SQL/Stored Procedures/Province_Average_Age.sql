CREATE PROC Province_AvgAge @province INT
AS
SELECT Province.ID AS Province_ID, AVG(Voter.Age) AS averageAge
FROM Voter
	 JOIN Vote ON Voter.ID = Vote.Voter_ID
	 JOIN Polling_Station ON Vote.PS_ID = Polling_Station.ID
	 JOIN Constituency ON Polling_Station.C_ID = Constituency.ID
	 JOIN Province ON Constituency.P_ID = Province.ID
WHERE Province.ID = @province
GROUP BY Province.ID
GO


EXEC Province_AvgAge @province = 6
EXEC Province_AvgAge @province = 7
EXEC Province_AvgAge @province = 2
EXEC Province_AvgAge @province = 9