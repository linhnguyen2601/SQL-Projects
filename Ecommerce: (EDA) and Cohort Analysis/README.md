# theLook eCommerce: Exploratory Data Analysis (EDA) and Cohort Analysis 

## 1. Overview
Dataset in BigQuery
TheLook is a fictitious eCommerce clothing site developed by the Looker team. The dataset contains information >about customers, products, orders, logistics, web events and digital marketing campaigns. The contents of this >dataset are synthetic, and are provided to industry practitioners for the purpose of product discovery, testing, and >evaluation.

I use the Big Query to do the project with SQL:
Datasource: https://console.cloud.google.com/bigquery?p=bigquery-public-data&d=thelook_ecommerce&page=dataset&project=project-2-422702&ws=!1m15!1m4!1m3!1sproject-2-422702!2sbquxjob_63602b4b_1907d32f234!3sUS!1m4!4m3!1sbigquery-public-data!2sthelook_ecommerce!3sdistribution_centers!1m4!4m3!1sbigquery-public-data!2sthelook_ecommerce!3sproducts
but you can download it on Kaggle: https://www.kaggle.com/datasets/mustafakeser4/looker-ecommerce-bigquery-dataset/code

**Conducting the dataset in the period from 2019-01-13 - 2024-06-30**

The dataset comprises of 7 tables:

1.
| Table | Columns | Description |
| --- | --- |  --- |  
| **distribution_centers** | id | Unique identifier for each distribution center. 
||name | Name of the distribution center.
||latitude | Latitude coordinate of the distribution center.
||longitude | Longitude coordinate of the distribution center. |

2.
| Table | Columns |   Description |
| --- | --- |   --- |  
|**events**| id | Unique identifier for each event.
||user_id | Identifier for the user associated with the event.
||sequence_number | Sequence number of the event.
||session_id | Identifier for the session during which the event occurred.
||created_at | Timestamp indicating when the event took place.
||ip_address | IP address from which the event originated.
||city | City where the event occurred.
||state | State where the event occurred.
||postal_code | Postal code of the event location.
||browser | Web browser used during the event.
||traffic_source | Source of the traffic leading to the event.
||uri | Uniform Resource Identifier associated with the event.
||event_type | Type of event recorded.|

3.
| Table | Columns |  Description | 
| --- | --- | --- |   
|**inventory_items**|id| Unique identifier for each inventory item.
||product_id| Identifier for the associated product.
||created_at| Timestamp indicating when the inventory item was created.
||sold_at| Timestamp indicating when the item was sold.
||cost| Cost of the inventory item.
||product_category| Category of the associated product.
||product_name| Name of the associated product.
||product_brand| Brand of the associated product.
||product_retail_price| Retail price of the associated product.
||product_department| Department to which the product belongs.
||product_sku| Stock Keeping Unit (SKU) of the product.
|| product_distribution_center_id| Identifier for the distribution center associated with the product.

4.
| Table | Columns |   Description |
| --- | --- | --- |   
|**order_items** |id | Unique identifier for each order item
|| order_id | Identifier for the associated order.
|| user_id | Identifier for the user who placed the order.
||product_id | Identifier for the associated product.
|| inventory_item_id | Identifier for the associated inventory item.
||status | Status of the order item.
||created_at | Timestamp indicating when the order item was created.
||shipped_at | Timestamp indicating when the order item was shipped.
||delivered_at | Timestamp indicating when the order item was delivered.
||returned_at | Timestamp indicating when the order item was returned.

5. 
| Table | Columns |   Description |
| --- | --- | --- |   
|**orders** | order_id| Unique identifier for each order.
||user_id| Identifier for the user who placed the order.
||status| Status of the order.
||gender| Gender information of the user.
||created_at| Timestamp indicating when the order was created.
||returned_at| Timestamp indicating when the order was returned.
||shipped_at| Timestamp indicating when the order was shipped.
||delivered_at| Timestamp indicating when the order was delivered.
||num_of_item| Number of items in the order.

6.
| Table | Columns |   Description |
| --- | --- | --- |   
| **products**| id| Unique identifier for each product.
||cost| Cost of the product.
||category| Category to which the product belongs.
||name| Name of the product.
||brand| Brand of the product.
||retail_price| Retail price of the product.
||department| Department to which the product belongs.
||sku| Stock Keeping Unit (SKU) of the product.
||distribution_center_id| Identifier for the distribution center associated with the product.

