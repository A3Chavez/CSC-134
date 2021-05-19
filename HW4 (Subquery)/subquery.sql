SELECT fname "First Name", lname "Last Name"
FROM chave_student
WHERE ssn IN
	(SELECT ssn 
	 FROM chave_student_class
	 WHERE class_code =
	 	(SELECT class_code 
		 FROM chave_class 
		 WHERE LOWER(class_description)='database programming'));

SELECT ssn, class_code "Class Code"
FROM chave_student_class
WHERE class_code IN
	(SELECT class_code
	 FROM chave_class
	 WHERE class_description IS NOT NULL);

SELECT fname "First Name", lname "Last Name"
FROM chave_student
WHERE INITCAP(fname) NOT IN ('John','Jack','Bob') AND phone IS NULL AND ssn IN
	(SELECT ssn
	 FROM chave_student_class
	 WHERE class_code =
	 	 (SELECT class_code
	 	  FROM chave_class
	 	  WHERE LOWER(class_description) = 'operating systems'));

SELECT ssn, fname "First Name", lname "Last Name", (TRUNC(MONTHS_BETWEEN(SYSDATE,dob)/12))/2 "Age"
FROM chave_student
WHERE INITCAP(fname) LIKE 'J%' AND (TRUNC(MONTHS_BETWEEN(SYSDATE,dob)/12)) > 25 AND ssn IN
	(SELECT ssn
	 FROM chave_student_class
	 WHERE class_code IN
	 	 (SELECT class_code
	 	  FROM chave_class
	 	  WHERE INITCAP(class_description) LIKE 'Intro%'))
ORDER BY "Age" DESC;

SELECT fname "First Name", lname "Last Name"
FROM chave_student
WHERE LOWER(lname) LIKE '%nn%' AND ssn IN
	(SELECT ssn
	 FROM chave_student_class
	 WHERE class_code IN
	 	 (SELECT class_code
	 	  FROM chave_class
	 	  WHERE LOWER(class_description) LIKE '%h%'))
ORDER BY 2;

DELETE FROM chave_class WHERE class_code IN
	(SELECT class_code
	 FROM chave_student_class
	 WHERE ssn IN
	 	 (SELECT ssn
	 	  FROM chave_student
	 	  WHERE UPPER(city) = 'SACRAMENTO' AND salary < 15000));

DROP TABLE chave_class2;
CREATE TABLE chave_class2 AS SELECT class_description
FROM chave_class
WHERE class_code IN
	(SELECT class_code
	 FROM chave_student_class
	 WHERE ssn IN
	 	 (SELECT ssn
	 	  FROM chave_student
	 	  WHERE (TRUNC(MONTHS_BETWEEN(SYSDATE,dob)/12)) > 30));
SELECT * FROM chave_class2;

UPDATE chave_student 
SET salary=75000 
WHERE ssn IN
	(SELECT ssn
	 FROM chave_student_class
	 WHERE class_code =
	 	 (SELECT class_code
	 	  FROM chave_class
	 	  WHERE LOWER(class_description) = 'database programming' AND UPPER(state) = 'CA'));
      
SELECT * FROM chave_student;
-- Fix updated rows
UPDATE chave_student SET salary=10000 WHERE fname='Abraham' and lname='Bennet';
