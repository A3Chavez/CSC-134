SELECT * FROM chave_candidate;

-- Question 1
SELECT fname || ' ' || lname AS Name, 'Honest' AS Description FROM chave_candidate WHERE salary < 50000
UNION
SELECT fname || ' ' || lname AS Name, 'Not so honest' FROM chave_candidate WHERE salary > 50000 AND salary < 100000
UNION
SELECT fname || ' ' || lname AS Name, '80000' FROM chave_candidate WHERE salary > 100000
ORDER BY Name;

-- Question 2
SELECT fname || ' ' || lname AS Name,
CASE  WHEN salary < 50000 THEN 'Honest'
      WHEN salary > 50000 AND salary < 100000 THEN 'Not so honest'
      WHEN salary > 100000 THEN '80000'
END AS Description
FROM chave_candidate
ORDER BY Name;

SELECT * FROM chave_candidate;

SELECT fname || ' ' || lname AS Name,
CASE  WHEN salary < 50000 THEN 'Honest'
      WHEN salary > 50000 AND salary < 100000 THEN 'Not so honest'
      WHEN salary > 100000 THEN '80000'
END AS Description
FROM chave_candidate
WHERE salary IS NOT NULL AND salary != 50000 AND salary != 100000
ORDER BY Name;

-- Question 3
SELECT fname || ' ' || lname AS Name, 'No party' AS Party
FROM chave_candidate
WHERE NVL(partyid,0) NOT IN (SELECT partyid FROM chave_party);

-- Question 4
SELECT fname || ' ' || lname AS Name, 'No party' AS Party
FROM chave_candidate c 
WHERE NOT EXISTS (SELECT * FROM chave_party p WHERE c.partyid = p.partyid);

-- Question 5
SELECT fname || ' ' || lname AS Name, 'No party' AS Party FROM chave_candidate
MINUS
SELECT fname || ' ' || lname AS Name, 'No party' FROM chave_candidate WHERE partyid IS NOT NULL;