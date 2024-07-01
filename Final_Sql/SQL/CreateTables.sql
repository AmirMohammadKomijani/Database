--CREATE DATABASE Parlimant
--GO

USE Parlimant
GO

-- F_Votes_no and S_votes_no, should be evalued using trigger on Constituency table.
-- add constraint to check voter_population to be more than 100000 --> done
CREATE TABLE Province
(
	ID						INT						PRIMARY KEY			IDENTITY(1,1),
	Province_Name			VARCHAR(50)				NOT NULL			UNIQUE,
	Voter_Population		INT						NOT NULL,
	F_Votes_no				INT						DEFAULT(0),
	S_Votes_no				INT						DEFAULT(0)
);
Go

ALTER TABLE Province
	ADD CONSTRAINT ckProvincePopulation CHECK (Voter_Population >= 100000);
GO

-- F_Votes_no and S_votes_no, should be evalued using trigger on Polling_station table.
CREATE TABLE Constituency
(
	ID						INT						PRIMARY KEY			IDENTITY(1,1),
	C_Name					VARCHAR(50)				NOT NULL			UNIQUE,
	P_ID					INT						NOT NULL,
	Center					VARCHAR(50)				NOT NULL,
	F_Votes_no				INT						DEFAULT(0),
	S_Votes_no				INT						DEFAULT(0),
	Elected_no				INT						NOT NULL,
	FOREIGN KEY (P_ID) REFERENCES Province(ID)
		ON DELETE CASCADE
);
GO

-- F_Votes_no and S_votes_no, should be evalued using trigger on Vote table.
CREATE TABLE Polling_Station
(
	ID						INT						PRIMARY KEY			IDENTITY(1,1),
	C_ID					INT						NOT NULL,
	City					VARCHAR(50)				NOT NULL,
	[Address]				VARCHAR(250)			NOT NULL,
	F_Votes_no				INT						DEFAULT(0),
	S_Votes_no				INT						DEFAULT(0),
	UNIQUE (City, [Address]),
	FOREIGN KEY (C_ID) REFERENCES Constituency(ID)
		ON DELETE CASCADE
);
GO

-- religion --> check to be chosen among a number of verified religions(Islam, Christianity, Judaism, Zoroastrianism) --> done
-- sex --> check to be chosen from M and F --> done
-- political_fiction --> check not to have the invalid data (Eslah Talab, Osoul Gara, Aghaliat Dini, Independent). --> done

-- changes:
-- religion --> make it char(1) --> done
-- religion --> check to be chosen among a number of verified religions(I, C, J, Z) --> done
-- political_fiction --> make it char(1) --> done
-- political_fiction --> change chec constraint to just have data in (E, O, A, I) --> done

CREATE TABLE Candidate
(
	ID						INT						PRIMARY KEY			IDENTITY(1,1),
	SSN						CHAR(10)				NOT NULL			UNIQUE,
	CO_ID					INT						NOT NULL,
	First_Name				VARCHAR(50)				NOT NULL,
	Last_Name				VARCHAR(50)				NOT NULL,
	Birth_Date				DATETIME2(0)			NOT NULL,
	ProfileImage			VARCHAR(max),
	Sex						CHAR(1)					NOT NULL, 
	Religion				VARCHAR(50)				NOT NULL,
	is_Married				BIT						NOT NULL,
	Nationality				VARCHAR(50)				NOT NULL,
	F_Votes_no				INT						DEFAULT(0),
	S_votes_no				INT						DEFAULT(0),
	Political_Faction		VARCHAR(50)				NOT NULL,
	Resume_Desc				VARCHAR(max)			NOT NULL,
	FOREIGN KEY (CO_ID) REFERENCES Constituency (ID)
		ON DELETE CASCADE,
	CONSTRAINT ck_CandidateSex CHECK (SEX IN ('M', 'F')),
	CONSTRAINT ck_CandidateSSN CHECK (ISNUMERIC(SSN) = 1),
	CONSTRAINT ck_CandidateReligion CHECK (Religion IN ('Islam', 'Christianity', 'Judaism', 'Zoroastrianism')),
	CONSTRAINT ck_CandidatePF CHECK (Political_Faction IN ('Eslah Talab', 'Osoul Gara', 'Aghaliat Dini', 'Independent'))
);
GO

ALTER TABLE Candidate
	DROP CONSTRAINT ck_CandidateReligion;
ALTER TABLE Candidate
	ALTER COLUMN Religion CHAR(1) NOT NULL;
ALTER TABLE Candidate
	ADD CONSTRAINT ck_CandidateReligion CHECK (Religion IN ('I', 'C', 'J', 'Z'));
Go

ALTER TABLE Candidate
	DROP CONSTRAINT ck_CandidatePF;
ALTER TABLE Candidate
	ALTER COLUMN Political_Faction CHAR(1) NOT NULL;
ALTER TABLE Candidate
	ADD CONSTRAINT ck_CandidatePF CHECK (Political_Faction IN ('E', 'O', 'A', 'I'));
