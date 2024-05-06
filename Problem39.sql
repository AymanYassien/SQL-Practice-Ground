-- ------------------------------------------------------------------------------------------- Easy      : no time
-- P39:  Get the maximum 3 Engine CC

SELECT Distinct TOP 3 VehicleDetails.Engine_CC
FROM VehicleDetails
ORDER BY Engine_CC DESC
