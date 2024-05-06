use master

RESTORE DATABASE HR_Database
FROM DISK  = 'HR_Database.bak'

-- ---------------------------------------------------

use master

if  NOT EXISTS (SELECT * from sys.databases  WHERE name = 'HR_Databases')
BEGIN
    CREATE DATABASE HR_Databases;
END

IF NOT EXISTS(SELECT * FROM sys.databases where name = 'db66')
BEGIN 
    CREATE DATABASE db66;
    CREATE DATABASE DBB66;
    
END