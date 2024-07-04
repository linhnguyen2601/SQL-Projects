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

-- 5. RFM ANALYSIS
-- 5.1. Calculate Recency, Frequency and Monetary Values
select customername, 
	current_date - max(orderdate) as recency,
	count(distinct(ordernumber)) as frequency,
	sum(quantityordered * priceeach) as monetary
	from sales_dataset_rfm_clean
where status = 'Shipped'
group by customername

-- 5.2. Divide RFM Values into 5 tiers using NTILE and form the rfm_scores using CONCAT:
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

-- 5.3. JOIN table cte3 with table segment_score to categorize customers and create table rfm_results to save the result
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

