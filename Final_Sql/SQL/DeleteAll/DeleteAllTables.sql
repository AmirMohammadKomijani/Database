USE Parlimant
GO

IF OBJECT_ID('Candidate_Won_F_RD') IS NOT NULL
	DROP TABLE Candidate_Won_F_RD;
GO
IF OBJECT_ID('Candidate_List') IS NOT NULL
	DROP TABLE Candidate_List;
GO
IF OBJECT_ID('Vote') IS NOT NULL
	DROP TABLE Vote;
GO
IF OBJECT_ID('Voter') IS NOT NULL
	DROP TABLE Voter;
Go
IF OBJECT_ID('Degree') IS NOT NULL
	DROP TABLE Degree;
GO
IF OBJECT_ID('Candidate') IS NOT NULL
	DROP TABLE Candidate;
GO
IF OBJECT_ID('Candidate_Won_F_RD') IS NOT NULL
	DROP TABLE Candidate_Won_F_RD;
GO
IF OBJECT_ID('Polling_Station') IS NOT NULL
	DROP TABLE Polling_Station;
GO
IF OBJECT_ID('Constituency') IS NOT NULL
	DROP TABLE Constituency;
GO
IF OBJECT_ID('Province') IS NOT NULL
	DROP TABLE Province;
GO
IF OBJECT_ID('Quitted_Candidate') IS NOT NULL
	DROP TABLE Quitted_Candidate;
GO
IF OBJECT_ID('Voided_PollingStation') IS NOT NULL
	DROP TABLE Voided_PollingStation;
GO