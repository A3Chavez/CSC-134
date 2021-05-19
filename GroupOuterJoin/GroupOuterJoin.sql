-- Question 1
-- OUTER JOIN, + syntax
SELECT lname, NVL(partydesc,'no party') "Party Name"
FROM chave_party, chave_candidate
WHERE chave_party.partyid(+) = chave_candidate.partyid;

-- OUTER JOIN, LEFT OUTER JOIN
SELECT lname, NVL(partydesc,'no party') "Party Name"
FROM chave_candidate c LEFT OUTER JOIN chave_party p
ON c.partyid = p.partyid;

-- OUTER JOIN, RIGHT OUTER JOIN
SELECT lname, NVL(partydesc,'no party') "Party Name"
FROM chave_party p RIGHT OUTER JOIN chave_candidate c
ON p.partyid = c.partyid;

-- Question 2
-- OUTER JOIN, + syntax
SELECT NVL(lname, 'No one') "Last Name", partydesc "Party Name"
FROM chave_party p, chave_candidate c
WHERE p.partyid = c.partyid(+);

-- OUTER JOIN, LEFT OUTER JOIN
SELECT NVL(lname, 'No one') "Last Name", partydesc "Party Name"
FROM chave_party p LEFT OUTER JOIN chave_candidate c
ON p.partyid = c.partyid;

-- OUTER JOIN, RIGHT OUTER JOIN
SELECT NVL(lname, 'No one') "Last Name", partydesc "Party Name"
FROM chave_candidate c RIGHT OUTER JOIN chave_party p
ON c.partyid = p.partyid;