GO

ALTER TABLE Candidate
	ADD CONSTRAINT ck_CandidateAge CHECK (dbo.CheckCandidateAge(Birth_Date) = 1);
--ALTER TABLE Candidate
--	ADD CONSTRAINT ck_CandidateNationality CHECK (Nationality = 'Iran');
--ALTER TABLE Candidate
--	ADD CONSTRAINT ck_CandidatePFSattisfiesReligion CHECK (((Political_Faction IN ('A')) AND (Religion IN ('C', 'J', 'Z'))) OR (Political_Faction IN ('E', 'O', 'I') AND Religion IN ('I')))

CREATE TABLE Candidate_Won_F_RD
(
	ID						INT						PRIMARY KEY
);

-- check sex to be chosen from M and F --> done
CREATE TABLE Voter
(
	ID						INT						PRIMARY KEY			IDENTITY(1,1),
	SSN						CHAR(10)				NOT NULL			UNIQUE,
	Sex						CHAR(1)					NOT NULL, 
	Age						INT						NOT NULL,
	Has_F_RD_Vote			BIT						DEFAULT(0),
	Has_S_RD_Vote			BIT						DEFAULT(0),
	CONSTRAINT ck_VoterSex CHECK (SEX IN ('M', 'F')),
	CONSTRAINT ck_VoterSSN CHECK (ISNUMERIC(SSN) = 1),
	CONSTRAINT ck_VoterAge CHECK (Age >= 18)
);
GO

-- add a check to check only one of is_frist_rd and is_second_rd, are set true. --> done
CREATE TABLE Vote
(
	ID						INT						PRIMARY KEY			IDENTITY(1,1),
	Voter_ID				INT						NOT NULL,
	PS_ID					INT						NOT NULL,
	VoteDate				DATETIME2(0)			NOT NULL,
	is_First_RD				BIT						NOT NULL,
	is_Second_RD			BIT						NOT NULL,
	UNIQUE (Voter_ID, PS_ID), -- check if it is necessary to contain ID or not.
	FOREIGN KEY (Voter_ID) REFERENCES Voter(ID)
		ON DELETE CASCADE,
	FOREIGN KEY (PS_ID) REFERENCES Polling_Station(ID)
		ON DELETE CASCADE,
	CONSTRAINT ck_voteRD CHECK ((is_First_RD = 1 AND is_second_RD = 0) OR (is_First_RD = 0 AND is_Second_RD = 1))
);
GO

ALTER TABLE Vote
	ADD CONSTRAINT ck_DateOfVote CHECK (dbo.isValidDateOfVote(is_First_RD, VoteDate) = 1);
GO


CREATE TABLE Degree
(
	ID						INT						PRIMARY KEY			IDENTITY(1,1),
	Degree_Name				VARCHAR(50)				NOT NULL,
	Candidate_ID			INT						NOT NULL,
	UNIQUE(Degree_Name, Candidate_ID),
	FOREIGN KEY (Candidate_ID) REFERENCES Candidate (ID)
		ON DELETE CASCADE
);
GO

CREATE TABLE Candidate_List
(
	ID						INT						PRIMARY KEY			IDENTITY(1,1),
	Candidate_ID			INT						NOT NULL,
	Vote_ID					INT						NOT NULL,
	UNIQUE (Candidate_ID, Vote_ID)
);
GO

CREATE TABLE Quitted_Candidate
(
	ID						INT						PRIMARY KEY,
	SSN						CHAR(10)				NOT NULL,
	CO_ID					INT						NOT NULL,
	First_Name				VARCHAR(50)				NOT NULL,
	Last_Name				VARCHAR(50)				NOT NULL,
	Birth_Date				DATETIME2(0)			NOT NULL,
	ProfileImage			VARCHAR(max),
	Sex						CHAR(1)					NOT NULL, 
	Religion				VARCHAR(50)				NOT NULL,
	is_Married				BIT						NOT NULL,
	Nationality				VARCHAR(50)				NOT NULL,
	F_Votes_no				INT						DEFAULT(0),
	S_votes_no				INT						DEFAULT(0),
	Political_Faction		VARCHAR(50)				NOT NULL,
	Resume_Desc				VARCHAR(max)			NOT NULL
);

CREATE TABLE Voided_PollingStation
(
	ID						INT						PRIMARY KEY,
	CO_ID					INT						NOT NULL,
	City					VARCHAR(50)				NOT NULL,
	[Address]				VARCHAR(max)			NOT NULL,
	F_Votes_no				INT,
	S_Votes_no				INT
);
GO

sp_settriggerorder @triggername= 'dbo.trg_ReduceVotes_OnCandidateDelete', @order='First', @stmttype = 'DELETE';  
GO

sp_settriggerorder @triggername= 'dbo.trg_ReduceVotes_OnPollingStationDelete', @order='First', @stmttype = 'DELETE';  
GO

