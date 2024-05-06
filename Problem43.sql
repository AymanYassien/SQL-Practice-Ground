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

