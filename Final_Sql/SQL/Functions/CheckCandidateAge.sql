SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION CheckCandidateAge (@Birth_Date DATETIME2(0))
RETURNS INT
AS
BEGIN
	DECLARE @res INT,
			@age INT;

	SET @age = DATEDIFF(YY, @Birth_Date, GETDATE());
	IF @age >= 30 AND @age <= 70
		SET @res = 1
	ELSE 
		SET @res = 0

	RETURN @res
END
GO

