ALTER TABLE Candidate DROP CONSTRAINT candidate_salary_ck;
ALTER TABLE Candidate MODIFY Salary CONSTRAINT cand_salary_ck CHECK(Salary>10000 AND Salary<50000);
DESC Candidate;
SELECT table_name, constraint_name, constraint_type FROM user_constraints WHERE table_name='CANDIDATE';

ALTER TABLE Party MODIFY PartyDesc NOT NULL;
DESC Party;
SELECT table_name, constraint_name, constraint_type FROM user_constraints WHERE table_name='PARTY';

ALTER TABLE Candidate DISABLE CONSTRAINT cand_salary_ck;
SELECT constraint_name, constraint_type, status FROM user_constraints WHERE table_name='CANDIDATE';

ALTER TABLE Candidate ADD Party_id NUMBER;
ALTER TABLE Candidate ADD CONSTRAINT cand_party_id_fk FOREIGN KEY(party_id) REFERENCES Party;
DESC Candidate;
SELECT constraint_name, constraint_type, status FROM user_constraints WHERE table_name='PARTY';

ALTER TABLE Candidate DISABLE CONSTRAINT cand_party_id_fk;
SELECT constraint_name, constraint_type, status FROM user_constraints WHERE table_name='CANDIDATE';

ALTER TABLE Candidate DROP CONSTRAINT cand_party_id_fk;
SELECT constraint_name, constraint_type, status FROM user_constraints WHERE table_name='CANDIDATE';