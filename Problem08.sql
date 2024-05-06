- ------------------------------------------------------------------------------------------- Meduim          : Tricky
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

