-- ------------------------------------------------------------------------------------------- Easy      : 2 MIN
-- P28: Get all vehicles that their Body is 'Coupe' or 'Hatchback' or 'Sedan'
SELECT                   Bodies.BodyName, VehicleDetails.*
FROM                           VehicleDetails JOIN
                                    Bodies ON VehicleDetails.BodyID = Bodies.BodyID
WHERE BodyName IN ('Hatchback', 'Coupe', 'Sedan') 

