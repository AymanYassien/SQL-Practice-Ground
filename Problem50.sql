
-- P 50:  Get all Fuel Types , each time the result should be showed in random order  

SELECT * FROM Fuel_Types
Order by NEWID()


SELECT Fuel_Type_ID FROM Fuel_Types
Order by NEWID()

