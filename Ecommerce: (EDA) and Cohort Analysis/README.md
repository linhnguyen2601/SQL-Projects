# theLook eCommerce: Exploratory Data Analysis (EDA) and Cohort Analysis 

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/b8bb6b50-0ac3-49ba-9f3d-a9f38f519fc9)

## 1. Overview

### 1.1. Business Requirements:

TheLook is a fictitious e-Commerce clothing site developed by the Looker team. 

The Retention rate of the e-Commerce platform is **alarmingly low, with 90% of new customers not returning**. To address this issue, we will explore the following questions: 

- What is the customer return rate of the platform?
- Who are the customers that are leaving?
- And what are the factors contributing to this high churn rate?

**Goal**: design a strategic dashboard tailored for executive levels. Individuals at this level prefer streamlined dashboard without overly complex charts or excessive slicers.

### 1.2. About the dataset:
Dataset in BigQuery. The dataset contains information about customers, products, orders, logistics, web events and digital marketing campaigns. The contents of this dataset are synthetic, and are provided to industry practitioners for the purpose of product discovery, testing, and >evaluation.

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

However, we will be focusing only the following 4 tables:

- orders: detailed description of each order
- order_items: detailed description of items purchased for each order ID
- products: detailed description of items sold on theLook
- users: detailed description of all customers

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/f79b8a7c-5d95-40c4-a4e5-21c83f76daa8)

## 2. Data cleaning

**2.1. Data Quality Checks: Data Type Validation, Null Values, and Duplicates**

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

By using the ROW_NUMBER() function to group the data and setting the condition that it is greater than 1, we found that the dataset does not contain any duplicate data

## 3. Data analysis

### 3.1. Data validation:

#### **Cross-field Validation: ORDERS and ORDER_ITEMS tables:**

| # | Orders_table |   Order_items_table |
| --- | --- | --- |   
| Total orders | 120386 | 120314 |

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/a6fc2d26-507f-4847-8d6c-8c74fc4f052f)

After cross-checking data from the two tables, ORDERS and ORDER_ITEMS, I discovered that the total number of orders and the number of orders in each category differ between the two tables when applying filters for orders created before July 2024. The reason I chose the column Created_at is because that column has no null values.

To investigate the differences between the created_at timestamps in the ORDERS table and the ORDER_ITEMS table, I performed a SQL join operation. 

This analysis is based on the assumption that there might be differences between the timestamps in the two tables, given that the created_at timestamp in the ORDERS table records the time when an order was initially created (typically when an item is first added to the shopping cart), whereas the created_at timestamp in the ORDER_ITEMS table records the time each individual item is added to the cart.

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/b755a4d3-4f53-4b0e-a80d-27f4a6d4426b)

As expected, the analysis revealed differences between the created_at timestamps in the ORDERS table and the ORDER_ITEMS table. This discrepancy raises concerns about the accuracy of the created_at column in the ORDER_ITEMS table. Specifically, while the created_at date in the ORDERS table is always before the shipped_at date, the ORDER_ITEMS table frequently has created_at dates that are after the shipped_at dates. This issue affects a significant portion of the data (35,865 rows out of 181,427 rows, or nearly 20%).

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/934a54eb-a64a-473c-bddc-d3767ed99a2f)

To address the data accuracy concerns, **I will use the created_at column from the ORDERS table when joining the ORDERS and ORDER_ITEMS tables.** This approach ensures more reliable timestamps, as the created_at values in the ORDERS table have been verified to be accurate and consistently recorded before the shipped_at dates.

#### **Consistency Check**

**To check the validity of the "Processing" and "Shipped" status categories** and understand why they make up more than 50% of the ORDERS table, I will analyze the following aspects:

- Time Distribution: Determine if there has been an increase in the number of orders generated in recent months, which could explain the high number of "Processing" and "Shipped" statuses.
- 
- Status Update: Investigate if orders have not been updated to the correct status, indicating potential delays or issues in the order processing workflow.

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/aa16d8b1-c272-4a2b-b441-3e0bac79680e)

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/0f9eb180-6531-4684-ab50-e8b6747b67e2)

