create DATABASE aymanDB;

CREATE DATABASE db1;

 create database db2;

 create database db3;

 create database db4;

SELECT * FROM sys.databases where  name = 'DB1';


IF NOT EXISTS(SELECT * FROM sys.databases where name = 'db66')
BEGIN 
    CREATE DATABASE db66;
    CREATE DATABASE DBB66;
END

use master
if EXISTS(SELECT * FROM sys.databases where name = 'dbb66')
BEGIN
    DROP DATABASE dbb66;
END

-- IF EXISTS(SELECT * FROM sys.databases where name = 'db3')
-- BEGIN
--     --SELECT * FROM sys.databases where name = 'db1';
--     DROP DATABASE db3;
-- END

-- CREATE DATABASE db1;

-- CREATE DATABASE db2;

--------------------------------------------------------------------------------------------------------------
-- use db1;
CREATE TABLE EMPLOYEES
(
    ID INT,
    FIRST_NAME NVARCHAR(50),
    LAST_NAME  NVARCHAR(50),
    AGE        SMALLINT,
    SALARY SMALLMONEY,
    PRIMARY KEY(ID)
);

-- use asp;

DROP TABLE EMPLOYEES;


USE asp;

CREATE TABLE EMPLOYEES 
(
    ID         INT         ,
    FIRST_NAME NVARCHAR(30),
    LAST_NBAME NVARCHAR(30),
    SALARY     SMALLMONEY  ,
    AGE        TINYINT     , 

    PRIMARY KEY (ID)
);

ALTER TABLE EMPLOYEES
ADD GENDER CHAR(1);


-- stored procedure; || old name, new_name, type to modify -------------------------------------

EXEC sp_rename 'employees.gen8der', 'GENDER', 'column';

use asp;

create table tempEmps
(
    ID  INT,
    TMP INT,

    PRIMARY KEY(ID)
);
-------------------------------------------------------------------------- ADD COLUMN
ALTER TABLE tempEmps
ADD TEST DATE;
-------------------------------------------------------------------------- RENAME TABLE/COLUMN
EXEC sp_rename 'TEMPEMPS.TMP', 'temp', 'column';
EXEC sp_rename 'EMPLOYEES.LAST_NBAME', 'LAST_NAME', 'COLUMN'

exec sp_rename 'tempEmps', 'Employees_0';
-------------------------------------------------------------------------- MODIFY COLUMN
alter TABLE employees
ALTER COLUMN FIRST_NAME NVARCHAR(121) NOT NULL;

ALTER TABLE EMPLOYEES
ALTER COLUMN LAST_NAME NVARCHAR(87) NOT NULL;
-------------------------------------------------------------------------- DROP COLUMN
USE ASP;

ALTER TABLE EMPLOYEES
DROP COLUMN  GENDER;


----------------------------------------------------------------------------------------------------------------------------------------------------
use master;

drop table aymanDB;

use db2;

CREATE TABLE Employees
(
    ID int ,
    Full_name  NVARCHAR(25) not null ,
    phone      NVARCHAR(15) null ,
    salary     SMALLMONEY   NULL,

    PRIMARY KEY (ID)
);