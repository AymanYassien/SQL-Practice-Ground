-- ------------------------------------------------------------------------------------------- Easy      : 2 MIN
-- P20: Get Get all Vehicles that number of doors is not specified

Select * 
From VehicleDetails
where VehicleDetails.NumDoors LIKE 'N/A%'  
-- the correct is 'is null' but we do not modify it when restore database 


