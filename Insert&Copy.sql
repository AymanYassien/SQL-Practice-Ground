
-- INSERT INTO STATEMENT
CREATE TABLE Employees
(
    ID int ,
    Full_name  NVARCHAR(25) not null ,
    phone      NVARCHAR(15) null ,
    salary     SMALLMONEY   NULL,

    PRIMARY KEY (ID)
);

SELECT * FROM Employees


-- insert one value
INSERT INTO Employees (ID, Full_name, phone, salary)
VALUES
(1, 'AYMAN', '01121664514', 8500);

INSERT INTO Employees (ID, Full_name, phone, salary)
VALUES
(4, 'ALI', '0987654321', NULL);

-- insert multiple values
INSERT INTO Employees (ID, Full_name, phone, salary) -- if this = all cols then donot write it
VALUES
(2, 'MOHAMMED', '0598872397', 9400),
(3, 'Hussien', '002011', 10300),
(44, 'Yassien', '1234567', 11200);

-- insert selected fields 
INSERT INTO Employees (ID, Full_name)
VALUES
(55, 'Ayman0');


--   delete from Employees;
-- _____________________________________________________________________________________________________
UPDATE EMPLOYEES
SET Full_name = 'BinHammad' -- TO THIS LINE whithout where condition => update all rows;
where ID = 55;


UPDATE EMPLOYEES
SET SALARY = SALARY * 1.1
WHERE SALARY < 8500 AND ID = 44;


SELECT * From Employees

-- _____________________________________________________________________________________________________
DELETE EMPLOYEeS 
WHERE SALARY is null or id = 55;



-- _____________________________________________________________________________________________________

-- create new table and copy data to it;
SELECT *
INTO EmployeesCopy1
from Employees;

select * from EmployeesCopy1


-- create new table with only 2 rows and copy data to it;
SELECT ID, salary
into EmployeesCopy2
from Employees

select * from EmployeesCopy2

-- create new table with no copy of data
SELECT *
into EmployeesCopy3
from Employees
where 1 = 0

SELECT * from EmployeesCopy3
-- _____________________________________________________________________________________________________
create table old_persons
(
    id int,
    name NVARCHAR(22),
    age SMALLINT,
    PRIMARY KEY (id)
);

create table new_persons
(
    id int,
    name NVARCHAR(22),
    age SMALLINT,
    PRIMARY KEY (id)
)
insert into new_persons(id)
VALUES 
(1),
(2);

INSERT into old_persons
SELECT * 
From new_persons 


SELECT * From old_persons
SELECT * From new_persons

-- -------------------------------------------------------------------------
-- SELECT into from   || create table then copy values to new one
-- insert into SELECT || just copy data to new table

-- SELECT INTO
-- INSERT INTO

-- ----------------------------------------------------------------------------------------------
create table departments
(
    -- auto increment start by 100, increment by 1 
    ID int IDENTITY(100,1), -- PRIMARY key, 
    name NVARCHAR(33) NOT NULL,
     PRIMARY KEY (ID)
);

insert into Departments
VALUES
('HR');


select * from Departments

delete from departments
-- ------------------------------------------------------------------
TRUNCATE table departments; -- reset identity + no where statment .. so not count which deleted + faster

delete from departments; --     just delete records
