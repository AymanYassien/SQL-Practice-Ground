-- ------------------------------------------------------------------------------------------- Easy      
-- P41: Get all Makes that manufactures one of the Max 3 Engine CC

SELECT             Distinct makes.make_name 
FROM                   makes JOIN 
                         VehicleDetails ON VehicleDetails.Make_id = makes.make_id
                         WHERE Engine_CC IN
(
    SELECT Distinct TOP 3 VehicleDetails.Engine_CC FROM VehicleDetails
    -- ORDER BY Engine_CC DESC
)
ORDER BY make_name 


