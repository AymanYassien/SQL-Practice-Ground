-- DQL

IF NOT EXISTS (SELECT * FROM sys.databases WHERE NAME = 'HR_DATABASES')
BEGIN
    CREATE DATABASE HR_DATABASES;
END

-- --------------------------------------------------------------------------------------
SELECT * FROM EMPLOYEES;

SELECT first_name, last_name, email from Employees;

SELECT jobs.* FROM jobs;

SELECT * FROM countries;

SELECT * FROM EMPLOYEES;
-- --------------------------------------------------------------------------------------

SELECT DISTINCT * FROM EMPLOYEES -- RETURN DISTINCIT ROW

SELECT DISTINCT first_name from Employees;

-- --------------------------------------------------------------------------------------
SELECT first_name, salary FROM EMPLOYEES
WHERE
salary > 6000 AND salary <9000

SELECT Employees.* FROM EMPLOYEES
WHERE
  salary !=  6000 and salary > 19000 

SELECT first_name, salary, manager_id, department_id FROM EMPLOYEES
WHERE
salary <> 6000

SELECT first_name, salary,manager_id  FROM EMPLOYEES
WHERE
manager_id IS NULL

SELECT first_name, salary,manager_id  FROM EMPLOYEES
WHERE
manager_id IS NOT NULL

select first_name, salary, department_id, manager_id
FROM   employees
where  (department_id >=6 AND department_id <= 9) OR salary > 15000

select DISTINCT salary from employees
where salary > 10000 * 1.15

UPDATE employees 
set salary = salary * 1.15
where salary >= 10000
-- -------------------------------------------------------------------------------------- IN
SELECT * FROM departments 
WHERE
department_id IN (1, 2, 5, 7, 8)

select departments.department_name from departments
where 
department_id NOT IN (select department_id from Employees where salary > 11000)
-- -------------------------------------------------------------------------------------- SELECT TOP , ORDER BY
select top 5 * from employees

select top 10 PERCENT * from employees;



-- Q: return data of employees was take a top 3 salaries (top 3 values in other word) in company

-- sol: divide and solve step by step

-- 1- return all salaries
select salary from employees
order by salary desc

-- 2- return distinct salaries
SELECT DISTINCT salary from employees 
order by salary DESC

-- 3- return TOP 3 distinct salaries
SELECT DISTINCT top 3 salary from employees 
order by salary DESC

-- 4- return data(id, name, salary) about the TOP 3 distinct salaries
select employee_id, first_name, salary from employees 
where salary in 
(
    SELECT DISTINCT top 3 salary from employees 
    order by salary DESC
)
ORDER BY salary DESC

-- --------------------------------------------------------------------------  alias (as, vars, ()name)
SELECT A = 5 * 6, B = -98;                
-- double COL, named A, B || one row contain res of A, B


SELECT A = 5 * 7, B = 9 
FROM employees; 
--  rows = number of rows in employees table


select employee_id, first_name, Half_salary = salary / 2 from employees 

select employee_id, first_name, salary / 2 as Half_salary from Employees


-- (+ " " +) => invalid col name " "
SELECT first_name + ' ' + last_name as Full_name, employee_id, salary from Employees
SELECT first_name + '  a  ' + last_name as Full_name, employee_id from Employees


                                                                                                       -- EROR     
select employee_id, first_name + ' ' + last_name as Full_name, monthlySalary = salary , YearlySalary = monthlySalary * 12 FROM employees 
select employee_id, first_name + ' ' + last_name as Full_name, monthlySalary = salary, YearlySalary =  salary        * 12 FROM employees      
                                                                                                       -- TRUE

select * from employees

select today = GETDATE();

select employee_id, first_name + ' ' + last_name as Full_name, Years_in_Company = DATEDIFF(month, hire_date, GETDATE()) / 12 from employees
order by Years_in_Company desc


-- alias for table
select e.first_name, d.department_id
from employees as e, departments as d 


select (first_name)f from employees

-- -------------------------------------------------------------------------- BETWEEN
select * from Employees 
where salary between 8000 and 12000  -- 2 values was included