I discovered that many orders from January 2019 are still in the processing stage, and many others are in the shipped status but remain incomplete. Since it is unclear whether these orders will ever be completed and there is no stakeholder available to provide clarification, **I decided to focus solely on "Complete" orders for the analysis**.

## 4. EDA

**4.1. The number of completed orders and user each month**

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/4b5b9436-e885-4e3f-950d-651f1f7132b2)

The result reveals a positive trend of consistent growth in both the number of orders and the number of users month after month. This upward trajectory suggests increasing customer engagement and expanding business operations.

**4.2. Average Order Value (AOV) and the number of customers per month** 

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/d5551d18-49e6-4c8f-9f10-8e50f1e14261)

**4.3. Customer segmentation by age and gender**
 
Continuing from the previous session, I'm still debating whether to include statistics for customers in groups other than those with completed orders. Because I don't have high confidence in the dataset's quality, including customers from other groups would require additional analysis of order cancellations/completions/refunds per group of customers.

Which age/gender groups have higher rates of order cancellations/completions/returns? Here, I'm looking at age/gender as factors influencing shopping behaviors without considering reasons for cancellations/returns because that information isn't included in the dataset.

Due to the dataset's practical limitations, delving deeply into this aspect for analysis isn't necessary right now. Therefore, I will proceed with querying the group of customers who have completed orders (status = Complete) => which involves joining with the ORDERS table.

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/fabc997e-d6ef-4c39-ac13-de0bb5b75e9d)

Customers aged from 12 to 61 show no significant differences in purchasing power based on age or gender.

**4.4. Customer segmentation by geography/country**

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/31315caa-4fc5-493b-9727-69a4cd74dba6)

**4.5. Customer segmentation by traffic source**

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/cfa8c0ed-27f8-4035-9cc4-ad0cd6415027)

**4.6. Statistical analysis of the top 5 most profitable products.**

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/088e7795-b2af-41b5-a959-eb2f6f65bb8f)

Only 22,000 out of 29,000 products have been sold in orders that were completed and created before July 2024.

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/bef2432e-951c-414e-91b4-422178a9ff05)

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/ebbc972f-5c12-454a-ba92-43400a5992ec)

The top-selling product with the highest profit is the AIR JORDAN DOMINATE SHORTS MENS 465071-100.

**4.7. Revenue up to the end of June for each category.**


![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/5874b73c-7193-40d5-8df1-f43b86699fd8)


## Cohort Analysis

```
with cte as (
select user_id, created_at, 
min(created_at) over(partition by user_id) as first_purchase from bigquery-public-data.thelook_ecommerce.orders
where status = 'Complete' and created_at between '2023-07-01' and '2024-07-01'),
cte2 as (
select *, format_date('%Y-%m', first_purchase) as month_year,
    (extract(year from created_at) - extract(year from first_purchase))*12 
    + extract(month from created_at) - extract(month from first_purchase) + 1 AS cohort_index
FROM  cte),
cte3 as (
select month_year, cohort_index, count(Distinct(user_id)) as total_users from cte2
group by month_year, cohort_index)
select month_year,
sum(Case when cohort_index = 1 then total_users else 0 end) as m1,
sum(Case when cohort_index = 2 then total_users else 0 end) as m2,
sum(Case when cohort_index = 3 then total_users else 0 end) as m3,
sum(Case when cohort_index = 4 then total_users else 0 end) as m4,
sum(Case when cohort_index = 5 then total_users else 0 end) as m5,
sum(Case when cohort_index = 6 then total_users else 0 end) as m6,
sum(Case when cohort_index = 7 then total_users else 0 end) as m7,
sum(Case when cohort_index = 8 then total_users else 0 end) as m8,
sum(Case when cohort_index = 9 then total_users else 0 end) as m9,
sum(Case when cohort_index = 10 then total_users else 0 end) as m10,
sum(Case when cohort_index = 11 then total_users else 0 end) as m11,
sum(Case when cohort_index = 12 then total_users else 0 end) as m12
from cte3
group by month_year
order by month_year
```

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/1d02ed1d-ee4b-4a05-aa8e-177b25b815f1)

