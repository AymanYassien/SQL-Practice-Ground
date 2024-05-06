-- ------------------------------------------------------------------------------------------- Easy
-- P9: Get all vehicles that runs with GAS

Select Fuel_Types.Fuel_Type_name, VehicleDetails.* From  Fuel_Types
join VehicleDetails
ON VehicleDetails.Fuel_Types_ID = Fuel_Types.Fuel_Type_ID
WHERE Fuel_Type_name = N'GAS'  -- N for unicode 

