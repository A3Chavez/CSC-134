-- Display student table
SELECT * FROM chave_student ORDER BY ssn;

-- Display student_class table
SELECT * FROM chave_student_class;

-- Display class table
SELECT * FROM chave_class;

-- Question 1

-- INNER JOIN
SELECT s.ssn, fname "First Name", NVL(class_description,'No description is available yet') "Class Description"
FROM chave_student s, chave_student_class sc, chave_class c
WHERE s.ssn=sc.ssn AND sc.class_code=c.class_code;

-- OUTER JOIN, + syntax
SELECT s.ssn, fname "First Name", NVL(class_description,'No description is available yet') "Class Description"
FROM chave_student s, chave_student_class sc, chave_class c
WHERE s.ssn(+) = sc.ssn AND sc.class_code = c.class_code(+);

-- OUTER JOIN, RIGHT OUTER JOIN
SELECT s.ssn, fname "First Name", NVL(class_description,'No description is available yet') "Class Description"
FROM chave_student s RIGHT OUTER JOIN chave_student_class sc ON s.ssn = sc.ssn LEFT OUTER JOIN chave_class c
ON sc.class_code = c.class_code;

-- NATURAL JOIN, inner join
SELECT ssn, fname "First Name", lname "Last Name", NVL(class_description,'No description is available yet') "Class Description"
FROM chave_student NATURAL JOIN chave_student_class NATURAL JOIN chave_class;

-- Question 2
SELECT lname "Last Name", c.class_code "Class Code"
FROM chave_student s, chave_student_class sc, chave_class c
WHERE s.ssn = sc.ssn 
      AND sc.class_code = c.class_code
      AND c.class_description = 'Introduction to C programming';

-- Question 3
-- All student ages
SELECT fname, lname, TRUNC(MONTHS_BETWEEN(SYSDATE,dob)/12) FROM chave_student;

-- student age average
SELECT AVG(TRUNC(MONTHS_BETWEEN(SYSDATE,dob)/12)) FROM chave_student;

-- students older than student age average
SELECT fname, lname, dob
FROM chave_student
WHERE TRUNC(MONTHS_BETWEEN(SYSDATE,dob)/12) > (SELECT AVG(TRUNC(MONTHS_BETWEEN(SYSDATE,dob)/12)) FROM chave_student);

-- students older than student age average and classes
SELECT fname, lname, dob, class_description
FROM chave_student s, chave_student_class sc, chave_class c
WHERE s.ssn = sc.ssn AND
      sc.class_code = c.class_code AND
      TRUNC(MONTHS_BETWEEN(SYSDATE,dob)/12) > (SELECT AVG(TRUNC(MONTHS_BETWEEN(SYSDATE,dob)/12)) FROM chave_student);

-- Final Query
SELECT NVL(class_description,'Other Classes') "Class Description", COUNT(s.ssn) "Number of Students"
FROM chave_student s, chave_student_class sc, chave_class c
WHERE s.ssn = sc.ssn AND
      sc.class_code = c.class_code AND
      TRUNC(MONTHS_BETWEEN(SYSDATE,dob)/12) > (SELECT AVG(TRUNC(MONTHS_BETWEEN(SYSDATE,dob)/12)) FROM chave_student)
GROUP BY NVL(class_description,'Other Classes')
HAVING COUNT(*) > 1
ORDER BY 2;

-- Question 4
SELECT * FROM chave_student ORDER BY fname;
SELECT * FROM chave_class;

-- Every student with class(es)
SELECT fname, lname, class_code, class_description "Classes"
FROM chave_student s NATURAL JOIN chave_student_class sc NATURAL JOIN chave_class c
ORDER BY ssn; 

-- Looking for 14A class
SELECT class_code "Class Code", class_description "Classes With No Students"
FROM chave_class
WHERE class_code NOT IN (SELECT class_code FROM chave_student_class); 

-- Question 5
SELECT * 
FROM chave_student s
WHERE NOT EXISTS (SELECT sc.ssn 
                  FROM chave_student_class sc 
                  WHERE sc.ssn = s.ssn);

-- Question 6

-- students taking classes with class description
SELECT s.ssn, fname "First Name", NVL(class_description,'No description is available yet') "Class Description"
FROM chave_student s, chave_student_class sc, chave_class c
WHERE s.ssn=sc.ssn AND sc.class_code=c.class_code;

-- students not taking any classes
SELECT ssn, fname, 'No classes' FROM chave_student
MINUS
SELECT s.ssn, fname, 'No classes' FROM chave_student s, chave_student_class sc
WHERE s.ssn=sc.ssn;

-- Drop table and Display table
DROP TABLE chave_student_class_desc;
SELECT * FROM chave_student_class_desc;

