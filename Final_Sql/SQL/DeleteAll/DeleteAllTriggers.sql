USE Parlimant
GO

IF OBJECT_ID('trg_OnVoteInsert') IS NOT NULL
	DROP TRIGGER dbo.trg_OnVoteInsert;
GO
IF OBJECT_ID('trg_OnCandidateListInsert') IS NOT NULL
	DROP TRIGGER dbo.trg_OnCandidateListInsert;
GO
IF OBJECT_ID('trg_PreventTransactions_OnVoidedPollingStation') IS NOT NULL
	DROP TRIGGER dbo.trg_PreventTransactions_OnVoidedPollingStation;
GO
IF OBJECT_ID('trg_PreventTransactions_OnQuittedCandidate') IS NOT NULL
	DROP TRIGGER dbo.trg_PreventTransactions_OnQuittedCandidate;
GO
IF OBJECT_ID('trg_CheckCandidateSSN_OnCandidateInsert') IS NOT NULL
	DROP TRIGGER dbo.trg_CheckCandidateSSN_OnCandidateInsert;
GO
IF OBJECT_ID('trg_ReduceVotes_OnPollingStationDelete') IS NOT NULL
	DROP TRIGGER dbo.trg_ReduceVotes_OnPollingStationDelete;
GO
IF OBJECT_ID('trg_ReduceVotes_OnCandidateDelete') IS NOT NULL
	DROP TRIGGER dbo.trg_ReduceVotes_OnCandidateDelete;
GO
IF OBJECT_ID('trg_AddVoteToProvince_OnConstituencyUpdate') IS NOT NULL
	DROP TRIGGER dbo.trg_AddVoteToProvince_OnConstituencyUpdate;
GO
IF OBJECT_ID('trg_AddVoteToConstituecy_OnCandidateUpdate') IS NOT NULL
	DROP TRIGGER dbo.trg_AddVoteToConstituecy_OnCandidateUpdate;
GO
IF OBJECT_ID('trg_DeleteCandidateList_OnVoteDelete') IS NOT NULL
	DROP TRIGGER dbo.trg_DeleteCandidateList_OnVoteDelete;
GO
IF OBJECT_ID('trg_DeleteCandidateList_OnCandidateDelete') IS NOT NULL
	DROP TRIGGER dbo.trg_DeleteCandidateList_OnCandidateDelete;
GO
IF OBJECT_ID('trg_AddQuittedCandidate_OnCandidateDelete') IS NOT NULL
	DROP TRIGGER dbo.trg_AddQuittedCandidate_OnCandidateDelete;
GO
IF OBJECT_ID('trg_AddVoidedPollingStation_OnPollingStationDelete') IS NOT NULL
	DROP TRIGGER dbo.trg_AddVoidedPollingStation_OnPollingStationDelete;
GO