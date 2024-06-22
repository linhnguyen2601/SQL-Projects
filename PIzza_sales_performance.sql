-- Tạo bảng
CREATE TABLE Piz_sales
	(pizza_id int primary key,
	order_id int,
	pizza_name_id varchar(25),
	quantity int,
	order_date date,
	order_time time,
	unit_price float,
	total_price float,
	pizza_size varchar(5),
	pizza_category varchar(25),
	pizza_ingredients varchar(150),
	pizza_name varchar(45)
	)

-- Import dữ liệu
copy Piz_sales from 'C:\Program Files\PostgreSQL\15\data\pizza_sales_excel_file.csv' header csv

-- 
select distinct(pizza_name) from piz_sales => 32 loại pizza

select 
pizza_name, sum(total_price), sum(quantity)
from piz_sales
group by pizza_name
order by sum(total_price) desc

=> top 5 by total_sales
"The Thai Chicken Pizza"
"The Barbecue Chicken Pizza"
"The California Chicken Pizza"
"The Classic Deluxe Pizza"
"The Spicy Italian Pizza"

=> top 5 by quantity
"The Classic Deluxe Pizza"
"The Barbecue Chicken Pizza"
"The Hawaiian Pizza"
"The Pepperoni Pizza"
"The Thai Chicken Pizza"

select 
pizza_category, sum(total_price), sum(quantity), count(distinct(pizza_name))
from piz_sales
group by pizza_category
order by sum(quantity) desc
=> 
"Classic"
"Supreme"
"Veggie"
"Chicken"

-- Pivot table quantity  theo size
select 
sum(case when pizza_size = 'L' then quantity else 0 end) as size_L,
sum(case when pizza_size = 'M' then quantity else 0 end) as size_M,
sum(case when pizza_size = 'S' then quantity else 0 end) as size_S
from piz_sales

-- Pivot table total sales theo size
select 
sum(case when pizza_size = 'L' then total_price else 0 end) as size_L,
sum(case when pizza_size = 'M' then total_price else 0 end) as size_M,
sum(case when pizza_size = 'S' then total_price else 0 end) as size_S
from piz_sales

--
select 
case when pizza_size = 'L' then 'size_L'
when pizza_size = 'M' then 'size_M'
else 'size_S'
end size_category,
count(*) as so_luong_order, sum(quantity) as tong_so_luong,
sum(total_price) as tong_doanh_thu
from piz_sales
group by size_category
