# theLook eCommerce: Exploratory Data Analysis (EDA) and Cohort Analysis 

## Overview
Dataset in BigQuery
TheLook is a fictitious eCommerce clothing site developed by the Looker team. The dataset contains information >about customers, products, orders, logistics, web events and digital marketing campaigns. The contents of this >dataset are synthetic, and are provided to industry practitioners for the purpose of product discovery, testing, and >evaluation.

I use the Big Query to do the project with SQL:
Datasource: https://console.cloud.google.com/bigquery?p=bigquery-public-data&d=thelook_ecommerce&page=dataset&project=project-2-422702&ws=!1m15!1m4!1m3!1sproject-2-422702!2sbquxjob_63602b4b_1907d32f234!3sUS!1m4!4m3!1sbigquery-public-data!2sthelook_ecommerce!3sdistribution_centers!1m4!4m3!1sbigquery-public-data!2sthelook_ecommerce!3sproducts
but you can download it on Kaggle: https://www.kaggle.com/datasets/mustafakeser4/looker-ecommerce-bigquery-dataset/code

**Conducting the dataset in the period from 2019-01-13 - 20224-06-30**

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

## Data cleaning

**1. Check NULL**

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
 
**3. Check Duplicates**

## Data exploratory

| # | Orders_table |   Order_items_table |
| --- | --- | --- |   
| Total orders | 120386 | 120314 |

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/a6fc2d26-507f-4847-8d6c-8c74fc4f052f)

After cross-check data from two tables ORDERS and ORDER_ITEMS, I discovered that the number of total orders and the number of orders in each category are different across two tables when appply the condition that I consider order created before July 2024. The reason I chosed the Column Created_at is because that column hss no null value.

I continue to check if there is any difference between the created_at column in the ORDERS table and ORDER_ITEMS table, considering the fact that the data might be recorded with difference logic. 

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/b755a4d3-4f53-4b0e-a80d-27f4a6d4426b)

Thời gian đơn hàng đc tạo và thời gian từng item trong đơn hàng được tạo là khác nhau, như vậy mình nghi ngờ thêm về tính chính xác của cột created_at của bảng order_items vì ở bảng orders không xảy ra tình trạng ngày ở cột created_at sau ngày shipped_at nhưng ở bảng order_items thì tình trạng này xảy ra khá nhiều (35865 dòng/trên tổng 181427 dòng ~ gần 20%):

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/934a54eb-a64a-473c-bddc-d3767ed99a2f)

chưa kể cột shipped_at còn bị null khá nhiều (63K dòng)

Vì vậy mình sẽ sử dụng cột created_at của bảng orders khi join 2 bảng orders và order_item


Từ bảng này t nhận thấy tỷ lệ đơn hàng Complete chỉ chiêm ~ 25% tổng số đơn hàng. Điều này dẫn tới các nghi vấn sau:

- Có nhiều đơn hàng phát sinh trong các tháng gần dây nên trạng thái processing và shipped đang cao?
- Nếu không phải thì do các đơn hàng chưa được cập nhật trạng thái?

select 
format_date('%Y-%m',created_at) as month_year,
avg(Distinct(order_id)) as total_orders,
count(distinct(user_id)) as total_users
from bigquery-public-data.thelook_ecommerce.orders
where status = 'Processing' and created_at < '2024-07-01'
group by month_year
order by month_year

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/aa16d8b1-c272-4a2b-b441-3e0bac79680e)

Có nhiều đơn hàng từ tháng 1/2019 vẫn đang processing?

select 
format_date('%Y-%m',created_at) as month_year,
avg(Distinct(order_id)) as total_orders,
count(distinct(user_id)) as total_users
from bigquery-public-data.thelook_ecommerce.orders
where status = 'Shipped' and created_at < '2024-07-01'
group by month_year
order by month_year

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/0f9eb180-6531-4684-ab50-e8b6747b67e2)

Nhiều đơn hàng từ 1/2019 vẫn đang trong tình trạng shipped nhưng chưa được hoàn thành?

Vì không rõ outcome của các đơn hàng này có complete hay không nên I decided to focus on "Complete" orders, ignoring the Shipped and Processing as there is no stakeholder to clarify this point. 

Bảng order_items

Tuy nhiên, tôi phát hiện bảng này xuất hiện các order_item được record về tháng-năm created at khác nhau sau khi chạy lệnh kiểm tra cho công thức để xác định số order mỗi tháng ở bảng order_items

