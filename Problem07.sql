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


