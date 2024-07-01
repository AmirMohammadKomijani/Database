SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ===================================================
-- Description:	This trigger checks if the newly added 
--				candidate doesn't have the same SSN as
--				the instances in the deleted_candidate
--				table.
-- ===================================================
CREATE OR ALTER TRIGGER trg_CheckCandidateSSN_OnCandidateInsert
   ON  Candidate
   INSTEAD OF INSERT
AS 
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		DECLARE @SSN CHAR(10);

		SELECT @SSN = I.SSN
		FROM inserted AS I;

		IF (EXISTS (SELECT QC.SSN
					FROM Quitted_Candidate AS QC
					WHERE QC.SSN = @SSN))
			RAISERROR('This candidate can not be added beacause a canidate with same ssn is quitted.', 1, 1);
		ELSE
			
		INSERT INTO Candidate (CO_ID, First_Name, Last_Name, is_Married, Political_Faction, Nationality, Birth_Date, Religion, Resume_Desc, Sex, SSN)
		SELECT CO_ID, First_Name, Last_Name, is_Married, Political_Faction, Nationality, Birth_Date, Religion, Resume_Desc, Sex, SSN FROM inserted;
	END TRY
	BEGIN CATCH
		SELECT   
			ERROR_NUMBER() AS ErrorNumber  
			,ERROR_SEVERITY() AS ErrorSeverity  
			,ERROR_STATE() AS ErrorState  
			,ERROR_PROCEDURE() AS ErrorProcedure  
			,ERROR_LINE() AS ErrorLine  
			,ERROR_MESSAGE() AS ErrorMessage; 
	END CATCH
END
GO