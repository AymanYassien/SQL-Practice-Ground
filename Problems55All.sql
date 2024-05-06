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

-- ------------------------------------------------------------------------------------------- Easy
-- P2: Get all vehicles made between 1950 and 2000 order asc

Select * 
FROM MasterView 
Where [Year] BETWEEN 1950 and 2000
Order by [Year]

-- ------------------------------------------------------------------------------------------- Easy
-- P3: Get Number vehicles made between 1950 and 2000 

select  Number_of_VehiclesBetween1950_and_2000  = COUNT(ID) 
FROM MasterView 
Where [Year] BETWEEN 1950 and 2000 

-- ------------------------------------------------------------------------------------------- Maduim    : Hint
-- P4 : Get number vehicles made between 1950 and 2000 per make,  
-- and order them by Number Of Vehicles Descending
-- Hint : Group by             
-- use table not view :)

SELECT              Make = makes.make_name , Number_of_Vehicles = COUNT(VehicleDetails.ID) 
FROM                    VehicleDetails INNER JOIN 
                            makes on VehicleDetails.Make_ID = makes.make_id
Where           (VehicleDetails.[Year] BETWEEN 1950 and 2000)
GROUP BY makes.make_name
ORDER BY Number_of_Vehicles DESC
-- ------------------------------------------------------------------------------------------- Easy            : Tricky way here
-- P5: Get All Makes that have manufactured more than 12000 Vehicles in years 1950 to 2000

-- Notes: Having is on result, Where is on data .. in other word

Select                                makes.make_name as Make, Count (*) as Number_of_Vehicles
FROM                                        VehicleDetails INNER JOIN makes
                                                   ON makes.make_id = VehicleDetails.Make_id
WHERE VehicleDetails.[Year] BETWEEN 1950 and 2000
GROUP BY makes.make_name
HAVING COUNT(*) > 12000
ORDER BY Number_of_Vehicles DESC

--     without Having
SELECT * FROM 
(
    
Select                                makes.make_name as Make, Count (*) as Number_of_Vehicles
FROM                                        VehicleDetails INNER JOIN makes
                                                   ON makes.make_id = VehicleDetails.Make_id
WHERE VehicleDetails.[Year] BETWEEN 1950 and 2000
GROUP BY makes.make_name
-- ORDER BY Number_of_Vehicles DESC 
-- No order by in sub query

) v1
Where v1.Number_of_Vehicles > 12000
ORDER BY Number_of_Vehicles DESC

-- ------------------------------------------------------------------------------------------- Hard          : Gold
-- P6: Get number of vehicles made between 1950 and 2000 per make
-- and add total vehicles column beside

-- my sol                          : add total number of cars per maker
Select R1.Make, R1.Number_of_Vehicles, COUNT(*) as Total_Number
From
(
SELECT ID = makes.make_id, Make = makes.make_name, COUNT(VehicleDetails.ID)as Number_of_Vehicles
FROM makes INNER JOIN VehicleDetails
on makes.make_id = VehicleDetails.Make_id
WHERE VehicleDetails.[Year] BETWEEN 1950 and 2000
GROUP by makes.make_id, makes.make_name
)R1
JOIN VehicleDetails
ON R1.ID = VehicleDetails.Make_id
GROUP BY R1.Make, R1.Number_of_Vehicles
ORDER BY Number_of_Vehicles DESC

select  Count (*)FROM VehicleDetails
where VehicleDetails.Make_id = 1147 -- ford cars, to ensure res



