-- ------------------------------------------------------------------------------------------- --      : no time
-- P36: Get all vehicles that have Engin_CC below average

SELECT VehicleDetails.Vehicle_Display_Name
FROM VehicleDetails
WHERE Engine_CC <  (SELECT AvG(Engine_CC) FROM VehicleDetails)


