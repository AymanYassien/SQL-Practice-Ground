-- ------------------------------------------------------------------------------------------- Easy      : 7 MIN
-- P18: Get total vehicles per DriveTypeName Per Make 
-- and order them per make asc then per total Desc

SELECT                   makes.make_name, drive_Types.driveTypeName, COUNt (*) as Total
FROM                        drive_Types JOIN  -- try  swap tables
                                 VehicleDetails ON  VehicleDetails.drive_Types_ID = drive_Types.driveTypeID JOIN 
                                   makes ON makes.make_id = VehicleDetails.Make_id
GROUP By makes.make_name, drive_Types.driveTypeName
ORDER BY make_name asc, Total DESC

