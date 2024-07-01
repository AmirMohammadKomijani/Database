CREATE OR ALTER VIEW vw_PollingStationsOfProvinces
AS
SELECT   P.Province_Name AS [Province Name], Co.C_Name AS [Constituency Name], CO.Center AS [Center], PS.City, PS.[Address]
FROM     Province AS P
		 JOIN Constituency AS CO ON CO.P_ID = P.ID
		 JOIN Polling_Station AS PS ON CO.ID = PS.C_ID