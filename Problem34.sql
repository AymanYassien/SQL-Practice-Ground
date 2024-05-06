-- ------------------------------------------------------------------------------------------- Meduim      : 5 MIN
-- P34: Get all vehicles that have the minimum Engine_CC

SELECT VehicleDetails.Vehicle_Display_Name
FROM VehicleDetails
WHERE Engine_CC =  (SELECT MIN(Engine_CC) FROM VehicleDetails)

