

-- ------------------------------------------------------------------------------------------- Easy      : 3 MIN
-- P16: Get all Makes that manufactures DriveTypeName = FWD

SELECT           Distinct makes.make_name 
FROM                        makes JOIN 
                               VehicleDetails ON VehicleDetails.Make_id = makes.make_id Inner JOIN
                                 drive_Types ON VehicleDetails.drive_Types_ID = drive_Types.driveTypeID
where drive_Types.driveTypeName = 'FWD'

