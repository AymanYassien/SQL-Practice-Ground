--------------------------------------------------------------------------Backup database
-- to take a backup, and try to restore it,
-- or go to docker then open container file's search in previous path then can import file to any external directory (outer Docker) 
-- follow thoose steps :

-- Ensure you switch database to master when you run next Commands: 

-- BACKUP
-- DROP
-- RESTORE

-- 'var/opt/mssql/data/var/backups/file_name.bak'; "this place which store backup"

backup DATABASE db1
to disk = 'var/backups/learnsql01.bak'

WITH DIFFEREntial; 
-- by default : backup type is full, another type is differential baackup that only update new on last backup

use master;
DROP DATABASE db1;


use master;
restore database db1
from disk = 'var/backups/learnsql01.bak';

-- if you have a file on your downloads and you want to move it in docker then restore database,
-- docker ps => this command in terminal give you docker_id
-- docker cp ~/Downloads/HR_Database.bak b24030e6b0e2:/var/opt/mssql/data/  => copy data here
-- to restore 

-- use master


-- RESTORE DATABASE HR_Database
-- FROM DISK  = 'HR_Database.bak'