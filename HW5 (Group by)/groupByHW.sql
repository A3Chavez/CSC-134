SELECT * FROM chave_student;
DESC chave_student
DESC chave_class
DESC chave_student_class

SELECT lname "Last Name", COUNT(lname) "Number of People"
FROM chave_student 
WHERE UPPER(state)!='CA' 
GROUP BY lname
ORDER BY lname;

SELECT state, COUNT(state) "Number of People"
FROM chave_student
WHERE NOT(LOWER(city) LIKE '%h%')
GROUP BY state
ORDER BY state;

SELECT ssn, COUNT(class_code) "number of classes"
FROM chave_student_class
GROUP BY ssn
HAVING COUNT(class_code) < 2
ORDER BY ssn DESC;

SELECT city, state, AVG(TRUNC(MONTHS_BETWEEN(SYSDATE,dob)/12)) "Age"
FROM chave_student 
WHERE salary > (SELECT AVG(salary) FROM chave_student) AND ssn IN
(SELECT ssn from chave_student_class WHERE class_code IN
(SELECT class_code FROM chave_class WHERE UPPER(class_description) LIKE 'INTRO%'))
AND UPPER(city) != 'BERKELEY'
GROUP BY city,state
ORDER BY city ASC, state DESC;

SELECT LOWER(state) "States", ROUND(AVG(TRUNC(MONTHS_BETWEEN(SYSDATE,dob)/12))) "average of ages"
FROM chave_student WHERE ssn IN
(SELECT ssn FROM chave_student_class WHERE class_code IN
(SELECT class_code FROM chave_class WHERE LOWER(class_description) LIKE '%principles'))
GROUP BY LOWER(state)
ORDER BY LOWER(state);