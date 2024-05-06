-- ------------------------------------------------------------------------------------------- Easy      : Notice 
-- P40 : Get all vehicles that has one of the Max 3 Engine CC

-- retrieve top 3 values 
-- then nretrieve all rows has  one of thoose values

SELECT VehicleDetails.Vehicle_Display_Name FROM VehicleDetails
Where Engine_CC IN
(
    SELECT Distinct TOP 3 VehicleDetails.Engine_CC FROM VehicleDetails
    ORDER BY Engine_CC DESC
)

