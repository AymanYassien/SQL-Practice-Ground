-- Querie's File                           ||   21 - 04 - 24   ||
-- Tips: shuffle Queries to maximize Level of problem from easy to hard
------------------------------------------------------------------------------- Meduim

-- P1: Create master viwe (in vehicle table: any col name  %ID => compine it with its name || Ex: fuel_ID => Fuel_name)
-- Tips: *col from table one + just one from 2 , rearrange col 

create VIEW MasterView as 

SELECT 
-- v5.*, SubModels.SubModelName || just to rearrange
ID, [Year], Vehicle_Display_Name, Engine, Engine_CC, Engine_Cylinders, Engine_Liter_Display,                  
NumDoors, Make_id, make_name, Fuel_Types_ID, Fuel_Type_name, drive_Types_ID, driveTypeName,
BodyID, BodyName, v5.Model_ID, ModelName,v5.Submodel_ID, SubModels.SubModelName
FROM 

(SELECT v4.*, MakeModels.ModelName 
FROM 

(
SELECT v3.*, Bodies.BodyName 
FROM

(
SELECT  v2.*, drive_Types.driveTypeName 
FROM 

(
SELECT v1.*, Fuel_Types.Fuel_Type_name  
FROM 

( 
Select VehicleDetails.*, makes.make_name
From VehicleDetails

JOIN makes
ON VehicleDetails.Make_id = makes.make_id
)
as v1

JOIN Fuel_Types
ON v1.Fuel_Types_ID = Fuel_Types.Fuel_Type_ID
)
v2

JOIN drive_Types
ON v2.drive_Types_ID = drive_Types.driveTypeID
)
v3

Join Bodies
ON v3.BodyID = Bodies.BodyID
)
as v4

JOIN MakeModels
ON v4.Model_ID = MakeModels.Model_ID_PK
)
v5

JOIN SubModels
ON v5.Submodel_ID = SubModels.SubModel_ID

GO; -- view must be one in the batch
-- select * fRom MasterView

