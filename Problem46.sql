

-- ------------------------------------------------------------------------------------------- Easy    : - 
-- P46: Get the highest 3 manufacturers that make the highest number of models

select Top 3 makes.make_name, count (*) NumberOfModels
From makes join MakeModels
ON makes.make_id = MakeModels.Make_ID
GROUP BY makes.make_name
Order By NumberOfModels Desc
