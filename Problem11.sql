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