with cte as (
select format_date('%Y-%m',created_at) as month_year,
count(distinct(order_id)) as no_orders
from bigquery-public-data.thelook_ecommerce.order_items
where order_id in (select order_id from bigquery-public-data.thelook_ecommerce.orders where status = 'Complete' and created_at < '2024-07-01')
group by month_year
order by month_year desc)

select sum(no_orders) from cte

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/e4170594-0c4f-4651-bb57-e9aba70e14e0)


select 
distinct(order_id), count(distinct(format_date('%Y-%m',created_at))) as num
from bigquery-public-data.thelook_ecommerce.order_items
where order_id in (select order_id from bigquery-public-data.thelook_ecommerce.orders where status = 'Complete' and created_at < '2024-07-01')
group by order_id
having num > 1

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/14272819-3503-41ff-a90f-af470de9e45e)

=> xuất hiện 616 kết quả

Chạy lại bảng order_items với các kết quả trên:

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/ecb91038-3770-4eeb-97cd-41f2d1b33ba5)

Nhận xét có các record cùng số order, cùng user_id nhưng với các product khác nhau thì lại được tạo ở các ngày (created_at) khác nhau và thậm chí là khác tháng, có những order_item line mà ở đó, ngày created_at còn sau ngày được ship đi

=> như vậy nếu thống kê theo số order của từng tháng sẽ không chính xác khi chạy hàm distinct.

Như vậy lại quay ra nghi ngờ tính chính xác của cột created_at trong khi cột này là cột duy nhất không bị nhiều giá trị null như các cột ngày tháng còn lại như shipped_at, delivered_at và returned_at.

Mình sẽ check kĩ hơn cột này để xem còn các order mà bị created_at các ngày khác nhau hay không. Ở trên là mới check sơ qua về việc khác tháng. hic

select 
distinct(order_id), count(distinct(format_date('%Y-%m-%d',created_at))) as num
from bigquery-public-data.thelook_ecommerce.order_items
where order_id in (select order_id from bigquery-public-data.thelook_ecommerce.orders where status = 'Complete' and created_at < '2024-07-01')
group by order_id
having num > 1

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/c3f15d0f-0273-4400-b026-73eafa3a32e7)

Đúng vậy, không quá ngạc nhiên chúng ta ra 7887 order_id mà có các order_item bị created_at ở các ngày khác nhau và tương tự như phát hiện ở trên, nhiều trường hợp các order_id này có created_at sau ngày shipped_at

with cte as (
select 
distinct(order_id), count(distinct(format_date('%Y-%m-%d',created_at))) as num
from bigquery-public-data.thelook_ecommerce.order_items
where order_id in (select order_id from bigquery-public-data.thelook_ecommerce.orders where status = 'Complete' and created_at < '2024-07-01')
group by order_id
having num > 1)

select * from bigquery-public-data.thelook_ecommerce.order_items 
where order_id in (Select order_id from cte)
order by order_id, created_at

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/842e140f-47e5-458f-a66e-35e3fd30acc9)

Rất may mắn là ở đây không có dòng nào mà cột shipped_at bị null, vậy nếu để sửa dữ liệu này (trong trường hợp ta chấp nhân các record bị sai là đơn giản là bị recorded sai) thì có thể sử dụng ngày min(created_at) group by order_id để apply cho các ngày khác cùng 1 order_id 

1 phát hiện khác nữa khi join hai bảng orders và order_items:

select a.order_id, a.created_at, b.order_id
from bigquery-public-data.thelook_ecommerce.orders as a
join bigquery-public-data.thelook_ecommerce.order_items as b
on a.order_id = b.order_id
order by a.order_id


**1. The number of completed orders and user each month**

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/76b2dd76-4872-4549-8e75-2cf09ac3d2d7)

we only consider orders with status = 'Complete'

select count(Distinct(order_id)) as total_order,
count(distinct(user_id)) as total_users from bigquery-public-data.thelook_ecommerce.orders
where status = 'Complete' and created_at < '2024-07-01'

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/098aa9cb-9c8d-4567-8b0a-034414b81956)

