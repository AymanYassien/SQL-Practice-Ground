-- ------------------------------------------------------------------------------------------- Easy      : 5 MIN
-- P12: Count Vehicles by make,
-- and order them by NumberOfVehicles from high to low.

SELECT              makes.make_name, COUNT(VehicleDetails.Make_id)   NumberOfVehicles 
FROM                        VehicleDetails JOIN
                            makes ON VehicleDetails.Make_id = makes.make_id
GROUP BY make_name
ORDER BY NumberOfVehicles Desc

-- ------------------------------------------------------------------------------------------- Easy      : 30 sec