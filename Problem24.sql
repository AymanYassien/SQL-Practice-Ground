-- ------------------------------------------------------------------------------------------- Easy      : Knowledge
-- P24: Get all vehicles that have Engines > 3 Liters and have only 2 doors

select 'it''s escaped'  -- escape chars in SQL

SELECT VehicleDetails.Engine_Liter_Display, NumDoors -- can select *;  :)
FROM VehicleDetails
WHERE VehicleDetails.Engine_Liter_Display LIKE '___%' AND NumDoors = '2'