select 
format_date('%Y-%m',created_at) as month_year,
count(Distinct(order_id)) as total_orders,
count(distinct(user_id)) as total_users
from bigquery-public-data.thelook_ecommerce.orders
where status = 'Complete' and created_at < '2024-07-01'
group by month_year
order by month_year desc

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/4b5b9436-e885-4e3f-950d-651f1f7132b2)
Number of orders and users increased month after month

2. Giá trị đơn hàng trung bình (AOV) và số lượng khách hàng mỗi tháng
Thống kê giá trị đơn hàng trung bình và tổng số người dùng khác nhau mỗi tháng 
( Từ 1/2019-6/2024)

select a.order_id, a.created_at, b.user_id, b.product_id, b.sale_price
from bigquery-public-data.thelook_ecommerce.orders as a
join bigquery-public-data.thelook_ecommerce.order_items as b
on a.order_id = b.order_id
where a.status = 'Complete' and a.created_at < '2024-07-01'
order by a.order_id

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/659a932d-1926-45b8-a57c-972ef862317f)


with cte as (
select a.order_id, a.created_at, b.user_id, b.product_id, b.sale_price
from bigquery-public-data.thelook_ecommerce.orders as a
join bigquery-public-data.thelook_ecommerce.order_items as b
on a.order_id = b.order_id
where a.status = 'Complete' and a.created_at < '2024-07-01'
order by a.order_id)

select format_date('%Y-%m', created_at) as month_year,
sum(sale_price)/count(distinct(order_id)) as AOV,
count(distinct(user_id)) as user_number from cte
group by month_year
order by month_year desc

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/d5551d18-49e6-4c8f-9f10-8e50f1e14261)

3. Nhóm khách hàng theo độ tuổi
Tìm các khách hàng có trẻ tuổi nhất và lớn tuổi nhất theo từng giới tính

Tiếp tục buổi hôm trước, mình vẫn đang phân vân về việc có thống kê khách hàng thuộc các nhóm khác ngoài nhóm có đơn hàng complete hay không. Vì thực tế mình k đánh giá cao chất lượng của dataset này. Nếu đưa khách hàng thuộc các nhóm khác vào vậy thì thường sẽ cần phải phân tích thêm với mỗi 1 nhóm các đơn hàng có trạng thái hủy/hoàn thành, phân bố nhóm khách hàng sẽ như thế nào.

NHững nhóm tuổi/giới tính nào có tỷ lệ hủy đơn/hoàn tất đơn/trả đơn hàng cao hơn. Ở đây đang tìm điểm xem xét là độ tuổi/giới tính có liên quan đến xu hướng, hành vi mua hàng không mà chưa xét đến lí do hủy đơn/hoàn hàng vì các thông tin đó không được đưa vào trong dataset.

Vì tính thực tế của dữ liệu không có nên việc nghiên cứu sâu vào khía cạnh này để đưa ra phân tích là chưa cần thiết, vì vậy mình sẽ tiến hành query với nhóm đối tượng khách hàng đã hoàn thành đơn hàng (có status = Complete) => phải nối với bảng orders

select age, 
sum(case when gender = 'M' then 1 else 0 end) as Male,
sum(case when gender = 'F' then 1 else 0 end) as Female,
count(id)  from bigquery-public-data.thelook_ecommerce.users
where id in (Select user_id from bigquery-public-data.thelook_ecommerce.orders where status = 'Complete' and created_at < '2024-07-01') 
group by age
order by age

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/fabc997e-d6ef-4c39-ac13-de0bb5b75e9d)

Độ tuổi KH từ 12-61

4. Theo geography/country

select country, 
sum(case when gender = 'M' then 1 else 0 end) as Male,
sum(case when gender = 'F' then 1 else 0 end) as Female,
count(id) as total from bigquery-public-data.thelook_ecommerce.users
where id in (Select user_id from bigquery-public-data.thelook_ecommerce.orders where status = 'Complete' and created_at < '2024-07-01') 
group by country
order by total desc

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/31315caa-4fc5-493b-9727-69a4cd74dba6)

5. Theo traffic source

select traffic_source, 
sum(case when gender = 'M' then 1 else 0 end) as Male,
sum(case when gender = 'F' then 1 else 0 end) as Female,
count(id) as total from bigquery-public-data.thelook_ecommerce.users
where id in (Select user_id from bigquery-public-data.thelook_ecommerce.orders where status = 'Complete' and created_at < '2024-07-01') 
group by traffic_source
order by total desc

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