-- SELECT Statement
SELECT s.ssn, fname "First Name", NVL(class_description,'No description') "Class Description"
FROM chave_student s, chave_student_class sc, chave_class c
WHERE s.ssn=sc.ssn AND sc.class_code=c.class_code
UNION
(SELECT ssn, fname, 'No classes' FROM chave_student
MINUS
SELECT s.ssn, fname, 'No classes' FROM chave_student s, chave_student_class sc WHERE s.ssn=sc.ssn);

-- Final Answer
CREATE TABLE chave_student_class_desc AS 
SELECT s.ssn, fname "First Name", NVL(class_description,'No description') "Class Description"
FROM chave_student s, chave_student_class sc, chave_class c
WHERE s.ssn=sc.ssn AND sc.class_code=c.class_code
UNION
(SELECT ssn, fname, 'No classes' FROM chave_student
MINUS
SELECT s.ssn, fname, 'No classes' FROM chave_student s, chave_student_class sc WHERE s.ssn=sc.ssn);

-- Question 7

-- Drop table and Display table
DROP TABLE chave_student_class_desc;
SELECT * FROM chave_student_class_desc;

-- SELECT statement
SELECT s.ssn, fname "First Name", NVL(class_description,'No description') "Class Description"
FROM chave_student s, chave_student_class sc, chave_class c
WHERE s.ssn=sc.ssn AND sc.class_code=c.class_code
UNION
(SELECT s.ssn, fname, 'No classes' FROM chave_student s
WHERE NOT EXISTS (SELECT sc.ssn FROM chave_student_class sc WHERE sc.ssn = s.ssn));

-- CREATE table
CREATE TABLE chave_student_class_desc AS
SELECT s.ssn, fname "First Name", NVL(class_description,'No description') "Class Description"
FROM chave_student s, chave_student_class sc, chave_class c
WHERE s.ssn=sc.ssn AND sc.class_code=c.class_code
UNION
(SELECT s.ssn, fname, 'No classes' FROM chave_student s
WHERE NOT EXISTS (SELECT sc.ssn FROM chave_student_class sc WHERE sc.ssn = s.ssn));

-- Question 8
DROP VIEW chave_student_classes_view;

CREATE VIEW chave_student_classes_view AS SELECT s.ssn, fname "First Name", NVL(class_description,'No description') "Class Description"
FROM chave_student s, chave_student_class sc, chave_class c
WHERE s.ssn=sc.ssn AND 
      sc.class_code=c.class_code AND
      TRUNC(MONTHS_BETWEEN(SYSDATE,dob)/12) > (SELECT AVG(TRUNC(MONTHS_BETWEEN(SYSDATE,dob)/12)) FROM chave_student)
ORDER BY 1;

SELECT * FROM chave_student_classes_view;

-- Question 9

-- All people & classes
SELECT s.ssn, fname || ' ' || lname AS "Name", c.class_code AS "Class Code", NVL(class_description,'No description') AS "Class Description"
FROM chave_student s, chave_student_class sc, chave_class c;

-- People with classes they are taking
SELECT s.ssn, fname "First Name", NVL(class_description,'No description is available yet') "Class Description"
FROM chave_student s, chave_student_class sc, chave_class c
WHERE s.ssn=sc.ssn AND sc.class_code=c.class_code;

-- all people & classes they are not taking
SELECT s.ssn, fname || ' ' || lname AS "Name", c.class_code AS "Class Code", NVL(class_description,'No description') AS "Class Description"
FROM chave_student s, chave_student_class sc, chave_class c
MINUS
SELECT s.ssn, fname || ' ' || lname, c.class_code, NVL(class_description,'No description')
FROM chave_student s, chave_student_class sc, chave_class c
WHERE s.ssn=sc.ssn AND sc.class_code=c.class_code
ORDER BY 1;

-- Question 10

-- part a
SELECT uc.table_name, uc.constraint_name, r_constraint_name, column_name
FROM user_constraints uc, user_cons_columns ucc 
WHERE uc.constraint_name = ucc.constraint_name AND
      uc.table_name='CHAVE_STUDENT' AND
      constraint_type = 'P';

-- part b
SELECT uc.table_name, uc.constraint_name, r_constraint_name, column_name
FROM user_constraints uc, user_cons_columns ucc 
WHERE uc.constraint_name = ucc.constraint_name AND
      uc.table_name='CHAVE_STUDENT' AND
      constraint_type = 'U';

-- part c
SELECT uc.table_name, uc.constraint_name, r_constraint_name, column_name
FROM user_constraints uc, user_cons_columns ucc 
WHERE uc.constraint_name = ucc.constraint_name AND
      uc.table_name='CHAVE_STUDENT_CLASS' AND
      constraint_type = 'R';

-- part d
SELECT table_name, constraint_name, r_constraint_name, status
FROM user_constraints 
WHERE table_name='CHAVE_STUDENT' AND
      constraint_type = 'C';