-- Programming Advices sol         : just add total of all to each row :(
SELECT              Make = makes.make_name , Number_of_Vehicles = COUNT(VehicleDetails.ID), (Select COUNT(*) From VehicleDetails)as Total
FROM                    VehicleDetails INNER JOIN 
                            makes on VehicleDetails.Make_ID = makes.make_id
Where           (VehicleDetails.[Year] BETWEEN 1950 and 2000)
GROUP BY makes.make_name
ORDER BY Number_of_Vehicles DESC

-- ------------------------------------------------------------------------------------------- Easy          : Knowledge
-- P7: Get number of vehicles made between 1950 and 2000 per make
--  and add total vehicles column beside it,
--  then calculate it's percentage

-- CAST from int to float
SELECT *, CAST(Number_of_Vehicles as float) / CAST(Total as float) Perc
FROM
(

SELECT              Make = makes.make_name , Number_of_Vehicles = COUNT(VehicleDetails.ID), (Select COUNT(*) From VehicleDetails)as Total
FROM                    VehicleDetails INNER JOIN 
                            makes on VehicleDetails.Make_ID = makes.make_id
Where           (VehicleDetails.[Year] BETWEEN 1950 and 2000)
GROUP BY makes.make_name

)T1
ORDER BY Number_of_Vehicles DESC 


-- ------------------------------------------------------------------------------------------- Meduim          : Tricky
-- P8: Get Make, FuelTypeName and Number of Vehicles per FuelType per Make
-- steps to solve:
/*
    -- get all maker name/ vehicle row => join vehicle with makes table
    -- get all fuel type / vehicle row => join vehicle with Fuel_Type table
    -- compine last 2 tables
    -- 
    -- count * grouping by make and fuel 
    -- compine last 2 results
*/
Select Distinct T1.Make, Fuel_Type_name as FuelTypeName
From Fuel_Types
JOIN
(Select makes.make_name as Make, VehicleDetails.Fuel_Types_ID
From makes
JOIN VehicleDetails
On makes.make_id = VehicleDetails.Make_id
)T1
On Fuel_Types.Fuel_Type_ID = T1.Fuel_Types_ID
ORDER BY T1.Make, Fuel_Types.Fuel_Type_name
----------- step 1 above
Select Count(*)
From VehicleDetails
GROUP BY Fuel_Types_ID, Make_id
------------ step 2 above
select sum(CAST (g.Number_of_Vehicles as decimal)) from  (Select vt.Make, vt.FuelTypeName, Count(*) as Number_of_Vehicles
From VehicleDetails
JOIN
(Select T1.Make, Fuel_Type_name as FuelTypeName, Fuel_Types.Fuel_Type_ID, T1.make_id
From Fuel_Types
JOIN
(Select makes.make_name as Make, VehicleDetails.Fuel_Types_ID, makes.make_id
From makes
JOIN VehicleDetails
On makes.make_id = VehicleDetails.Make_id
)T1
On Fuel_Types.Fuel_Type_ID = T1.Fuel_Types_ID
)vt
on ((VehicleDetails.Fuel_Types_ID = vt.Fuel_Type_ID)  AND (VehicleDetails.Make_id = vt.make_id))
GROUP BY vt.Make, vt.FuelTypeName)g
ORDER BY vt.Make, vt.FuelTypeName

------------------------------------------Gold sol, this is true but my one is false

Select sum(b.Total)
from 
(Select makes.make_name, Fuel_Types.Fuel_Type_name, COUNT(*) as Total
From VehicleDetails inner JOIN 
                    makes      On   makes.make_id            = VehicleDetails.Make_id inner JOIN
                    Fuel_Types ON    Fuel_Types.Fuel_Type_ID = VehicleDetails.Fuel_Types_ID
GROUP BY makes.make_name, Fuel_Types.Fuel_Type_name)b
ORDER BY make_name, Fuel_Type_name 

-- ------------------------------------------------------------------------------------------- Easy
-- P9: Get all vehicles that runs with GAS

Select Fuel_Types.Fuel_Type_name, VehicleDetails.* From  Fuel_Types
join VehicleDetails
ON VehicleDetails.Fuel_Types_ID = Fuel_Types.Fuel_Type_ID
WHERE Fuel_Type_name = N'GAS'  -- N for unicode 

-- ------------------------------------------------------------------------------------------- Easy      : 10 MIN
-- P10: Get all Makes that runs with GAS

Select              Distinct makes.make_name, Fuel_Types.Fuel_Type_name
From                makes JOIN
                    VehicleDetails   ON VehicleDetails.Make_id = makes.make_id JOIN 
                    Fuel_Types       ON VehicleDetails.Fuel_Types_ID = Fuel_Types.Fuel_Type_ID
                    
Where Fuel_Types.Fuel_Type_name = 'GAS'
ORDER BY makes.make_name

-- ------------------------------------------------------------------------------------------- Easy      : 1 MIN
-- P11: Get Total Makes that runs with GAS
SELECT Count (make_name) Total_Gas_maker
FROM 
(
    Select              Distinct makes.make_name, Fuel_Types.Fuel_Type_name
From                makes JOIN
                    VehicleDetails   ON VehicleDetails.Make_id = makes.make_id JOIN 
                    Fuel_Types       ON VehicleDetails.Fuel_Types_ID = Fuel_Types.Fuel_Type_ID
                    
Where Fuel_Types.Fuel_Type_name = 'GAS'
)R1

-- ------------------------------------------------------------------------------------------- Easy      : 5 MIN
-- P12: Count Vehicles by make,
-- and order them by NumberOfVehicles from high to low.

SELECT              makes.make_name, COUNT(VehicleDetails.Make_id)   NumberOfVehicles 
FROM                        VehicleDetails JOIN
                            makes ON VehicleDetails.Make_id = makes.make_id
GROUP BY make_name
ORDER BY NumberOfVehicles Desc

-- ------------------------------------------------------------------------------------------- Easy      : 30 sec
-- P13: Get all Makes/Count Of Vehicles that manufactures more than 20K Vehicles
SELECT              makes.make_name, COUNT(VehicleDetails.Make_id)   NumberOfVehicles 
FROM                        VehicleDetails JOIN
                            makes ON VehicleDetails.Make_id = makes.make_id
GROUP BY make_name
HAVING COUNT(VehicleDetails.Make_id) > 20000
ORDER BY NumberOfVehicles Desc

-- ------------------------------------------------------------------------------------------- Easy      : 1 MIN
-- P14: Write a query to get all Makes with make starts with 'B'.

Select makes.make_name
FROM makes
where make_name LIKE 'B%'

-- ------------------------------------------------------------------------------------------- Easy      : 1 MIN
-- P15:  Write a query to get all Makes with make ends with 'W'.

SELECT makes.make_name 
FROM makes
Where make_name Like '%W'

-- ------------------------------------------------------------------------------------------- Easy      : 3 MIN
-- P16: Get all Makes that manufactures DriveTypeName = FWD

SELECT           Distinct makes.make_name 
FROM                        makes JOIN 
                               VehicleDetails ON VehicleDetails.Make_id = makes.make_id Inner JOIN
                                 drive_Types ON VehicleDetails.drive_Types_ID = drive_Types.driveTypeID
where drive_Types.driveTypeName = 'FWD'

-- ------------------------------------------------------------------------------------------- Easy      : 1 MIN
-- P17: Get total Makes that Mantufactures DriveTypeName=FWD

SELECT Count (make_name)
FROM
(SELECT           Distinct makes.make_name 
FROM                        makes JOIN 
                               VehicleDetails ON VehicleDetails.Make_id = makes.make_id Inner JOIN
                                 drive_Types ON VehicleDetails.drive_Types_ID = drive_Types.driveTypeID
where drive_Types.driveTypeName = 'FWD')R1

-- ------------------------------------------------------------------------------------------- Easy      : 7 MIN
-- P18: Get total vehicles per DriveTypeName Per Make 
-- and order them per make asc then per total Desc

SELECT                   makes.make_name, drive_Types.driveTypeName, COUNt (*) as Total
FROM                        drive_Types JOIN  -- try  swap tables
                                 VehicleDetails ON  VehicleDetails.drive_Types_ID = drive_Types.driveTypeID JOIN 
                                   makes ON makes.make_id = VehicleDetails.Make_id
GROUP By makes.make_name, drive_Types.driveTypeName
ORDER BY make_name asc, Total DESC

-- ------------------------------------------------------------------------------------------- Easy      : 1 MIN
-- P19: Get total vehicles per DriveTypeName Per Make
-- then filter only results with total > 10,000

SELECT                   makes.make_name, drive_Types.driveTypeName, COUNt (*) as Total
FROM                        drive_Types JOIN  -- try  swap tables
                                 VehicleDetails ON  VehicleDetails.drive_Types_ID = drive_Types.driveTypeID JOIN 
                                   makes ON makes.make_id = VehicleDetails.Make_id
GROUP By makes.make_name, drive_Types.driveTypeName
HAVING COUNt (*) > 10000
ORDER BY make_name asc, Total DESC

-- ------------------------------------------------------------------------------------------- Easy      : 2 MIN
-- P20: Get Get all Vehicles that number of doors is not specified

Select * 
From VehicleDetails
where VehicleDetails.NumDoors LIKE 'N/A%'  
-- the correct is 'is null' but we do not modify it when restore database 


-- ------------------------------------------------------------------------------------------- Easy      : 30 SEC
-- P21: Get Total Vehicles that number of doors is not specified

SELEct COUNT(*)
From VehicleDetails
where VehicleDetails.NumDoors LIKE 'N/A%'  

-- ------------------------------------------------------------------------------------------- Easy      : Knowledge
-- P22: Get percentage of vehicles that has no doors specified

Select 
(
    CAST( (SELEct COUNT(*) as TotalWithNoSpecifiedDoors From VehicleDetails where VehicleDetails.NumDoors LIKE 'N/A%')  as float)

    / 

    CAST((SELEct COUNT(*)From VehicleDetails as TotalWithNoSpecifiedDoors  )as float)
-- can put alias after aggregation function   ..    and also after from clause 

) Perc
 
-- ------------------------------------------------------------------------------------------- Easy      : Knowledge
-- P23: Get MakeID , Make, SubModelName for all vehicles that have SubModelName 'Elite'

SELECT                  Distinct VehicleDetails.Make_id, makes.make_name, SubModels.SubModelName 
FROM                        VehicleDetails JOIN 
                                SubModels ON SubModels.SubModel_ID = VehicleDetails.Submodel_ID JOIN
                                   makes ON VehicleDetails.Make_id = makes.make_id
WHERE SubModels.SubModelName  = 'Elite'

-- ------------------------------------------------------------------------------------------- Easy      : Knowledge
-- P24: Get all vehicles that have Engines > 3 Liters and have only 2 doors

select 'it''s escaped'  -- escape chars in SQL

SELECT VehicleDetails.Engine_Liter_Display, NumDoors -- can select *;  :)
FROM VehicleDetails
WHERE VehicleDetails.Engine_Liter_Display LIKE '___%' AND NumDoors = '2'

