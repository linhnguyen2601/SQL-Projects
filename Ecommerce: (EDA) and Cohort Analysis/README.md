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

**Bảng orders**

select count(*)
 from bigquery-public-data.thelook_ecommerce.orders
 where order_id is null => 0

select count(*)
 from bigquery-public-data.thelook_ecommerce.orders
 where user_id is null => 0

 select count(*)
 from bigquery-public-data.thelook_ecommerce.orders
 where status is null => 0

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
 =>> null: 113097

 ![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/035f5e73-a2bc-4d34-a6bf-66011d6c5a83)

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

 => bảng orders có 3 cột chứ gt null là returned_at, shipped_at, delivered_at

**Bảng order_items**

 select count(*) from bigquery-public-data.thelook_ecommerce.order_items
 where id is null
 or order_id is null
 or user_id is null
 or product_id is null
 or inventory_item_id is null
 or status is null
 or created_at is null

=> không có giá trị null

select count(*) from bigquery-public-data.thelook_ecommerce.order_items
shipped_at is null

Tương tự bảng trên có returned_at, shipped_at, delivered_at có gt null

**Bảng Products**

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
 
**3. Check Duplicates**

## Data exploratory

Determine dataset's time period:
select min(created_at) as start_period, max(created_at) as end_period
 from bigquery-public-data.thelook_ecommerce.orders

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/e67de495-e1bb-4ee3-8226-e74d9b0c1b77)

select count(distinct(order_id)) from bigquery-public-data.thelook_ecommerce.orders
where created_at < '2024-07-01'

=>> 120806 orders

select count(distinct(order_id)) from bigquery-public-data.thelook_ecommerce.order_items 
where created_at < '2024-07-01'

=> 120735 orders

select status, count(distinct(order_id)) from bigquery-public-data.thelook_ecommerce.orders
where created_at < '2024-07-01'
group by status

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/58fb898d-c766-437c-9142-ceac72c2285d)

Từ bảng này t nhận thấy tỷ lệ đơn hàng Complete chỉ chiêm ~ 25% tổng số đơn hàng. Điều này dẫn tới các nghi vấn sau:

- Có nhiều đơn hàng phát sinh trong các tháng gần dây nên trạng thái processing và shipped đang cao?
- Nếu không phải thì do các đơn hàng chưa được cập nhật trạng thái?
- 


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


Nhiều đơn hàng từ 1/2019 vẫn đang trong tình trạng shipped nhưng chưa được hoàn thành?

Vì không rõ outcome của các đơn hàng này có complete hay không nên I decided to focus on "Complete" orders, ignoring the Shipped and Processing as there is no stakeholder to clarify this point. 

Bảng order_items

select count(Distinct(order_id)) from bigquery-public-data.thelook_ecommerce.order_items
where order_id in (select order_id from bigquery-public-data.thelook_ecommerce.orders where status = 'Complete' and created_at < '2024-07-01')

=> 30514 orders => đúng so với bảng orders

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

select a.order_id, a.created_at, b.order_id, b.created_at 
from bigquery-public-data.thelook_ecommerce.orders as a
join bigquery-public-data.thelook_ecommerce.order_items as b
on a.order_id = b.order_id
order by a.order_id

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/b755a4d3-4f53-4b0e-a80d-27f4a6d4426b)

Thời gian đơn hàng đc tạo và thời gian từng item trong đơn hàng được tạo là khác nhau, như vậy mình nghi ngờ thêm về tính chính xác của cột created_at của bảng order_items vì ở bảng orders không xảy ra tình trạng ngày ở cột created_at sau ngày shipped_at nhưng ở bảng order_items thì tình trạng này xảy ra khá nhiều (35865 dòng/trên tổng 181427 dòng ~ gần 20%):

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/934a54eb-a64a-473c-bddc-d3767ed99a2f)

chưa kể cột shipped_at còn bị null khá nhiều (63K dòng)

Vì vậy mình sẽ sử dụng cột created_at của bảng orders khi join 2 bảng orders và order_item

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




