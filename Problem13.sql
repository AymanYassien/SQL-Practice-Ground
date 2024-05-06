-- ------------------------------------------------------------------------------------------- Easy      : 30 sec
-- P13: Get all Makes/Count Of Vehicles that manufactures more than 20K Vehicles
SELECT              makes.make_name, COUNT(VehicleDetails.Make_id)   NumberOfVehicles 
FROM                        VehicleDetails JOIN
                            makes ON VehicleDetails.Make_id = makes.make_id
GROUP BY make_name
HAVING COUNT(VehicleDetails.Make_id) > 20000
ORDER BY NumberOfVehicles Desc