-- ------------------------------------------------------------------------------------------- Easy      : 5 min
-- P25: Get make and vehicles that the engine contains 'OHV' and have Cylinders = 4

Select                   makes.make_name, VehicleDetails.* 
FROM                        VehicleDetails JOIN
                                makes ON VehicleDetails.Make_id = makes.make_id
Where   VehicleDetails.Engine like '%OHV%' and Engine_Cylinders = '4'

-- ------------------------------------------------------------------------------------------- Easy      : 4 MIN
-- P26: Get all vehicles that their body is 'Sport Utility' and Year > 2020

SELECT                   Bodies.BodyName, VehicleDetails.[Year], VehicleDetails.*
FROM                           VehicleDetails JOIN
                                    Bodies ON VehicleDetails.BodyID = Bodies.BodyID
WHERE BodyName = 'Sport Utility' AND [VehicleDetails].[Year] > 2020


-- ------------------------------------------------------------------------------------------- Easy      : 2 MIN
-- P27: Get all vehicles that their Body is 'Coupe' or 'Hatchback' or 'Sedan'
SELECT                   Bodies.BodyName, VehicleDetails.*
FROM                           VehicleDetails JOIN
                                    Bodies ON VehicleDetails.BodyID = Bodies.BodyID
WHERE BodyName IN ('Hatchback', 'Coupe', 'Sedan') 


