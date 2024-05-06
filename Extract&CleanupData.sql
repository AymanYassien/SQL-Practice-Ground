
---------- ------------ ------------- ---------- ------------ Title

/*
here a  project on SQL queries, 
first of all we extract data from comma file, then add it into new database,
second: we extract data and truncat it to tables and connect tables with them
third : i wrote each query then solve each one,
you find queries separated by line separator.

files: data file, file contain queries that reorgnize data, more than 50 query

*/

---------------------------------------------------- makes .. not all script
INSERT into makes 
select make_id, make from car_details 

EXEC sp_rename 'car_details.car_id', 'Make_id', 'Column'


-- --------------------------------------------------------------gold one

UPDATE car_details
set make_id =  (select make_id from makes where make_name = car_details.Make) -- fail

UPDATE car_details
SET make_id = makes.make_id
FROM car_details
INNER JOIN makes ON car_details.Make = makes.make_name;                     -- true

alter table car_details
DROP Column Make

select * from car_details
---------- ------------ ------------- ---------- ------------ Fuel_Types 
-- create fuel_type table
Create Table Fuel_Types
(
    Fuel_Type_ID int IDENTITY(1,1) PRIMARY KEY,
    Fuel_Type_name NVARCHAR(100)
)

-- Fill fuel table
insert into Fuel_Types
select Distinct Fuel_Type_Name
FROM car_details
 
-- modify old table
alter table car_details
add Fuel_Types_ID int null

-- fill ids in original tables
update car_details
set Fuel_Types_ID =  Fuel_Type_ID
from Fuel_Types
Join car_details 
ON car_details.Fuel_Type_Name = Fuel_Types.Fuel_Type_name

-- delete column
alter table car_details
drop COLUMN Fuel_Type_Name


select * from car_details
---------- ------------ ------------- ---------- ------------ drive_Types 
-- Create drive_Types table
create Table drive_Types
(
    driveTypeID int IDENTITY(1,1) PRIMARY key,
    driveTypeName NVARCHAR(100) 
)

-- fill drive_Types
insert into drive_Types
select DISTINCT Drive_Type
FROM car_details

-- modify old table
ALTER TABLE car_details
ADD drive_Types_ID int null

-- fill ids in original tables
update car_details
set drive_Types_ID = driveTypeID
FROM drive_Types
JOIN car_details
ON drive_Types.driveTypeName = car_details.Drive_Type

-- delete column
ALTER TABLE car_details
DROP COLUMN Drive_Type


select BodyID, Body from car_details
---------- ------------ ------------- ---------- ------------ Bodies
-- CREATE TABLE Bodies
CREATE TABLE Bodies
(
    BodyID int IDENTITY(1,1) PRIMARY KEY,
    BodyName NVARCHAR(100)
) 

-- Fill Bodies
INSERT INTO Bodies
select DISTINCT  Body
From car_details 


-- modify old table
ALTER TABLE car_details
ADD BodyID INT NULL

-- fill ids in original tables
update car_details 
set BodyID = Bodies.BodyID
FROM Bodies
JOIN car_details
ON Bodies.BodyName = car_details.Body 

-- delete column
ALTER TABLE car_details
DROP Column Body


select Distinct Make_ID, Model_ID from car_details
select  Count(Make_ID) from (select Distinct Make_ID, Model_ID from car_details)res
---------- ------------ ------------- ---------- ------------ ------------ ------------ MakeModels
-- CREATE TABLE MakeModels
CREATE TABLE MakeModels
(
    Model_ID int IDENTITY(1,1) Primary Key,
    ModelName NVARCHAR(100),
    Make_ID int null
)

-- Fill MakeModels
INSERT INTO MakeModels
select DISTINCT  Model, Make_ID
From car_details 


-- modify old table
ALTER TABLE car_details
ADD Model_ID INT NULL

-- fill ids in original tables
update car_details
set Model_ID = MakeModels.Model_ID
FROM MakeModels
JOIN car_details
ON MakeModels.ModelName = car_details.Model and MakeModels.Make_ID = car_details.Make_ID

-- delete column
ALTER TABLE car_details
DROP Column Model

select * from car_details
select COUNT (*) from  (SELECT DISTINCT SubModelName, Model_ID FROM SubModels )RES
---------- ------------ ------------- ---------- ------------ ------------ ------------ SubModels
-- CREATE TABLE SubModels
CREATE TABLE SubModels
(
    SubModel_ID int IDENTITY(1,1) Primary Key,
    SubModelName NVARCHAR(100),
    Model_ID int
)


-- Fill SubModels
INSERT INTO SubModels
select DISTINCT  Submodel, Model_ID
From car_details 


-- modify old table
ALTER TABLE car_details
ADD Submodel_ID INT NULL

-- fill ids in original tables
update car_details
set Submodel_ID = SubModels.SubModel_ID
FROM SubModels
JOIN car_details
ON SubModels.SubModelName = car_details.Submodel and SubModels.Model_ID = car_details.Model_ID

-- delete column
ALTER table car_details
DROP column Submodel
---------- ------------ ------------- ---------- ------------ ------------ ------------ Rename main and modify
-- rename, relations

EXEC sp_rename 'car_details', 'VehicleDetails'
Exec sp_rename 'VehicleDetails.ymm_id', 'ID', 'Column'

select * 
Into BACKUP_Vehicle
From VehicleDetails


Alter table VehicleDetails
Drop Column Trim, Cylinder_Type_Name, Parts_Model, Region

Alter table VehicleDetails
Drop Column Engine_Block_Type, Engine_CID, Aspiration, KBB_MODEL


Alter Table VehicleDetails
ADD FOREIGN Key (BodyID) REFERENCES Bodies(BodyID)

Alter Table VehicleDetails
ADD FOREIGN KEY (drive_Types_ID) REFERENCES drive_Types(driveTypeID)

ALTER TABLE VehicleDetails
ADD FOREIGN KEY (Fuel_Types_ID) REFERENCES Fuel_Types(Fuel_Type_ID)

ALTER TABLE VehicleDetails
ADD FOREIGN KEY (Submodel_ID) REFERENCES SubModels(SubModel_ID)

ALTER TABLE MakeModels
ADD FOREIGN KEY (Make_ID) REFERENCES makes(make_id)

ALTER TABLE SubModels
ADD FOREIGN KEY (Model_ID) REFERENCES MakeModels(Model_ID)


