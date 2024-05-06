-- ------------------------------------------------------------------------------------------- --      : no time
-- P35: Get all vehicles that have the Maximum Engine_CC

SELECT VehicleDetails.Vehicle_Display_Name
FROM VehicleDetails
WHERE Engine_CC =  (SELECT MAX(Engine_CC) FROM VehicleDetails)