-- ------------------------------------------------------------------------------------------- Easy      : 2 MIN
-- P28: Get all vehicles that their Body is 'Coupe' or 'Hatchback' or 'Sedan'
SELECT                   Bodies.BodyName, VehicleDetails.*
FROM                           VehicleDetails JOIN
                                    Bodies ON VehicleDetails.BodyID = Bodies.BodyID
WHERE BodyName IN ('Hatchback', 'Coupe', 'Sedan') 

-- ------------------------------------------------------------------------------------------- Easy      : optimized sol
-- P29: Return found=1 if there is any vehicle made in year 1950

SELECT  Found = 
case

When R1 > 0 THEN 1
Else 0

END 

FROM 
(select count(VehicleDetails.[Year]) R1
FROM VehicleDetails
WHERE VehicleDetails.[Year] = 1950)R2

-- ------------- ------------------        optimized one 
select Found = 1
where 
exists
(
    select top 1*  from VehicleDetails where VehicleDetails.[Year] = 1950 
)

-- ------------------------------------------------------------------------------------------- Easy      : Nice 
-- P30: Get all Vehicle_Display_Name, NumDoors and add extra column to describe number of doors by words,
-- and if door is null display 'Not Set'

-- select Distinct NumDoors
-- FROM VehicleDetails
-- -- 0, 1, 2, 3, ,4, ,5 ,6, ,8, NULL