7.
| Table | Columns |   Description |
| --- | --- | --- |   
|  **users** | id| Unique identifier for each user.
|| first_name| First name of the user.
||last_name| Last name of the user.
|| email| Email address of the user.
|| age| Age of the user.
|| gender| Gender of the user.
|| state| State where the user is located.
|| street_address| Street address of the user.
|| postal_code| Postal code of the user.
||city| City where the user is located.
|| country| Country where the user is located.
|| latitude| Latitude coordinate of the user.
|| longitude| Longitude coordinate of the user.
|| traffic_source| Source of the traffic leading to the user.
|| created_at| Timestamp indicating when the user account was created.

## 2. Data cleaning

**2.1. Check NULL**

**ORDERS Table**

| # | Columns |   Null count |
| --- | --- | --- |   
| 1 | order_id | 0 |
| 2 | user_id | 0 |
|3 | status | 0 |
|4| gender | 0|
|5| created_at | 0|
|6| shipped_at | 44076|
|7| returned_at | 113079|
|8| delivered_at | 81698|
|9| num_of_item | 0|

**ORDER_ITEMS table**

| # | Columns |   Null count |
| --- | --- | --- |   
| 1 | id | 0 |
| 2 | order_id | 0 |
| 3 | user_id | 0 |
|4 | product_id | 0 |
|5| inventory_item_id | 0|
|6 | status | 0 |
|7| created_at | 0|
|8| shipped_at | 44076|
|9| returned_at | 113079|
|10| delivered_at | 81698|
|11| sale_price | 0|

**PRODUCTS table**

| # | Columns |   Null count |
| --- | --- | --- |   
| 1 | id | 0 |
| 2 | cost | 0 |
|3 | category | 0 |
|4| name | 0|
|5| brand | 0|
|6| retail_price | 0|
|7| department | 0|
|8| sku | 0|
|9| distribution_center_of | 0|
 
**2.2. Check Duplicates**

## Data exploratory

**ORDERS and ORDER_ITEMS tables:**

| # | Orders_table |   Order_items_table |
| --- | --- | --- |   
| Total orders | 120386 | 120314 |

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/a6fc2d26-507f-4847-8d6c-8c74fc4f052f)

After cross-checking data from the two tables, ORDERS and ORDER_ITEMS, I discovered that the total number of orders and the number of orders in each category differ between the two tables when applying the condition that considers orders created before July 2024. The reason I chose the column Created_at is because that column has no null values.

I continued to check if there is any difference between the Created_at column in the ORDERS table and the ORDER_ITEMS table by using JOIN(), considering the fact that the data might be recorded with different logic.

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/b755a4d3-4f53-4b0e-a80d-27f4a6d4426b)

The time an order is created and the time each item in the order is created are different. This raises additional concerns about the accuracy of the Created_at column in the ORDER_ITEMS table, as this issue does not occur in the ORDERS table where the Created_at date is never after the Shipped_at date. However, in the ORDER_ITEMS table, this issue occurs quite frequently (35,865 rows out of 181,427 rows, which is nearly 20%), not to mention the Shipped_at column has null values in as much as 30% of the rows so we cannot update values of those entries to make it reasonable.

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/934a54eb-a64a-473c-bddc-d3767ed99a2f)

Therefore, I will use the Created_at column from the ORDERS table when joining the ORDERS and ORDER_ITEMS tables.

Considering that orders with the "Complete" status only account for 25% of the entire ORDERS table, while orders with the "Processing" and "Shipped" statuses make up more than 50% of the table, I will check the validity of these two status categories.
- Are there many orders generated in recent months, causing the "Processing" and "Shipped" statuses to be high?
- If not, is it because the orders have not been updated to the correct status?

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/aa16d8b1-c272-4a2b-b441-3e0bac79680e)

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/0f9eb180-6531-4684-ab50-e8b6747b67e2)

I discovered that many orders from January 2019 are still in processing, and many orders from January 2019 are still in the shipped status but have not been completed. As it is unclear whether these orders will be completed, I decided to focus on "Complete" orders only for the analysis, as there is no stakeholder to clarify this point.

**##3. EDA**

**3.1. The number of completed orders and user each month**

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/4b5b9436-e885-4e3f-950d-651f1f7132b2)
Number of orders and users increased month after month

**3.2. Average Order Value (AOV) and the number of customers per month** 

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/d5551d18-49e6-4c8f-9f10-8e50f1e14261)

**3.3. Customer segmentation by age and gender**
 
Continuing from the previous session, I'm still debating whether to include statistics for customers in groups other than those with completed orders. Because I don't have high confidence in the dataset's quality, including customers from other groups would require additional analysis of order cancellations/completions/refunds per group of customers.

