
-- ------------------------------------------------------------------------------------------- Easy    : - 
-- P45: Get Number of Models Per Make

select makes.make_name, count (*) NumberOfModels
From makes join MakeModels
ON makes.make_id = MakeModels.Make_ID
GROUP BY makes.make_name
Order By NumberOfModels Desc