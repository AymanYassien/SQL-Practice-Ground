

-- ------------------------------------------------------------------------------------------- Easy      : 1 MIN
-- P14: Write a query to get all Makes with make starts with 'B'.

Select makes.make_name
FROM makes
where make_name LIKE 'B%'