RETENTION COHORT

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/eb68338c-6557-4b37-b453-1e6f42fb79b6)

After analyzing the dataset, it’s evident that the retention rate is low as a significant portion of users appear to engage with the platform only once or a few times within a short period and then do not return. This results in a high churn rate, with many users not making repeat purchases after their first transaction. I then identified the characteristics of churned customers:

a. I define that a customer is considered churned if they haven't made a purchase in the last six months.

b. Based on the dataset, I analyze churned customer characteristics:

- Demographic Analysis
  - Age: Check the age distribution of churned customers. Identify any age groups with a higher churn rate.
  - Gender: Compare churn rates between different genders.
  - Location: Analyze if churn rates vary significantly by geographical location.

- Behavioral Analysis
  - Purchase Frequency: Determine how often churned customers made purchases compared to active customers and identify any patterns in purchase frequency before churning.
  - Total Spend: Compare the total spend of churned customers with that of active customers. Higher spenders may require different retention strategies than lower spenders.
  - Order Value: Analyze the average order value of churned customers. Look for patterns in order size and frequency.

```
with cte as(
select a.user_id, a.gender, b.age, b.country, b.traffic_source, a.created_at,
max(a.created_at) over(partition by user_id) as last_purchase
from bigquery-public-data.thelook_ecommerce.orders as a
join bigquery-public-data.thelook_ecommerce.users as b
on a.user_id = b.id
where  a.status = 'Complete' and (a.created_at between '2023-07-01' and '2024-07-01')),
cte2 as(
select *, 
(extract(year from current_date) - extract(year from last_purchase))*12 
    + extract(month from current_date) - extract(month from last_purchase) + 1 as month from cte),
cte3 as(
select user_id, gender, age, country, traffic_source, last_purchase, month,
case when month > 6 then 1 else 0 end as churned_customer
from cte2)
select count(Distinct(user_id)) from cte3 where churned_customer = 1
``` 

There are 5885 churned users over a total of 13116 users who have maked a purchase in the last 12 months (44.87%).

```
with cte as(
select a.user_id, a.gender, b.age, b.country, b.traffic_source, a.created_at,
max(a.created_at) over(partition by user_id) as last_purchase
from bigquery-public-data.thelook_ecommerce.orders as a
join bigquery-public-data.thelook_ecommerce.users as b
on a.user_id = b.id
where  a.status = 'Complete' and (a.created_at between '2023-07-01' and '2024-07-01')),

cte2 as(
select *, 
(extract(year from current_date) - extract(year from last_purchase))*12 
    + extract(month from current_date) - extract(month from last_purchase) + 1 as month from cte),

cte3 as(
select user_id, gender, age, country, traffic_source, last_purchase, month,
case when month > 6 then 1 else 0 end as churned_customer
from cte2),

cte4 as(
select *,
case when age < 24 then '12-23_years_old'
when age between 24 and 34 then '24-34_years_old'
when age between 35 and 49 then '35-49_years_old'
else '24-34_years_old' end as age_group
 from cte3 where churned_customer = 1)

select age_group,
count(Distinct(user_id)) as churned_users from cte4
group by age_group
order by age_group
```

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/46249b6a-7b3b-4b9a-ba0f-802759f5f4e7)

There are no reported churned users in the 50-61 age group.

```
with cte as(
select a.user_id, a.gender, b.age, b.country, b.traffic_source, a.created_at,
max(a.created_at) over(partition by user_id) as last_purchase
from bigquery-public-data.thelook_ecommerce.orders as a
join bigquery-public-data.thelook_ecommerce.users as b
on a.user_id = b.id
where  a.status = 'Complete' and (a.created_at between '2023-07-01' and '2024-07-01')),

cte2 as(
select *, 
(extract(year from current_date) - extract(year from last_purchase))*12 
    + extract(month from current_date) - extract(month from last_purchase) + 1 as month from cte),

cte3 as(
select user_id, gender, age, country, traffic_source, last_purchase, month,
case when month > 6 then 1 else 0 end as churned_customer
from cte2)
select gender, count(Distinct(user_id)) as churned_users from cte3
group by gender
```

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/b8a4b0d1-9cee-4c35-9574-3ba909902e14)

