-- ------------------------------------------------------------------------------------------- Easy      : Knowledge
-- P23: Get MakeID , Make, SubModelName for all vehicles that have SubModelName 'Elite'

SELECT                  Distinct VehicleDetails.Make_id, makes.make_name, SubModels.SubModelName 
FROM                        VehicleDetails JOIN 
                                SubModels ON SubModels.SubModel_ID = VehicleDetails.Submodel_ID JOIN
                                   makes ON VehicleDetails.Make_id = makes.make_id
WHERE SubModels.SubModelName  = 'Elite'

