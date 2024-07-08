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

3. Cohort analysis	
3.1 Customer Cohort 
with cte as(
select customerid, quantity * unitprice as revenue, invoicedate,
min(invoicedate) over(partition by customerid) as first_purchase from online_retail_clean
),
cte2 as (
select *, TO_CHAR(first_purchase, 'YYYY-MM') AS month_year,
	(extract(year from invoicedate) - extract(year from first_purchase))*12 +
	(extract(month from invoicedate) - extract(month from first_purchase)) + 1 as cohort_index from cte
),
cte3 as (
select month_year, cohort_index, count(distinct(customerid)) as total_customer, sum(revenue) as revenue from cte2
	group by month_year,cohort_index
	)
SELECT month_year,
	sum(case when cohort_index = 1 then total_customer else 0 end) as m1,
	sum(case when cohort_index = 2 then total_customer else 0 end) as m2,
	sum(case when cohort_index = 3 then total_customer else 0 end) as m3,
	sum(case when cohort_index = 4 then total_customer else 0 end) as m4,
	sum(case when cohort_index = 5 then total_customer else 0 end) as m5,
	sum(case when cohort_index = 6 then total_customer else 0 end) as m6,
	sum(case when cohort_index = 7 then total_customer else 0 end) as m7,
	sum(case when cohort_index = 8 then total_customer else 0 end) as m8,
	sum(case when cohort_index = 9 then total_customer else 0 end) as m9,
	sum(case when cohort_index = 10 then total_customer else 0 end) as m10,
	sum(case when cohort_index = 11 then total_customer else 0 end) as m11,
	sum(case when cohort_index = 12 then total_customer else 0 end) as m12,
	sum(case when cohort_index = 13 then total_customer else 0 end) as m13 from cte3
group by month_year
order by month_year

3.2 Retention cohort
with cte as(
select customerid, quantity * unitprice as revenue, invoicedate,
min(invoicedate) over(partition by customerid) as first_purchase from online_retail_clean
),
cte2 as (
select *, TO_CHAR(first_purchase, 'YYYY-MM') AS month_year,
	(extract(year from invoicedate) - extract(year from first_purchase))*12 +
	(extract(month from invoicedate) - extract(month from first_purchase)) + 1 as cohort_index from cte
),
cte3 as (
select month_year, cohort_index, count(distinct(customerid)) as total_customer, sum(revenue) as revenue from cte2
	group by month_year,cohort_index
	),
cte4 as (
SELECT month_year,
	sum(case when cohort_index = 1 then total_customer else 0 end) as m1,
	sum(case when cohort_index = 2 then total_customer else 0 end) as m2,
	sum(case when cohort_index = 3 then total_customer else 0 end) as m3,
	sum(case when cohort_index = 4 then total_customer else 0 end) as m4,
	sum(case when cohort_index = 5 then total_customer else 0 end) as m5,
	sum(case when cohort_index = 6 then total_customer else 0 end) as m6,
	sum(case when cohort_index = 7 then total_customer else 0 end) as m7,
	sum(case when cohort_index = 8 then total_customer else 0 end) as m8,
	sum(case when cohort_index = 9 then total_customer else 0 end) as m9,
	sum(case when cohort_index = 10 then total_customer else 0 end) as m10,
	sum(case when cohort_index = 11 then total_customer else 0 end) as m11,
	sum(case when cohort_index = 12 then total_customer else 0 end) as m12,
	sum(case when cohort_index = 13 then total_customer else 0 end) as m13 from cte3
group by month_year
order by month_year
)

select month_year, 
	round(100*m1/m1,2) as m1,
	round(100*m2/m1,2) as m2,
	round(100*m3/m1,2) as m3,
	round(100*m4/m1,2) as m4,
	round(100*m5/m1,2) as m5,
	round(100*m6/m1,2) as m6,
	round(100*m7/m1,2) as m7,
	round(100*m8/m1,2) as m8,
	round(100*m9/m1,2) as m9,
	round(100*m10/m1,2) as m10,
	round(100*m11/m1,2) as m11,
	round(100*m12/m1,2) as m12,
	round(100*m13/m1,2) as m13
from cte4
	
3.3. Churn Cohort
	
with cte as(
select customerid, quantity * unitprice as revenue, invoicedate,
min(invoicedate) over(partition by customerid) as first_purchase from online_retail_clean
),
cte2 as (
select *, TO_CHAR(first_purchase, 'YYYY-MM') AS month_year,
	(extract(year from invoicedate) - extract(year from first_purchase))*12 +
	(extract(month from invoicedate) - extract(month from first_purchase)) + 1 as cohort_index from cte
),
cte3 as (
select month_year, cohort_index, count(distinct(customerid)) as total_customer, sum(revenue) as revenue from cte2
	group by month_year,cohort_index
	),
cte4 as (
SELECT month_year,
	sum(case when cohort_index = 1 then total_customer else 0 end) as m1,
	sum(case when cohort_index = 2 then total_customer else 0 end) as m2,
	sum(case when cohort_index = 3 then total_customer else 0 end) as m3,
	sum(case when cohort_index = 4 then total_customer else 0 end) as m4,
	sum(case when cohort_index = 5 then total_customer else 0 end) as m5,
	sum(case when cohort_index = 6 then total_customer else 0 end) as m6,
	sum(case when cohort_index = 7 then total_customer else 0 end) as m7,
	sum(case when cohort_index = 8 then total_customer else 0 end) as m8,
	sum(case when cohort_index = 9 then total_customer else 0 end) as m9,
	sum(case when cohort_index = 10 then total_customer else 0 end) as m10,
	sum(case when cohort_index = 11 then total_customer else 0 end) as m11,
	sum(case when cohort_index = 12 then total_customer else 0 end) as m12,
	sum(case when cohort_index = 13 then total_customer else 0 end) as m13 from cte3
group by month_year
order by month_year
)
select month_year, 
100 - 	round(100*m1/m1,2) as m1,
100 -	round(100*m2/m1,2) as m2,
100 -	round(100*m3/m1,2) as m3,
100 -	round(100*m4/m1,2) as m4,
100 -	round(100*m5/m1,2) as m5,
100 -	round(100*m6/m1,2) as m6,
100 -	round(100*m7/m1,2) as m7,
100 -	round(100*m8/m1,2) as m8,
100 -	round(100*m9/m1,2) as m9,
100 -	round(100*m10/m1,2) as m10,
100 -	round(100*m11/m1,2) as m11,
100 -	round(100*m12/m1,2) as m12,
100 -	round(100*m13/m1,2) as m13
from cte4 	
	
