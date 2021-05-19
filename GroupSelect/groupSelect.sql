drop sequence salary;
drop table chave_candidate;
drop table chave_party;


Create sequence salary start with 20000 increment by 10000;

create table chave_party
  (
    partyid number primary key,
    partydesc varchar2(20)
  );

insert into chave_party
values(1,'Democrat');

insert into chave_party
values(2,'Republican');

insert into chave_party
values(3,'Independent');

insert into chave_party
values(4,'');


create table chave_candidate
  (
  lname varchar(40)  not null,
  fname varchar(20)  not null,
  address	varchar(20),
  salary number,
  dob	date,
  partyid number references chave_party
);


insert into chave_candidate
values('jennet', 'abraham', 'Berkeley, CA.', salary.nextval, '01 feb 1960',1);

insert into chave_candidate
values ( 'Green', 'abraham', 'Oakland, CA.',salary.nextval, '01 feb 1964',1 );

insert into chave_candidate
values('gren', 'cheryl','Berkeley, CA.',null,'01 feb 1968',2 );

insert into chave_candidate
values('greeenr', 'albert', 'Salt Lake City, UT', salary.nextval, '01 feb 1970',2);

insert into chave_candidate
values('gran', 'anne', 'Salt Lake City, UT', salary.nextval, '01 feb 1961',3 );

insert into chave_candidate
values('mama', 'mia', 'pepper City, UT', salary.nextval, '01 feb 1968',null );
commit;

-- My code starts here
SELECT INITCAP(fname) || ','|| INITCAP(lname) || ',' || dob AS "full information" FROM chave_candidate;

SELECT fname, lname, ROUND(MONTHS_BETWEEN(SYSDATE, dob)/12) AS "AGE" FROM chave_candidate;

SELECT DISTINCT lname FROM chave_candidate;

SELECT fname FROM chave_candidate WHERE TRUNC(MONTHS_BETWEEN(SYSDATE,dob)/12) > 40;

SELECT fname FROM chave_candidate WHERE salary IS NULL OR salary BETWEEN 20000 AND 40000;

SELECT fname FROM chave_candidate WHERE UPPER(fname) LIKE 'C%' AND TRUNC(MONTHS_BETWEEN(SYSDATE,dob)/12) > 40;