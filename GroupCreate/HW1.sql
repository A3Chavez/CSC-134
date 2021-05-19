DROP TABLE Candidate;
DROP TABLE Party;

CREATE TABLE Candidate
(
  FName VARCHAR2(20),
  LName VARCHAR2(20),
  DOB DATE,
  Salary NUMBER
);

CREATE TABLE Party
(
  PartyDesc VARCHAR2(20)
);

ALTER TABLE Candidate DROP (DOB);
DESC Candidate;

ALTER TABLE Candidate ADD DOB DATE;
DESC Candidate;

ALTER TABLE Candidate ADD candidate_id NUMBER;
ALTER TABLE Candidate ADD PRIMARY KEY (candidate_id);
DESC Candidate;

ALTER TABLE Party DROP (party_id);
ALTER TABLE Party ADD party_id NUMBER;
ALTER TABLE Party ADD PRIMARY KEY (party_id);
DESC Party;

ALTER TABLE Candidate ADD UNIQUE (FName,LName);
DESC Candidate;

DROP TABLE Party;
DESC Party;
CREATE TABLE Party
(
  Party_id NUMBER PRIMARY KEY,
  PartyDesc VARCHAR2(20)
);
DESC Party;