SELECT partyid, COUNT(*) 
FROM chave_candidate 
GROUP BY partyid
ORDER BY partyid;

SELECT partyid, COUNT(partyid) 
FROM chave_candidate 
WHERE LOWER(fname) LIKE 'd%' OR LOWER(fname) LIKE 'r%'
GROUP BY partyid;

SELECT partyid, AVG(salary) 
FROM chave_candidate
GROUP BY partyid;

SELECT partyid, COUNT(partyid)
FROM chave_candidate
GROUP BY partyid
HAVING NOT(COUNT(*)>2);

SELECT partyid, AVG(salary)
FROM chave_candidate
GROUP BY partyid
HAVING NOT(AVG(salary)>50000);

DROP TABLE chave_candidate2;
CREATE TABLE chave_candidate2 AS SELECT partyid party_code, COUNT(partyid) num_of_people
FROM chave_candidate
WHERE partyid IS NOT NULL
GROUP BY partyid;
SELECT * FROM chave_candidate2;