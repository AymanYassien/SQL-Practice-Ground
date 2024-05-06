-- ------------------------------------------------------------------------------------------- Easy      : 1 MIN
-- P19: Get total vehicles per DriveTypeName Per Make
-- then filter only results with total > 10,000

SELECT                   makes.make_name, drive_Types.driveTypeName, COUNt (*) as Total
FROM                        drive_Types JOIN  -- try  swap tables
                                 VehicleDetails ON  VehicleDetails.drive_Types_ID = drive_Types.driveTypeID JOIN 
                                   makes ON makes.make_id = VehicleDetails.Make_id
GROUP By makes.make_name, drive_Types.driveTypeName
HAVING COUNt (*) > 10000
ORDER BY make_name asc, Total DESC

