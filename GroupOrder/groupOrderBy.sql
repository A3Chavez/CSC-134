SELECT lname, fname, salary FROM chave_candidate ORDER BY lname;

SELECT lname, fname, salary FROM chave_candidate ORDER BY 1 DESC, 2 DESC;

SELECT lname, fname, salary*2 double_salary 
FROM chave_candidate 
ORDER BY double_salary DESC;