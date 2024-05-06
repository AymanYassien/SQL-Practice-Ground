

-- ------------------------------------------------------------------------------------------- Easy      : Knowledge 
-- P31: Get all Vehicle_Display_Name, year 
-- and add extra column to calculate the age of the car then sort the results by age desc.

SELECT VehicleDetails.Vehicle_Display_Name, VehicleDetails.[Year], 'age of the Car' =  YEAR(GETDATE()) - VehicleDetails.[Year]
FROM VehicleDetails
ORDER BY 'age of the Car' DESC

