-- ------------------------------------------------------------------------------------------- Easy      : 3 MIN 
-- P32: Get all Vehicle_Display_Name, year, Age for vehicles that their age
-- between 15 and 25 years old

SELECT *
FROM 
(
    SELECT VehicleDetails.Vehicle_Display_Name, VehicleDetails.[Year], 'age of the Car' =  YEAR(GETDATE()) - VehicleDetails.[Year] 
    FROM VehicleDetails
)R1
WHere R1.[age of the Car] BETWEEN 15 AND 25
-- ORDER BY 'age of the Car' DESC

