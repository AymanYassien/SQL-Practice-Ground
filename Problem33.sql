-- ------------------------------------------------------------------------------------------- Easy      : update table
-- P33: Get Minimum Engine CC , Maximum Engine CC , and Average Engine CC of all Vehicles


SELECT MAX(VehicleDetails.Engine_CC) MAX, MIN (VehicleDetails.Engine_CC) MIN, AVG(VehicleDetails.Engine_CC) AVG
FROM VehicleDetails
-- -----------
update VehicleDetails
SET Engine_CC = NULL
where Engine_CC = 'N/A'
-- ------------
Alter Table VehicleDetails
Alter Column Engine_CC INT
-- ---------------

