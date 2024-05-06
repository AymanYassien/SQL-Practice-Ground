-- ------------------------------------------------------------------------------------------- --      : no time
-- P37: Get total vehicles that have Engin_CC above average

SELECT COUNT (*) NumberOfVehiclesAboveAverageEngine_CC
FROm
(
    SELECT VehicleDetails.Vehicle_Display_Name
FROM VehicleDetails
WHERE Engine_CC >  (SELECT AvG(Engine_CC) FROM VehicleDetails)
)R1