select VehicleDetails.Vehicle_Display_Name, VehicleDetails.NumDoors, DescripeNumber = 
CASE 
    When NumDoors = '0' THEN 'Zero Door'
    When NumDoors = '1' THEN 'ONE Door'
    When NumDoors = '2' THEN 'Two Doors'
    When NumDoors = '2' THEN 'Two Doors'
    When NumDoors = '3' THEN 'Three Doors'
    When NumDoors = '4' THEN 'Four Doors'
    When NumDoors = '5' THEN 'Five Doors'
    When NumDoors = '6' THEN 'SIX Doors'
    When NumDoors = '8' THEN 'Eight Doors'
    else 'Not Set'
END 

FROM VehicleDetails

-- ------------------------------------------------------------------------------------------- Easy      : Knowledge 
-- P31: Get all Vehicle_Display_Name, year 
-- and add extra column to calculate the age of the car then sort the results by age desc.

SELECT VehicleDetails.Vehicle_Display_Name, VehicleDetails.[Year], 'age of the Car' =  YEAR(GETDATE()) - VehicleDetails.[Year]
FROM VehicleDetails
ORDER BY 'age of the Car' DESC

-- ------------------------------------------------------------------------------------------- Easy      : 3 MIN 
-- P32: Get all Vehicle_Display_Name, year, Age for vehicles that their age
-- between 15 and 25 years old

SELECT *
FROM 
(
    SELECT VehicleDetails.Vehicle_Display_Name, VehicleDetails.[Year], 'age of the Car' =  YEAR(GETDATE()) - VehicleDetails.[Year] 
    FROM VehicleDetails
)R1
WHere R1.[age of the Car] BETWEEN 15 AND 25
-- ORDER BY 'age of the Car' DESC

-- ------------------------------------------------------------------------------------------- Easy      : update table
-- P33: Get Minimum Engine CC , Maximum Engine CC , and Average Engine CC of all Vehicles


SELECT MAX(VehicleDetails.Engine_CC) MAX, MIN (VehicleDetails.Engine_CC) MIN, AVG(VehicleDetails.Engine_CC) AVG
FROM VehicleDetails
-- -----------
update VehicleDetails
SET Engine_CC = NULL
where Engine_CC = 'N/A'
-- ------------
Alter Table VehicleDetails
Alter Column Engine_CC INT
-- ---------------

-- ------------------------------------------------------------------------------------------- Meduim      : 5 MIN
-- P34: Get all vehicles that have the minimum Engine_CC

SELECT VehicleDetails.Vehicle_Display_Name
FROM VehicleDetails
WHERE Engine_CC =  (SELECT MIN(Engine_CC) FROM VehicleDetails)

-- ------------------------------------------------------------------------------------------- --      : no time
-- P34: Get all vehicles that have the Maximum Engine_CC

SELECT VehicleDetails.Vehicle_Display_Name
FROM VehicleDetails
WHERE Engine_CC =  (SELECT MAX(Engine_CC) FROM VehicleDetails)

-- ------------------------------------------------------------------------------------------- --      : no time
-- P36: Get all vehicles that have Engin_CC below average

SELECT VehicleDetails.Vehicle_Display_Name
FROM VehicleDetails
WHERE Engine_CC <  (SELECT AvG(Engine_CC) FROM VehicleDetails)