select * from Employees 
where salary >= 8000 and  salary <= 12000  
-- -------------------------------------------------------------------------- AVG, COUNT, MIN-MAX, SUM = aggregate functions
-- count => no of rows
-- avg   => avg of numerical values
-- sum   => sum of numerical values
-- min   => min value in selected row
-- max   => max value in selected row 

-- min, max, count => take numbers .. varchars    | but avg, sum only nums 


select * from employees 

select totalCount = COUNT(salary),
       totalAvg   = AVG  (salary),
       totalSum   = sum  (salary),
       minSalary  = MIN  (salary),
       maxSalary  = MAX  (salary)
FROM EMPLOYEES;

SELECT TOTALCOUNT = COUNT(salary),
TOTALAVG = AVG(salary),
totalSum = sum(salary),
min  = MIN(salary),
max(salary) -- no col name here
from employees 
where job_id in (1,2) OR job_id BETWEEN 03 and 09
; 

select * from employees 

select totalCount = COUNT(first_name),
       totalAvg   = AVG  (salary),
       totalSum   = sum  (salary),
       minName  = MIN  (first_name),
       maxName  = MAX  (first_name)
FROM employees; 


select count(employee_id) from employees 

-- count : count only not null
select count(exit_date) from employees 

-- ****************************************************************************************************************
--  name is case sensitive in SQL           name is case sensitive in SQL             name is case sensitive in SQL 
-- ****************************************************************************************************************
-- ------------------------------------------------------------------------------------------------------------------------------- group by

select department_id, totalCount = count (salary), avg(salary) as totalAvg, min = MIN(salary), MAX(salary) as maxSalary, totalSum = SUM(salary) from employees 
GROUP by department_id
-- ORDER by count(salary) ASC
ORDER by department_id ASC
-- ------------------------------------------------------------------------------------------------------------------------------- Having = where 
-- but can't use where with aggregate function (groupby) directed 
select department_id, totalCount = count(employee_id), totalAvg= avg(salary), sum (salary) as totalSum, 
(min(first_name)) min, (max(salary))maxSalary FROM employees

GROUP BY department_id -- each row is grouped by its department
HAVING max(salary) > 2122
-- order by totalAvg


select * from 
(
    select department_id, totalCount = count(employee_id), totalAvg= avg(salary), sum (salary) as totalSum, 
(min(first_name)) min, (max(salary))maxSalary FROM employees

GROUP BY department_id -- each row is grouped by its department
HAVING max(salary) > 2122
-- order by totalAvg

) R1

where R1.totalCount > 5
-- ------------------------------------------------------------------------------------------------------------------------LIKE
select employee_id, first_name, department_id
from Employees 
where
first_name LIKE 'a%' 

select employee_id, first_name, department_id
from Employees 
where
first_name LIKE '%a' 

select employee_id, first_name, department_id
from Employees 
where
first_name LIKE '%a%' 

select employee_id, first_name, department_id
from Employees 
where
first_name LIKE '_a___%' 

select employee_id, first_name, department_id
from Employees 
where
first_name LIKE '%a_' 

select employee_id, first_name, department_id
from Employees 
where
first_name LIKE '____a' 

-- The percent sign (%) represents zero, one, or multiple characters
-- The underscore sign (_) represents one, single character
-- [] Represents any single character within the brackets 
-- - Represents any single character within the specified range 

-- -----------------------------------------------------------------------------------wild cards
select first_name from employees
where
first_name LIKE 'mohammed' OR first_name LIKE 'mohammad' OR first_name LIKE 'moham%d'


select first_name from employees
where 
first_name like 'mohamm[ae]d'

select salary from employees 
where
first_name like 'a%' OR first_name like 'b%' OR first_name like 'c%'


select * from employees 
where
first_name like '[abc]%'

-- from a to r
select * from employees 
where
first_name like '[a-r]%' -- [a-r] != [a - r] (5 chars: a ws - ws r) 


SELECT TOP 5 FirstName, LastName  
FROM Person.Person  
WHERE FirstName LIKE 'Al[^a]%'; 




