-- ------------------------------------------------------------------------------------------- Easy      : 1 MIN
-- P17: Get total Makes that Mantufactures DriveTypeName=FWD

SELECT Count (make_name)
FROM
(SELECT           Distinct makes.make_name 
FROM                        makes JOIN 
                               VehicleDetails ON VehicleDetails.Make_id = makes.make_id Inner JOIN
                                 drive_Types ON VehicleDetails.drive_Types_ID = drive_Types.driveTypeID
where drive_Types.driveTypeName = 'FWD')R1

