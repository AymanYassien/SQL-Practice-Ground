-- ------------------------------------------------------------------------------------------- Easy      : optimized sol
-- P29: Return found=1 if there is any vehicle made in year 1950

SELECT  Found = 
case

When R1 > 0 THEN 1
Else 0

END 

FROM 
(select count(VehicleDetails.[Year]) R1
FROM VehicleDetails
WHERE VehicleDetails.[Year] = 1950)R2

-- ------------- ------------------        optimized one 
select Found = 1
where 
exists
(
    select top 1*  from VehicleDetails where VehicleDetails.[Year] = 1950 
)

