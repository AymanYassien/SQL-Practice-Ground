-- ------------------------------------------------------------------------------------------- Easy    : - 
-- P44: Get Total Number Of Doors Manufactured by 'Ford'

select                    makes.make_name, SUM(NumDoors) TotalNmber_of_Doors
From                         VehicleDetails Join 
                                    makes ON VehicleDetails.Make_id = makes.make_id

Where make_name = 'Ford'
GROUP BY makes.make_name
Order by COUNT(NumDoors) DESC
