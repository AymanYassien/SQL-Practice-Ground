

--------------------------------------------------------------- the emoployee

1-- 
-- SELECT        Employees.Name, Employees.ManagerID, Employees.Salary, Managers.Name AS ManagerName
-- FROM            Employees INNER JOIN
--                          Employees AS Managers ON Employees.ManagerID = Managers.EmployeeID

2-  
-- --Get all employees that have manager or does not have manager along with Manager's name, incase no manager name show null
-- -- this will select all data from employees regardless if they have manager or not, note here we used left outer join 
-- SELECT        Employees.Name, Employees.ManagerID, Employees.Salary, Managers.Name AS ManagerName
-- FROM            Employees Left JOIN
--                          Employees AS Managers ON Employees.ManagerID = Managers.EmployeeID

3-- 





