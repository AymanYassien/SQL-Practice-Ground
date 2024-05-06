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

