1. CREATE table and import data
CREATE TABLE online_retail
(
    invoiceno varchar,
    stockcode varchar,
    description varchar,
    quantity varchar,
    invoicedate varchar,
    unitprice varchar,
    customerid varchar,
    country varchar
)

2. CHANGE data type

ALTER TABLE online_retail
ALTER COLUMN quantity type integer USING quantity::integer,
ALTER COLUMN invoicedate type date USING invoicedate::date,
ALTER COLUMN unitprice type float USING unitprice::double precision

3. Check null

select * from online_retail
    
select * from online_retail
where invoiceno = ''
or stockcode = ''
or description = ''
or quantity = ''
or invoicedate = ''
or unitprice = ''
or customerid = ''
or country = ''

description and customerid    

with cte as (
select *,
row_number() over(partition by invoiceno, stockcode, quantity order by invoicedate)
	as rownumber
from online_retail
	order by rownumber desc)
select * from cte where rownumber > 1

=> There are 5433 duplicate rows over a total of 541909 rows
=> Remove duplicate

CREATE TABLE online_retail_clean as 
(with cte as 
	(
select *,
row_number() over(partition by invoiceno, stockcode, quantity order by invoicedate)
	as rownumber
from online_retail
	order by rownumber desc)
select invoiceno, stockcode, description, quantity, invoicedate, unitprice, customerid, country 
	from cte where rownumber = 1 and (quantity > 0 and unitprice > 0) and customerid <> '')

select * from online_retail_clean > 392668 bản ghi