-- ------------------------------------------------------------------------------------------- --      : no time
-- P37: Get total vehicles that have Engin_CC above average

SELECT COUNT (*) NumberOfVehiclesAboveAverageEngine_CC
FROm
(
    SELECT VehicleDetails.Vehicle_Display_Name
FROM VehicleDetails
WHERE Engine_CC >  (SELECT AvG(Engine_CC) FROM VehicleDetails)
)R1


-- ------------------------------------------------------------------------------------------- Easy      : no time
-- P38: Get all unique Engin_CC and sort them Desc

SELECT Distinct VehicleDetails.Engine_CC
FROM VehicleDetails
ORDER BY Engine_CC DESC

-- ------------------------------------------------------------------------------------------- Easy      : no time
-- P39:  Get the maximum 3 Engine CC

SELECT Distinct TOP 3 VehicleDetails.Engine_CC
FROM VehicleDetails
ORDER BY Engine_CC DESC
-- ------------------------------------------------------------------------------------------- Easy      : Notice 
-- P40 : Get all vehicles that has one of the Max 3 Engine CC

-- retrieve top 3 values 
-- then nretrieve all rows has  one of thoose values

SELECT VehicleDetails.Vehicle_Display_Name FROM VehicleDetails
Where Engine_CC IN
(
    SELECT Distinct TOP 3 VehicleDetails.Engine_CC FROM VehicleDetails
    ORDER BY Engine_CC DESC
)

-- ------------------------------------------------------------------------------------------- Easy      
-- P41: Get all Makes that manufactures one of the Max 3 Engine CC

SELECT             Distinct makes.make_name 
FROM                   makes JOIN 
                         VehicleDetails ON VehicleDetails.Make_id = makes.make_id
                         WHERE Engine_CC IN
(
    SELECT Distinct TOP 3 VehicleDetails.Engine_CC FROM VehicleDetails
    -- ORDER BY Engine_CC DESC
)
ORDER BY make_name 


-- ------------------------------------------------------------------------------------------- Easy      
-- P42: Get a table of unique Engine_CC and calculate tax per Engine CC as follows:
	-- 0 to 1000    Tax = 100
	-- 1001 to 2000 Tax = 200
	-- 2001 to 4000 Tax = 300
	-- 4001 to 6000 Tax = 400
	-- 6001 to 8000 Tax = 500
	-- Above 8000   Tax = 600
	-- Otherwise    Tax = 0


-- WHEN not where 
SELECT  * , TAX = 
CASE 
    WHEN Engine_CC Between 0    AND 1000  THEN 100
    WHEN Engine_CC Between 1001 AND 2000  THEN 200
    WHEN Engine_CC Between 2001 AND 4000  THEN 300
    WHEN Engine_CC Between 4001 AND 6000  THEN 400
    WHEN Engine_CC Between 6001 AND 8000  THEN 500
    WHEN Engine_CC >       8000           THEN 600 
    ELSE                                        0  
END

FROM 
(
    SELECT Distinct  Engine_CC FROM VehicleDetails
)R1

order by Engine_CC DESC


-- ------------------------------------------------------------------------------------------- Easy    : MODIFY COL  
-- P43: Get Make and Total Number Of Doors Manufactured Per Make

select                    makes.make_name, SUM(NumDoors) TotalNmber_of_Doors
From                         VehicleDetails Join 
                                    makes ON VehicleDetails.Make_id = makes.make_id
GROUP BY makes.make_name
Order by COUNT(NumDoors) DESC


-- ---------
UPDATE VehicleDetails
SET   NumDoors = NULL  
WHERE NumDoors = 'N/A'
-- ----------------
ALTER TABLE VehicleDetails
ALTER COLUMN NumDoors INT NULL

-- ------------------------------------------------------------------------------------------- Easy    : - 
-- P44: Get Total Number Of Doors Manufactured by 'Ford'

select                    makes.make_name, SUM(NumDoors) TotalNmber_of_Doors
From                         VehicleDetails Join 
                                    makes ON VehicleDetails.Make_id = makes.make_id

Where make_name = 'Ford'
GROUP BY makes.make_name
Order by COUNT(NumDoors) DESC

