# Data cleaning

## Check null

### ORDERS TABLE

select count(*)
 from bigquery-public-data.thelook_ecommerce.orders
 where order_id is null 

select count(*)
 from bigquery-public-data.thelook_ecommerce.orders
 where user_id is null 

 select count(*)
 from bigquery-public-data.thelook_ecommerce.orders
 where status is null 

 select count(*)
 from bigquery-public-data.thelook_ecommerce.orders
 where gender is null

 select count(*)
 from bigquery-public-data.thelook_ecommerce.orders
 where order_id is null 
 or user_id is null
 or status is null
 or gender is null 
 or created_at is null 
 or returned_at is null

select count(*)
 from bigquery-public-data.thelook_ecommerce.orders
 where shipped_at is null
=> 44076

select count(*)
 from bigquery-public-data.thelook_ecommerce.orders
 where delivered_at is null
 => 81698

  select count(*)
 from bigquery-public-data.thelook_ecommerce.orders
 where num_of_item is null
 => không có null

### ORDER_ITEMS TABLE

select count(*) from bigquery-public-data.thelook_ecommerce.order_items
 where id is null
 or order_id is null
 or user_id is null
 or product_id is null
 or inventory_item_id is null
 or status is null
 or created_at is null

select count(*) from bigquery-public-data.thelook_ecommerce.order_items
shipped_at is null

### PRODUCTS TABLE
 select count(*) from bigquery-public-data.thelook_ecommerce.products
 where id is null
 or cost is null
 or category is null
 or name is null
 => name null 2, brand null 24, 

 select count(*) from bigquery-public-data.thelook_ecommerce.products
 where 
 retail_price is null
 or department is null
 or sku is null
 or distribution_center_id is null
 => các cột còn lại k có chứa giá trị null

## Data exploratory

Determine dataset's time period:
select min(created_at) as start_period, max(created_at) as end_period
 from bigquery-public-data.thelook_ecommerce.orders

select count(distinct(order_id)) from bigquery-public-data.thelook_ecommerce.orders
where created_at < '2024-07-01'

select count(distinct(order_id)) from bigquery-public-data.thelook_ecommerce.order_items 
where created_at < '2024-07-01'

select a.status, Order_table, Order_item_table from 
(select status, count(distinct(order_id)) as Order_table from bigquery-public-data.thelook_ecommerce.orders
where created_at < '2024-07-01'
group by status) as a 
Join 
(
select status, count(distinct(order_id)) as Order_item_table,
from bigquery-public-data.thelook_ecommerce.order_items
where created_at < '2024-07-01'
group by status) as b
on a.status = b.status

select 
format_date('%Y-%m',created_at) as month_year,
avg(Distinct(order_id)) as total_orders,
count(distinct(user_id)) as total_users
from bigquery-public-data.thelook_ecommerce.orders
where status = 'Processing' and created_at < '2024-07-01'
group by month_year
order by month_year

select 
format_date('%Y-%m',created_at) as month_year,
avg(Distinct(order_id)) as total_orders,
count(distinct(user_id)) as total_users
from bigquery-public-data.thelook_ecommerce.orders
where status = 'Shipped' and created_at < '2024-07-01'
group by month_year
order by month_year

select a.order_id, a.created_at, b.order_id
from bigquery-public-data.thelook_ecommerce.orders as a
join bigquery-public-data.thelook_ecommerce.order_items as b
on a.order_id = b.order_id
order by a.order_id

select count(Distinct(order_id)) as total_order,
count(distinct(user_id)) as total_users from bigquery-public-data.thelook_ecommerce.orders
where status = 'Complete' and created_at < '2024-07-01'

 **3.1. The number of completed orders and user each month**
select 
format_date('%Y-%m',created_at) as month_year,
count(Distinct(order_id)) as total_orders,
count(distinct(user_id)) as total_users
from bigquery-public-data.thelook_ecommerce.orders
where status = 'Complete' and created_at < '2024-07-01'
group by month_year
order by month_year desc

 **3.2. Average Order Value (AOV) and the number of customers per month** 
select a.order_id, a.created_at, b.user_id, b.product_id, b.sale_price
from bigquery-public-data.thelook_ecommerce.orders as a
join bigquery-public-data.thelook_ecommerce.order_items as b
on a.order_id = b.order_id
where a.status = 'Complete' and a.created_at < '2024-07-01'
order by a.order_id
