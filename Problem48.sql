
-- ------------------------------------------------------------------------------------------- Meduim    : another sol
-- P48: Get the highest Manufacturers manufactured the highest number of models

-- get number of models / maker 
-- get top one 
-- return his name

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
Order By Max Desc

)R2

-- ----------------                            another sol : but return name with value
SELECT        makes.make_name, COUNT(*) AS NumberOfModels
		FROM            Makes INNER JOIN
								 MakeModels ON makes.make_id = MakeModels.Make_ID
		GROUP BY makes.make_name
		having COUNT(*) = (

										select Max(NumberOfModels) as MaxNumberOfModels
										from
										(

												SELECT      make_id, COUNT(*) AS NumberOfModels
												FROM       
																		 MakeModels
												GROUP BY make_id
												
										) R1
        )

