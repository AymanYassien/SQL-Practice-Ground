
-- ------------------------------------------------------------------------------------------- Easy      : Nice 
-- P30: Get all Vehicle_Display_Name, NumDoors and add extra column to describe number of doors by words,
-- and if door is null display 'Not Set'

-- select Distinct NumDoors
-- FROM VehicleDetails
-- -- 0, 1, 2, 3, ,4, ,5 ,6, ,8, NULL


select VehicleDetails.Vehicle_Display_Name, VehicleDetails.NumDoors, DescripeNumber = 
CASE 
    When NumDoors = '0' THEN 'Zero Door'
    When NumDoors = '1' THEN 'ONE Door'
    When NumDoors = '2' THEN 'Two Doors'
    When NumDoors = '2' THEN 'Two Doors'
    When NumDoors = '3' THEN 'Three Doors'
    When NumDoors = '4' THEN 'Four Doors'
    When NumDoors = '5' THEN 'Five Doors'
    When NumDoors = '6' THEN 'SIX Doors'
    When NumDoors = '8' THEN 'Eight Doors'
    else 'Not Set'
END 

FROM VehicleDetails

