--Question 1
SELECT * FROM chave_party, chave_candidate;

--Alternative way
SELECT * FROM chave_party CROSS JOIN chave_candidate;

--Question 2
SELECT lname "Last Name", partydesc "Party Description"
FROM chave_party, chave_candidate
WHERE chave_party.partyid=chave_candidate.partyid;

--Question 3
SELECT lname "Last Name", NVL(partydesc,'no description') "Party Description"
FROM chave_party, chave_candidate
WHERE chave_party.partyid=chave_candidate.partyid;

--Question 4
SELECT partydesc "Party Description", COUNT(chave_candidate.partyid) "Number of People"
FROM chave_party, chave_candidate
WHERE chave_party.partyid=chave_candidate.partyid
GROUP BY partydesc;

--Verify values in candidate table
SELECT partyid,salary FROM chave_candidate;

--Question 5
SELECT partydesc "Party Name", COUNT(chave_candidate.partyid) "Number of People"
FROM chave_party, chave_candidate
WHERE chave_party.partyid=chave_candidate.partyid
GROUP BY partydesc
HAVING AVG(salary) > 50000;