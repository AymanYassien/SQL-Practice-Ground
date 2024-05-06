
-- ------------------------------------------------------------------------------------------- Easy    : - 
-- P47: Get the highest number of models manufactured

SELECT MAX(NumberOfModels) FROM 
(select makes.make_name, count (*) NumberOfModels
From makes join MakeModels
ON makes.make_id = MakeModels.Make_ID
GROUP BY makes.make_name)R1