Which age/gender groups have higher rates of order cancellations/completions/returns? Here, I'm looking at age/gender as factors influencing shopping behaviors without considering reasons for cancellations/returns because that information isn't included in the dataset.

Due to the dataset's practical limitations, delving deeply into this aspect for analysis isn't necessary right now. Therefore, I will proceed with querying the group of customers who have completed orders (status = Complete) => which involves joining with the ORDERS table.

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/fabc997e-d6ef-4c39-ac13-de0bb5b75e9d)

Customers aged from 12 to 61 show no significant differences in purchasing power based on age or gender.

**3.4. Customer segmentation by geography/country**

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/31315caa-4fc5-493b-9727-69a4cd74dba6)

**3.5. Customer segmentation by traffic source**

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/cfa8c0ed-27f8-4035-9cc4-ad0cd6415027)

6. Thống kê top 5 sản phẩm có lợi nhuận cao nhất
   
with cte as(
  select a.order_id, a.created_at, b.product_id
from bigquery-public-data.thelook_ecommerce.orders as a
join bigquery-public-data.thelook_ecommerce.order_items as b
on a.order_id = b.order_id
where a.status = 'Complete' and a.created_at < '2024-07-01'
order by a.order_id
)
select * from  bigquery-public-data.thelook_ecommerce.products
where id in (Select product_id from cte)

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/088e7795-b2af-41b5-a959-eb2f6f65bb8f)

=> chỉ còn 22k/29K sản phẩm đã được bán trong những đơn hàng đã hoàn thành và đc tạo trước tháng 7/2024

with cte as(
  select a.order_id, a.created_at, b.product_id, b.sale_price, c.cost, c.name
from bigquery-public-data.thelook_ecommerce.orders as a
join bigquery-public-data.thelook_ecommerce.order_items as b
on a.order_id = b.order_id
join bigquery-public-data.thelook_ecommerce.products as c
on b.product_id = c.id
where a.status = 'Complete' and a.created_at < '2024-07-01'
)
select product_id, name, count(distinct(order_id)) as total_order, sum(sale_price - cost) as total_profit
from cte
group by product_id,name
order by total_profit desc
limit 5

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/bef2432e-951c-414e-91b4-422178a9ff05)

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/ebbc972f-5c12-454a-ba92-43400a5992ec)

=> sp bán đc lợi nhuận cao nhất: AIR JORDAN DOMINATE SHORTS MENS 465071-100

7. Doanh thu tính đến thời điểm hiện tại trên mỗi danh mục

with cte as(
  select a.order_id, a.created_at, b.product_id, b.sale_price, c.category
from bigquery-public-data.thelook_ecommerce.orders as a
join bigquery-public-data.thelook_ecommerce.order_items as b
on a.order_id = b.order_id
join bigquery-public-data.thelook_ecommerce.products as c
on b.product_id = c.id
where a.status = 'Complete' and a.created_at < '2024-07-01'
)

select category, count(distinct(order_id)) as total_order, sum(sale_price) as revenue from cte
group by category
order by revenue desc

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/5874b73c-7193-40d5-8df1-f43b86699fd8)

## Dashboard

Giả sử team của bạn đang cần dựng dashboard và có yêu cầu xử lý dữ liệu trước khi kết nối với BI tool. Sau khi bàn bạc, team của bạn quyết định các metric cần thiết cho dashboard và cần phải trích xuất dữ liệu từ database để ra được 1 dataset như mô tả 

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/eff8af4e-d181-49d1-a3ba-03260f08352c)

with cte as(
  select a.order_id, a.created_at, b.product_id, b.sale_price, c.category, c.cost
from bigquery-public-data.thelook_ecommerce.orders as a
join bigquery-public-data.thelook_ecommerce.order_items as b
on a.order_id = b.order_id
join bigquery-public-data.thelook_ecommerce.products as c
on b.product_id = c.id
where a.status = 'Complete' and a.created_at < '2024-07-01'
), 
cte2 as(
select extract(month from created_at) as month, 
extract(year from created_at) as year,
category as product_category,
sum(sale_price) as TPV,
count(Distinct(order_id)) as TPO, 
sum(cost) as total_cost,
sum(sale_price - cost) as total_profit,
sum(sale_price-cost)/sum(cost) as Profit_to_cost_ratio
from cte
group by month, year, product_Category
)
select *, 
lead(TPV) over(order by month, product_category) as revenue_growth,
lead(TPO) over(order by month,product_category) as order_growth,
from cte2
order by year desc, month

## Cohort Analysis



