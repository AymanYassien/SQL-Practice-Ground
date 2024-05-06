-- ------------------------------------------------------------------------------------------- Easy      : 5 min
-- P25: Get make and vehicles that the engine contains 'OHV' and have Cylinders = 4

Select                   makes.make_name, VehicleDetails.* 
FROM                        VehicleDetails JOIN
                                makes ON VehicleDetails.Make_id = makes.make_id
Where   VehicleDetails.Engine like '%OHV%' and Engine_Cylinders = '4'

