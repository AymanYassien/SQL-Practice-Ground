
-- ------------------------------------------------------------------------------------------- -    : -
-- P 49: Get the Lowest Manufacturers manufactured the lowest number of models

SELECT  make_name 
FROM
(

SELECT TOP 1 make_name, MAX(R1.NumberOfModels) Max
FROM 
(

select make_name, count (*) NumberOfModels
From makes join MakeModels
ON makes.make_id = MakeModels.Make_ID
GROUP BY makes.make_name

)R1

GROUP By make_name
Order By Max asc

)R2


-- ----------------                            another sol : but return name with value
SELECT        makes.make_name, COUNT(*) AS NumberOfModels
		FROM            Makes INNER JOIN
								 MakeModels ON makes.make_id = MakeModels.Make_ID
		GROUP BY makes.make_name
		having COUNT(*) = (

										select min(NumberOfModels) as MinNumberOfModels
										from
										(

												SELECT      make_id, COUNT(*) AS NumberOfModels
												FROM       
																		 MakeModels
												GROUP BY make_id
												
										) R1
        )


-- ------------------------------------------------------------------------------------------- -    : -