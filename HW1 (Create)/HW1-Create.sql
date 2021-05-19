DROP TABLE chave_student;

CREATE TABLE chave_student
(
  ssn     VARCHAR2(9) CONSTRAINT chave_student_ssn_pk PRIMARY KEY,
  lname   VARCHAR2(20),
  fname   VARCHAR2(20),
  age     NUMBER,
  salary  NUMBER,
  dob     NUMBER
);

ALTER TABLE chave_student ADD UNIQUE (lname,fname);

ALTER TABLE chave_student MODIFY age CONSTRAINT chave_student_age_ck CHECK(age>10 AND age<50);

ALTER TABLE chave_student ADD address NUMBER;

ALTER TABLE chave_student MODIFY dob DATE NOT NULL;
DESC chave_student;

CREATE INDEX chave_student_ssn_dob_idx ON chave_student (ssn,dob);

ALTER TABLE chave_student ADD transferable VARCHAR2(5) NOT NULL;

ALTER TABLE chave_student MODIFY transferable CONSTRAINT chave_student_transferable_ck 
CHECK(transferable='y' OR transferable='Y' OR transferable='n' OR transferable='N');

ALTER TABLE chave_student DROP (age);

DROP TABLE chave_class;

CREATE TABLE chave_class
(
  class_code          NUMBER,
  class_description   VARCHAR2(100) NOT NULL,
  CONSTRAINT chave_class_class_description_uk UNIQUE (class_description)
);

ALTER TABLE chave_class MODIFY class_code CONSTRAINT chave_class_class_code_pk PRIMARY KEY;

DROP INDEX chav_class_class_description_idx;
SELECT index_name FROM user_indexes WHERE table_name='CHAVE_CLASS';

CREATE INDEX chav_class_class_description_idx ON chave_class (class_description);

DROP TABLE chave_student_class;

CREATE TABLE chave_student_class
(
  ssn         VARCHAR2(9),
  class_code  NUMBER
);

ALTER TABLE chave_student_class DROP PRIMARY KEY;
DESC chave_student_class;
SELECT table_name, constraint_name, constraint_type FROM user_constraints WHERE table_name='CHAVE_STUDENT_CLASS';

ALTER TABLE chave_student_class ADD CONSTRAINT chave_student_class_ssn_class_code_pk PRIMARY KEY (ssn,class_code);

ALTER TABLE chave_student_class DROP CONSTRAINT chave_student_class_ssn_fk;
ALTER TABLE chave_student_class DROP CONSTRAINT chave_student_class_class_code_fk;

ALTER TABLE chave_student_class ADD CONSTRAINT chave_student_class_ssn_fk 
FOREIGN KEY(ssn) REFERENCES chave_student;
ALTER TABLE chave_student_class ADD CONSTRAINT chave_student_class_class_code_fk
FOREIGN KEY(class_code) REFERENCES chave_class;