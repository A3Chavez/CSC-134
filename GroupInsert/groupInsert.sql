DROP TABLE Candidate_AEC;
DROP TABLE Party_AEC;

CREATE TABLE Candidate_AEC
(
  Candidate_id  NUMBER CONSTRAINT candidate_aec_candidate_id_pk PRIMARY KEY,
  First_name    VARCHAR2(20),
  Last_name     VARCHAR2(20),
  DOB           DATE,
  Salary        NUMBER CONSTRAINT candidate_aec_salary_ck CHECK (salary>10000 AND salary<50000),
  Party_id      NUMBER CONSTRAINT candidate_aec_party_id_fk REFERENCES party_aec,
  CONSTRAINT candidate_aec_fname_lname_uk UNIQUE (First_name, Last_name)
);

CREATE TABLE Party_AEC
(
  Party_id    NUMBER CONSTRAINT party_aec_party_id_pk PRIMARY KEY,
  PartyDesc   VARCHAR2(30) CONSTRAINT party_aec_partyDesc_uk UNIQUE
);

DESC Candidate_AEC;
SELECT table_name, constraint_name, constraint_type FROM user_constraints WHERE table_name='CANDIDATE_AEC';

DESC Party_AEC;
SELECT table_name, constraint_name, constraint_type FROM user_constraints WHERE table_name='PARTY_AEC';

INSERT INTO Party_aec VALUES (100,'Democrat');
INSERT INTO Party_aec VALUES (200,'Republican');
SELECT * FROM party_aec;

INSERT INTO Candidate_aec VALUES (111,'Joe','Biden','01-FEB-1960',20000,100);
INSERT INTO Candidate_aec VALUES (222,'Donald','Trump','13-FEB-1980',45000,200);
SELECT * FROM candidate_aec;

INSERT INTO Candidate_aec VALUES (333,'Kamala','Harris',(TO_DATE('102064','MMDDYY')),30000,100);
INSERT INTO Candidate_aec VALUES (444,'Mike','Pence',(TO_DATE('078506','DDYYMM')),48000,200);
SELECT * FROM candidate_aec;

SELECT TO_CHAR(DOB,'MMDDYYYY') FROM candidate_aec;

SELECT TO_CHAR(DOB,'DDYYYYMM HH12:MI:SS') FROM candidate_aec;

INSERT INTO Candidate_aec VALUES (555,'Hillary','Clinton','05-JAN-1970',60000,100);

INSERT INTO Candidate_aec VALUES (555,'Donald','Trump','13-FEB-1980',45000,200);

SELECT table_name, constraint_name, constraint_type FROM user_constraints WHERE table_name='CANDIDATE_AEC';
SELECT table_name, constraint_name, constraint_type FROM user_constraints WHERE table_name='PARTY_AEC';