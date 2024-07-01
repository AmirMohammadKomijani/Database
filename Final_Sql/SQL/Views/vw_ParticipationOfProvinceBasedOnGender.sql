-- This view shows percentage of participation of voters of each polling station based on the gender
CREATE OR ALTER VIEW vw_ParticipationOfProvinceBasedOnGender
AS
SELECT  P.Province_Name AS [Province Name], P.Voter_Population AS [Voting Eligible Population],
		-- [Men Participation Percentage] start
		CONVERT(decimal(6,2),(( SELECT COUNT(*)
							    FROM Province AS P1
									 JOIN Constituency AS CO1 ON CO1.P_ID = P1.ID
									 JOIN Polling_Station AS PS1 ON PS1.C_ID = CO1.ID
									 JOIN Vote AS V1 ON V1.PS_ID = PS1.ID
									 JOIN Voter AS VR1 ON VR1.ID = V1.Voter_ID
								WHERE VR1.Sex = 'M' AND P1.ID = P.ID ) * 1.0)
									/
									(NULLIF(((SELECT COUNT(*) 
									 FROM Province AS P1
										  JOIN Constituency AS CO1 ON CO1.P_ID = P1.ID
										  JOIN Polling_Station AS PS1 ON PS1.C_ID = CO1.ID
									      JOIN Vote AS V1 ON V1.PS_ID = PS1.ID
								     WHERE P.ID = P1.ID ) * 1.0), 0)) * 100) AS [Men Participation Percentage],
		-- [Men Participation Percentage] end
		-- [Women Participation Percentage] start
		CONVERT(decimal(6,2),(( SELECT COUNT(*)
							    FROM Province AS P1
									 JOIN Constituency AS CO1 ON CO1.P_ID = P1.ID
									 JOIN Polling_Station AS PS1 ON PS1.C_ID = CO1.ID
									 JOIN Vote AS V1 ON V1.PS_ID = PS1.ID
									 JOIN Voter AS VR1 ON VR1.ID = V1.Voter_ID
								WHERE VR1.Sex = 'F' AND P1.ID = P.ID ) * 1.0)
									/
									(NULLIF(((SELECT COUNT(*) 
									 FROM Province AS P1
										  JOIN Constituency AS CO1 ON CO1.P_ID = P1.ID
										  JOIN Polling_Station AS PS1 ON PS1.C_ID = CO1.ID
									      JOIN Vote AS V1 ON V1.PS_ID = PS1.ID
								     WHERE P.ID = P1.ID ) * 1.0), 0)) * 100) AS [Women Participation Percentage]
		-- [Women Participation Percentage] end
FROM    Province AS P