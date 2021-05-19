ALTER TABLE chave_student DROP PRIMARY KEY CASCADE;
ALTER TABLE chave_class DROP PRIMARY KEY CASCADE;
ALTER TABLE chave_student_class DROP PRIMARY KEY CASCADE;

DROP TABLE chave_student;
DROP TABLE chave_class;
DROP TABLE chave_student_class;


CREATE TABLE chave_student
(
  ssn     VARCHAR2(9) CONSTRAINT chave_student_ssn_pk PRIMARY KEY,
  lname   VARCHAR2(20),
  fname   VARCHAR2(20),
  dob     DATE,
  salary  NUMBER,
  CONSTRAINT chave_student_lname_fname_uk UNIQUE (lname,fname)
);

ALTER TABLE chave_student ADD CONSTRAINT chave_student_salary_ck CHECK(salary>10000);
CREATE INDEX chave_student_ssn_dob_idx ON chave_student (ssn,dob);

CREATE TABLE chave_class
(
  class_code          NUMBER CONSTRAINT chave_class_code_pk PRIMARY KEY,
  class_description   VARCHAR2(100) NOT NULL
);
CREATE INDEX chave_class_class_description_idx ON chave_class (class_description);

CREATE TABLE chave_student_class
(
  ssn         VARCHAR2(9),
  class_code  NUMBER
);

ALTER TABLE chave_student_class ADD CONSTRAINT chave_student_class_ssn_class_code_pk PRIMARY KEY (ssn,class_code);

ALTER TABLE chave_student_class ADD CONSTRAINT chave_student_class_ssn_fk 
FOREIGN KEY(ssn) REFERENCES chave_student;
ALTER TABLE chave_student_class ADD CONSTRAINT chave_student_class_class_code_fk
FOREIGN KEY(class_code) REFERENCES chave_class;

--------------------------------------------------------------------------------

DESC chave_student_class;

--Insert three rows of valid data into the student_class table
INSERT INTO chave_student_class VALUES ('123456789',0);
INSERT INTO chave_student_class VALUES ('123456789',1);
INSERT INTO chave_student_class VALUES ('132567586',1);

--Insert two rows of valid data into the class table according to the following.
--Make sure that you provide a value for every column.
INSERT INTO chave_class VALUES (0,'MATH 100');
INSERT INTO chave_class VALUES (1,'CSC 134');

--Insert two rows of valid data into the student table according to the 
--following. Provide a value for every column. 
--For the 1st row: 
    --Use the to_date function to insert into the DOB column in the format 
    --(yyddmm)
--For the 2nd row
    --Use the default date format (Do not use to_date function)(use default)
INSERT INTO chave_student VALUES('123456789','Smith','John',(TO_DATE(602506,'YYDDMM')),15000);
INSERT INTO chave_student VALUES('132567586','Ross','Boss','01-FEB-1989',30000);

--Insert a row of invalid data into student table such that it violates the 
--primary key
INSERT INTO chave_student VALUES('13256758695834598','Trane','Thomas','10-FEB-1980',30000);

--Insert a row of invalid data into student table such that it violates the 
--candidate key
INSERT INTO chave_student VALUES('135304389','Ross','Boss','10-FEB-1980',20000);

--Insert a row of invalid data into student table such that it violates a 
--check constraint
INSERT INTO chave_student VALUES('132567582','Trane','Thomas','10-FEB-1980',9000);

--Insert a row of invalid data into the student_class table such that it 
--violates the foreign key to the class table
INSERT INTO chave_student_class VALUES('123495334',0);

--Insert a row of invalid data into the student_class table such that it 
--violates the foreign key to the student table 
INSERT INTO chave_student_class VALUES('245306649',5);

--Insert a row of invalid data into the student_class table such that it 
--violates the primary key in the student_class table.
INSERT INTO chave_student_class VALUES('123456789',0);

--Disable the foreign key constraint to the student table 
ALTER TABLE chave_student_class DISABLE CONSTRAINT chave_student_class_ssn_fk;

--Insert a rows of data into the student_class table such that it would violate 
--the foreign key constraint if the above  constraint to the student table 
--was enabled
INSERT INTO chave_student_class VALUES('987654321',0);

--Enable the foreign key constraint
ALTER TABLE chave_student_class ENABLE CONSTRAINT chave_student_class_ssn_fk;

--Delete the data from the student_class table 
DELETE FROM chave_student_class;

--Truncate the student table 
TRUNCATE TABLE chave_student;

--drop the index that you created on the student table
DROP INDEX chave_student_ssn_dob_idx;

--Drop the foreign key constraints 
ALTER TABLE chave_student_class DROP CONSTRAINT chave_student_class_ssn_fk;
ALTER TABLE chave_student_class DROP CONSTRAINT chave_student_class_class_code_fk;

--Drop the student table. 
DROP TABLE chave_student;