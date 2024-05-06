-- ------------------------------------------------------------------------------------------- Easy
-- P2: Get all vehicles made between 1950 and 2000 order asc

Select * 
FROM MasterView 
Where [Year] BETWEEN 1950 and 2000
Order by [Year]

