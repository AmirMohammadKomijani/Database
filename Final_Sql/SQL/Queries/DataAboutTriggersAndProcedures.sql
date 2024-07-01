-- All Triggers With 'Add' In Their Names 

SELECT name
FROM Sys.objects
	WHERE TYPE = 'TR' AND name LIKE '%ADD%'

--Count Of All Procedures Modified In Current Week

SELECT *
FROM Sys.objects
	WHERE TYPE = 'P'
	AND modify_date >= dateadd(day, 1-datepart(dw, getdate()), CONVERT(date,getdate())) 
	AND modify_date <  dateadd(day, 8-datepart(dw, getdate()), CONVERT(date,getdate()))