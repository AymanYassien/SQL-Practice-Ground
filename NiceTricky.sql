SELECT *, NEWID() from twitter
order BY NEWID() --  return data in shuffle order for each execute
select top 100 * from car_details 