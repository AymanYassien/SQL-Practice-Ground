-- ------------------------------------------------------------------------------------------- Easy      : 10 MIN
-- P10: Get all Makes that runs with GAS

Select              Distinct makes.make_name, Fuel_Types.Fuel_Type_name
From                makes JOIN
                    VehicleDetails   ON VehicleDetails.Make_id = makes.make_id JOIN 
                    Fuel_Types       ON VehicleDetails.Fuel_Types_ID = Fuel_Types.Fuel_Type_ID
                    
Where Fuel_Types.Fuel_Type_name = 'GAS'
ORDER BY makes.make_name

