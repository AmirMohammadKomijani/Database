SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Description:	To set the BIT value of Has_F_RD_Vote and Has_S_RD_Vote of Voter instance,
--				to whom this instance of vote belongs to.
-- =============================================
CREATE TRIGGER trg_UpdateRDVote_OnVoteInsert
   ON  Vote
   AFTER INSERT
AS 
BEGIN

	SET NOCOUNT ON;

	UPDATE Voter
	SET Has_F_RD_Vote = (CASE WHEN I.is_First_RD = 1 THEN 1 ELSE V.Has_F_RD_Vote END), Has_S_RD_Vote = (CASE WHEN I.is_Second_RD = 1 THEN 1 ELSE V.Has_S_RD_Vote END)
	FROM inserted AS I
			JOIN Voter AS V ON V.ID = I.Voter_ID

END
GO
