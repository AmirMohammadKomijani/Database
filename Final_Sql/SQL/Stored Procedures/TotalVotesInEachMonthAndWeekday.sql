-- Total Votes In Each Month (Sorted By Months)
SELECT FORMAT(VoteDate, 'MMMM') AS [Month], COUNT(ID) AS [Count]
FROM Vote 
	GROUP BY MONTH(VoteDate), FORMAT(VoteDate, 'MMMM')
	ORDER BY MONTH(VoteDate)

-- Total Votes In Each Weekday (Sorted By Count)
SELECT DATENAME(DW,VoteDate) AS [Weekday], COUNT(ID) AS [Count]
FROM Vote 
	GROUP BY DATENAME(DW,VoteDate)
	ORDER BY COUNT(ID) DESC