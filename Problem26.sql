-- ------------------------------------------------------------------------------------------- Easy      : 4 MIN
-- P26: Get all vehicles that their body is 'Sport Utility' and Year > 2020

SELECT                   Bodies.BodyName, VehicleDetails.[Year], VehicleDetails.*
FROM                           VehicleDetails JOIN
                                    Bodies ON VehicleDetails.BodyID = Bodies.BodyID
WHERE BodyName = 'Sport Utility' AND [VehicleDetails].[Year] > 2020


