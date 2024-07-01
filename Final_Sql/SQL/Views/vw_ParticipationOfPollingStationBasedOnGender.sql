-- This view shows percentage of participation of voters of each polling station based on the gender
CREATE OR ALTER VIEW vw_ParticipationOfPollingStationBasedOnGender
AS
SELECT  PS.City, PS.[Address], 
		-- [Men Participation Percentage] start
		CONVERT(decimal(6,2),(( SELECT COUNT(*)
							    FROM Polling_Station AS PS1
									 JOIN Vote AS V1 ON V1.PS_ID = PS1.ID
									 JOIN Voter AS VR1 ON VR1.ID = V1.Voter_ID
								WHERE VR1.Sex = 'M' AND PS1.ID = PS.ID ) * 1.0
									/
									(NULLIF(((SELECT COUNT(*) 
									 FROM Polling_Station AS PS1
									      JOIN Vote AS V1 ON V1.PS_ID = PS1.ID
								     WHERE PS.ID = PS1.ID ) * 1.0), 0)) * 100)) AS [Men Participation Percentage],
		-- [Men Participation Percentage] end
		-- [Women Participation Percentage] start
		CONVERT(decimal(6,2),(( SELECT COUNT(*)
							    FROM Polling_Station AS PS1
									 JOIN Vote AS V1 ON V1.PS_ID = PS1.ID
									 JOIN Voter AS VR1 ON VR1.ID = V1.Voter_ID
								WHERE VR1.Sex = 'F' AND PS1.ID = PS.ID ) * 1.0
									/
									(NULLIF(((SELECT COUNT(*) 
									 FROM Polling_Station AS PS1
									      JOIN Vote AS V1 ON V1.PS_ID = PS1.ID
								     WHERE PS.ID = PS1.ID ) * 1.0), 0)) * 100)) AS [Women Participation Percentage]
		-- [Women Participation Percentage] end
FROM    Polling_Station AS PS 