-- ------------------------------------------------------------------------------------------- Easy    : - 
-- P45: Get Number of Models Per Make

select makes.make_name, count (*) NumberOfModels
From makes join MakeModels
ON makes.make_id = MakeModels.Make_ID
GROUP BY makes.make_name
Order By NumberOfModels Desc

-- ------------------------------------------------------------------------------------------- Easy    : - 
-- P46: Get the highest 3 manufacturers that make the highest number of models

select Top 3 makes.make_name, count (*) NumberOfModels
From makes join MakeModels
ON makes.make_id = MakeModels.Make_ID
GROUP BY makes.make_name
Order By NumberOfModels Desc

-- ------------------------------------------------------------------------------------------- Easy    : - 
-- P47: Get the highest number of models manufactured

SELECT MAX(NumberOfModels) FROM 
(select makes.make_name, count (*) NumberOfModels
From makes join MakeModels
ON makes.make_id = MakeModels.Make_ID
GROUP BY makes.make_name)R1

-- ------------------------------------------------------------------------------------------- Meduim    : another sol
-- P48: Get the highest Manufacturers manufactured the highest number of models

-- get number of models / maker 
-- get top one 
-- return his name

SELECT  make_name 
FROM
(

SELECT TOP 1 make_name, MAX(R1.NumberOfModels) Max
FROM 
(

select make_name, count (*) NumberOfModels
From makes join MakeModels
ON makes.make_id = MakeModels.Make_ID
GROUP BY makes.make_name

)R1

GROUP By make_name
Order By Max Desc

)R2

-- ----------------                            another sol : but return name with value
SELECT        makes.make_name, COUNT(*) AS NumberOfModels
		FROM            Makes INNER JOIN
								 MakeModels ON makes.make_id = MakeModels.Make_ID
		GROUP BY makes.make_name
		having COUNT(*) = (

										select Max(NumberOfModels) as MaxNumberOfModels
										from
										(

												SELECT      make_id, COUNT(*) AS NumberOfModels
												FROM       
																		 MakeModels
												GROUP BY make_id
												
										) R1
        )


-- ------------------------------------------------------------------------------------------- -    : -
-- P 49: Get the Lowest Manufacturers manufactured the lowest number of models

SELECT  make_name 
FROM
(

SELECT TOP 1 make_name, MAX(R1.NumberOfModels) Max
FROM 
(

select make_name, count (*) NumberOfModels
From makes join MakeModels
ON makes.make_id = MakeModels.Make_ID
GROUP BY makes.make_name

)R1

GROUP By make_name
Order By Max asc

)R2


-- ----------------                            another sol : but return name with value
SELECT        makes.make_name, COUNT(*) AS NumberOfModels
		FROM            Makes INNER JOIN
								 MakeModels ON makes.make_id = MakeModels.Make_ID
		GROUP BY makes.make_name
		having COUNT(*) = (

										select min(NumberOfModels) as MinNumberOfModels
										from
										(

												SELECT      make_id, COUNT(*) AS NumberOfModels
												FROM       
																		 MakeModels
												GROUP BY make_id
												
										) R1
        )


-- ------------------------------------------------------------------------------------------- -    : -
-- P 50:  Get all Fuel Types , each time the result should be showed in random order  

SELECT * FROM Fuel_Types
Order by NEWID()


SELECT Fuel_Type_ID FROM Fuel_Types
Order by NEWID()



--------------------------------------------------------------- the emoployee

1-- 
-- SELECT        Employees.Name, Employees.ManagerID, Employees.Salary, Managers.Name AS ManagerName
-- FROM            Employees INNER JOIN
--                          Employees AS Managers ON Employees.ManagerID = Managers.EmployeeID

2-  
-- --Get all employees that have manager or does not have manager along with Manager's name, incase no manager name show null
-- -- this will select all data from employees regardless if they have manager or not, note here we used left outer join 
-- SELECT        Employees.Name, Employees.ManagerID, Employees.Salary, Managers.Name AS ManagerName
-- FROM            Employees Left JOIN
--                          Employees AS Managers ON Employees.ManagerID = Managers.EmployeeID

3-- 





