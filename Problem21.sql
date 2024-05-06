

-- ------------------------------------------------------------------------------------------- Easy      : 30 SEC
-- P21: Get Total Vehicles that number of doors is not specified

SELEct COUNT(*)
From VehicleDetails
where VehicleDetails.NumDoors LIKE 'N/A%'  

