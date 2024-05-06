-- ------------------------------------------------------------------------------------------- Easy
-- P3: Get Number vehicles made between 1950 and 2000 

select  Number_of_VehiclesBetween1950_and_2000  = COUNT(ID) 
FROM MasterView 
Where [Year] BETWEEN 1950 and 2000 

