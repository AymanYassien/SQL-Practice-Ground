-- ------------------------------------------------------------------------------------------- Easy      : Knowledge
-- P22: Get percentage of vehicles that has no doors specified

Select 
(
    CAST( (SELEct COUNT(*) as TotalWithNoSpecifiedDoors From VehicleDetails where VehicleDetails.NumDoors LIKE 'N/A%')  as float)

    / 

    CAST((SELEct COUNT(*)From VehicleDetails as TotalWithNoSpecifiedDoors  )as float)
-- can put alias after aggregation function   ..    and also after from clause 

) Perc
 
