SELECT * FROM chave_candidate;
SELECT * FROM chave_party;

SELECT fname FROM chave_candidate WHERE partyid=
(SELECT partyid FROM chave_party WHERE partydesc = 'Democrat');

SELECT partydesc FROM chave_party WHERE partyid IN
(SELECT partyid FROM chave_candidate WHERE UPPER(lname) LIKE '%C');

SELECT fname FROM chave_candidate WHERE partyid IN
(SELECT partyid FROM chave_party WHERE LOWER(partydesc) IN ('democrat','republican'));

SELECT * FROM chave_candidate2;
DROP TABLE chave_candidate2;

CREATE TABLE chave_candidate2 AS SELECT fname, lname, salary*.90 salary_lowered
FROM chave_candidate
WHERE partyid=
(SELECT partyid FROM chave_party WHERE partydesc='Republican');