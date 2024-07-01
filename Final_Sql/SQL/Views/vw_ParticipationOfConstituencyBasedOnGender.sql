-- This view shows percentage of participation of voters of each polling station based on the gender
CREATE OR ALTER VIEW vw_ParticipationOfConstituencyBasedOnGender
AS
SELECT  CO.C_Name AS [Constituency Name], CO.Center, CO.Elected_no AS [Number of Members of Parliament],
		-- [Men Participation Percentage] start
		CONVERT(decimal(6,2),(( SELECT COUNT(*)
							    FROM Constituency AS CO1
									 JOIN Polling_Station AS PS1 ON PS1.C_ID = CO1.ID
									 JOIN Vote AS V1 ON V1.PS_ID = PS1.ID
									 JOIN Voter AS VR1 ON VR1.ID = V1.Voter_ID
								WHERE VR1.Sex = 'M' AND CO1.ID = CO.ID ) * 1.0)
									/
									(NULLIF(((SELECT COUNT(*) 
									 FROM Constituency AS CO1
										  JOIN Polling_Station AS PS1 ON PS1.C_ID = CO1.ID
									      JOIN Vote AS V1 ON V1.PS_ID = PS1.ID
								     WHERE CO.ID = CO1.ID ) * 1.0), 0)) * 100) AS [Men Participation Percentage],
		-- [Men Participation Percentage] end
		-- [Women Participation Percentage] start
		CONVERT(decimal(6,2),(( SELECT COUNT(*)
							    FROM Constituency AS CO1
									 JOIN Polling_Station AS PS1 ON PS1.C_ID = CO1.ID
									 JOIN Vote AS V1 ON V1.PS_ID = PS1.ID
									 JOIN Voter AS VR1 ON VR1.ID = V1.Voter_ID
								WHERE VR1.Sex = 'F' AND CO1.ID = CO.ID ) * 1.0)
									/
									(NULLIF(((SELECT COUNT(*) 
									 FROM Constituency AS CO1
										  JOIN Polling_Station AS PS1 ON PS1.C_ID = CO1.ID
									      JOIN Vote AS V1 ON V1.PS_ID = PS1.ID
								     WHERE CO.ID = CO1.ID ) * 1.0), 0)) * 100) AS [Women Participation Percentage]
		-- [Women Participation Percentage] end
FROM    Constituency AS CO