-- 1. Create table and import data
create table SALES_DATASET_RFM_PRJ
(
  ordernumber VARCHAR,
  quantityordered VARCHAR,
  priceeach        VARCHAR,
  orderlinenumber  VARCHAR,
  sales            VARCHAR,
  orderdate        VARCHAR,
  status           VARCHAR,
  productline      VARCHAR,
  msrp             VARCHAR,
  productcode      VARCHAR,
  customername     VARCHAR,
  phone            VARCHAR,
  addressline1     VARCHAR,
  addressline2     VARCHAR,
  city             VARCHAR,
  state            VARCHAR,
  postalcode       VARCHAR,
  country          VARCHAR,
  territory        VARCHAR,
  contactfullname  VARCHAR,
  dealsize         VARCHAR
) 

CREATE TABLE segment_score
(
    segment Varchar,
    scores Varchar)

	
-- 2. Change data type
ALTER TABLE SALES_DATASET_RFM_PRJ
ALTER COLUMN ordernumber TYPE integer USING ordernumber::integer,
ALTER COLUMN quantityordered TYPE integer USING quantityordered::integer,
ALTER COLUMN priceeach TYPE float USING priceeach::double precision,
ALTER COLUMN orderlinenumber TYPE integer USING orderlinenumber::integer,
ALTER COLUMN sales TYPE float USING sales::double precision,
ALTER COLUMN orderdate TYPE date USING orderdate::date,
ALTER COLUMN msrp TYPE integer USING msrp::integer

-- 3. Data cleaning
-- 3.1 Check null/blank
Table public.sales_dataset_rfm_prj
	
select * from public.sales_dataset_rfm_prj
where ordernumber is null

select * from public.sales_dataset_rfm_prj
where quantityordered is null

select * from public.sales_dataset_rfm_prj
where priceeach is null

select * from public.sales_dataset_rfm_prj
where orderlinenumber is null

select * from public.sales_dataset_rfm_prj
where sales is null

select * from public.sales_dataset_rfm_prj
where orderdate is null

-- 3.2. Check and remove duplicates


-- 3.3. Determine outliers with Z-Score
with cte as
	(
select *,
(select avg(quantityordered) from sales_dataset_rfm_prj),
(select stddev(quantityordered) from sales_dataset_rfm_prj)
from sales_dataset_rfm_prj)

select quantityordered, (quantityordered - avg)/stddev as z_score from cte
where abs((quantityordered - avg)/stddev) > 3

--4. CREATE NEW TABLE: SALES_DATASET_RFM_PRJ_CLEAN after cleaning data
CREATE TABLE sales_dataset_rfm_clean as 
	
with cte as
	(
select *,
(select avg(quantityordered) from sales_dataset_rfm_prj),
(select stddev(quantityordered) from sales_dataset_rfm_prj)
from sales_dataset_rfm_prj)

select * from cte
where abs((quantityordered - avg)/stddev) <= 3

-- 5. Key metrics
-- a. Revenue by ProductLine, Year  và DealSize. 
-- Revenue by ProductLine
	
SELECT productline, 
       ROUND(SUM(quantityordered * priceeach):: numeric, 2) AS revenue
FROM sales_dataset_rfm_clean
WHERE status = 'Shipped'
GROUP BY productline
ORDER BY revenue desc;

-- Revenue by Year
SELECT year_id, 
       ROUND(SUM(quantityordered * priceeach):: numeric, 2) AS revenue
FROM sales_dataset_rfm_clean
where status = 'Shipped'
GROUP BY year_id
ORDER BY revenue desc;

-- Which month has the best sales each year?
with cte as
	(
SELECT year_id, month_id,
       ROUND(SUM(quantityordered * priceeach):: numeric, 2) AS revenue
FROM sales_dataset_rfm_clean
where status = 'Shipped'
GROUP BY year_id, month_id
ORDER BY revenue desc)

select year_id, month_id, revenue 
	from cte
where revenue in (select max_revenue from 
(select year_id, max(revenue) as max_revenue from cte
group by year_id) as a)

-- Which product has the best revenue in the UK each year?
select productline,
round(sum(case when year_id = 2003 then quantityordered * priceeach else 0 end):: numeric,2) "2003",
round(sum(case when year_id = 2004 then quantityordered * priceeach else 0 end):: numeric,2) "2004",
round(sum(case when year_id = 2005 then quantityordered * priceeach else 0 end):: numeric,2) "2005"
FROM sales_dataset_rfm_clean
	where status = 'Shipped'
group by productline
	
-- 6. RFM ANALYSIS
-- 6.1. Calculate Recency, Frequency and Monetary Values
select customername, 
	current_date - max(orderdate) as recency,
	count(distinct(ordernumber)) as frequency,
	sum(quantityordered * priceeach) as monetary
	from sales_dataset_rfm_clean
where status = 'Shipped'
group by customername

-- 6.2. Divide RFM Values into 5 tiers using NTILE and form the rfm_scores using CONCAT:
with cte as
	(
select customername, 
	current_date - max(orderdate) as recency, 
	count(distinct(ordernumber)) as frequency, 
	sum(quantityordered * priceeach) as monetary
	from sales_dataset_rfm_clean
where status = 'Shipped'
group by customername
	),
cte2 as 
	(
select customername, recency,
ntile(5) over(order by recency desc) as R, frequency,
ntile(5) over(order by frequency) as F, monetary,
ntile(5) over(order by monetary) as M
from cte
	)
select customername, concat(r,f,m) as rfm_scores from cte2 

-- 6.3. JOIN table cte3 with table segment_score to categorize customers and create table rfm_results to save the result
CREATE TABLE rfm_results as
with cte as
	(
select customername, 
	current_date - max(orderdate) as recency, 
	count(distinct(ordernumber)) as frequency, 
	sum(quantityordered * priceeach) as monetary
	from sales_dataset_rfm_clean
where status = 'Shipped'
group by customername
	),
cte2 as 
	(
select customername, recency,
ntile(5) over(order by recency desc) as R, frequency,
ntile(5) over(order by frequency) as F, monetary,
ntile(5) over(order by monetary) as M
from cte
	),
cte3 as 
	(
select customername, concat(r,f,m) as rfm_scores from cte2)

select customername, rfm_scores, segment from cte3 as a
join segment_score as b
on a.rfm_scores = b.scores

