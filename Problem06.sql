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

