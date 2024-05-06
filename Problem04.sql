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
