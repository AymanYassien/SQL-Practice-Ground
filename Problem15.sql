-- ------------------------------------------------------------------------------------------- Easy      : 1 MIN
-- P15:  Write a query to get all Makes with make ends with 'W'.

SELECT makes.make_name 
FROM makes
Where make_name Like '%W'