Both genders exhibit a high rate, with approximately 60-61% of customers not returning.
The churn percentage is very similar between genders, with only a 1% difference, suggesting that gender alone may not be a significant factor in the churn rate.

 
```
with cte as(
select a.user_id, a.gender, b.age, b.country, b.traffic_source, a.created_at,
max(a.created_at) over(partition by user_id) as last_purchase
from bigquery-public-data.thelook_ecommerce.orders as a
join bigquery-public-data.thelook_ecommerce.users as b
on a.user_id = b.id
where  a.status = 'Complete' and (a.created_at between '2023-07-01' and '2024-07-01')),

cte2 as(
select *, 
(extract(year from current_date) - extract(year from last_purchase))*12 
    + extract(month from current_date) - extract(month from last_purchase) + 1 as month from cte),

cte3 as(
select user_id, gender, age, country, traffic_source, last_purchase, month,
case when month > 6 then 1 else 0 end as churned_customer
from cte2)

select country, count(Distinct(user_id)) as churned_customer from cte3
group by country
order by churned_customer desc
```

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/4ff49822-ad46-41ec-9867-66bd0034f85c)

China has the highest number of churned customers (1,991) among 14 countries which appear in this dataset, significantly more than the second-highest country, the United States (1.324), followed by Brazil, South Korea, the UK, France, Germany, etc.

```
with cte as(
select a.user_id, a.gender, b.age, b.country, b.traffic_source, a.created_at,
max(a.created_at) over(partition by user_id) as last_purchase
from bigquery-public-data.thelook_ecommerce.orders as a
join bigquery-public-data.thelook_ecommerce.users as b
on a.user_id = b.id
where  a.status = 'Complete' and (a.created_at between '2023-07-01' and '2024-07-01')),

cte2 as(
select *, 
(extract(year from current_date) - extract(year from last_purchase))*12 
    + extract(month from current_date) - extract(month from last_purchase) + 1 as month from cte),

cte3 as(
select user_id, gender, age, country, traffic_source, last_purchase, month,
case when month > 6 then 1 else 0 end as churned_customer
from cte2),

select churned_customer, count(*) as number_of_orders, 
count(distinct(user_id)) as number_of_users from cte3
group by churned_customer
```



```
with cte0 as(
select order_id, sum(sale_price) as order_value from bigquery-public-data.thelook_ecommerce.order_items 
group by order_id),

cte as(
select a.user_id, a.gender, b.age, b.country, b.traffic_source, a.created_at, c.*,
max(a.created_at) over(partition by user_id) as last_purchase
from bigquery-public-data.thelook_ecommerce.orders as a
join bigquery-public-data.thelook_ecommerce.users as b
on a.user_id = b.id
join cte0 as c
on c.order_id = a.order_id
where  a.status = 'Complete' and (a.created_at between '2023-07-01' and '2024-07-01')),

cte2 as(
select *, 
(extract(year from current_date) - extract(year from last_purchase))*12 
    + extract(month from current_date) - extract(month from last_purchase) + 1 as month from cte),

cte3 as(
select order_id, user_id, gender, age, country, traffic_source, last_purchase, month, order_value,
case when month > 6 then 1 else 0 end as churned_customer
from cte2),

cte4 as(
select *,
case when age < 24 then '12-23_years_old'
when age between 24 and 34 then '24-34_years_old'
when age between 35 and 49 then '35-49_years_old'
else '24-34_years_old' end as age_group
 from cte3 where churned_customer = 1)

select churned_customer, count(distinct(order_id)) as number_of_orders, 
count(distinct(user_id)) as number_of_users,
sum(order_value) as total_order_value,
sum(order_value)/count(distinct(order_id)) as average_order_value from cte3
group by churned_customer
```

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/9053f179-e58e-4243-a286-7a17b3c988b6)

