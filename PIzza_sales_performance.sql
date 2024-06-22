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

-- Explore dữ liệu

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

-- Top pizza's quantity by name, size
select pizza_name, pizza_size, sum(quantity)
from piz_sales
group by pizza_name, pizza_size
order by sum(quantity) desc
--- (hoặc
select pizza_name_id, sum(quantity)
from piz_sales
group by pizza_name_id
order by sum(quantity) desc)
	
=> "The Big Meat Pizza"	"S"
"The Thai Chicken Pizza" "L"
"The Five Cheese Pizza"	"L"

--Top pizza's quantity by category, size
select pizza_category, pizza_size, sum(quantity)
from piz_sales
group by pizza_category, pizza_size
order by sum(quantity) desc
=> "Classic"	"S"
"Veggie"	"L"
"Chicken"	"L"
	
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
sum(case when pizza_size = 'XXL' then quantity else 0 end) as size_XXL,	
sum(case when pizza_size = 'XL' then quantity else 0 end) as size_XL,	
sum(case when pizza_size = 'L' then quantity else 0 end) as size_L,
sum(case when pizza_size = 'M' then quantity else 0 end) as size_M,
sum(case when pizza_size = 'S' then quantity else 0 end) as size_S
from piz_sales

-- Pivot table total sales theo size
select 
sum(case when pizza_size = 'XXL' then total_price else 0 end) as size_XXL,	
sum(case when pizza_size = 'XL' then total_price else 0 end) as size_XL,	
sum(case when pizza_size = 'L' then total_price else 0 end) as size_L,
sum(case when pizza_size = 'M' then total_price else 0 end) as size_M,
sum(case when pizza_size = 'S' then total_price else 0 end) as size_S
from piz_sales

-- Tổng số order, tổng lượng order và doanh thu theo size
select 
case 
when pizza_size = 'XXL' then 'size_XXL'
when pizza_size = 'XL' then 'size_XL'
when pizza_size = 'L' then 'size_L'
when pizza_size = 'M' then 'size_M'
else 'size_S'
end size_category,
count(*) as so_luong_order, sum(quantity) as tong_so_luong,
sum(total_price) as tong_doanh_thu
from piz_sales
group by size_category
order by sum(quantity) desc
=>> size L
--
-- Phân bổ doanh thu, quantity của các pizza name theo S, M, L, XL, XXL
select pizza_category,
sum(case when pizza_size = 'XXL' then total_price else 0 end) as size_XXL,
sum(case when pizza_size = 'XL' then total_price else 0 end) as size_XL,
sum(case when pizza_size = 'L' then total_price else 0 end) as size_L,
sum(case when pizza_size = 'M' then total_price else 0 end) as size_M,
sum(case when pizza_size = 'S' then total_price else 0 end) as size_S
from piz_sales
group by pizza_category

select pizza_category,
sum(case when pizza_size = 'XXL' then quantity else 0 end) as size_XXL,
sum(case when pizza_size = 'XL' then quantity else 0 end) as size_XL,
sum(case when pizza_size = 'L' then quantity else 0 end) as size_L,
sum(case when pizza_size = 'M' then quantity else 0 end) as size_M,
sum(case when pizza_size = 'S' then quantity else 0 end) as size_S
from piz_sales
group by pizza_category

-- Quantity theo month

select distinct(extract(year from order_date)) as year
from piz_sales => chỉ có số liệu năm 2015

select extract(month from order_date) as month, 
sum(quantity) as so_luong, sum(total_price) as doanh_thu from piz_sales
group by extract(month from order_date)
order by sum(quantity) desc 
=> Tháng 7 có số lượng lớn nhất

-- Quantity theo day of week
select extract(DOW from order_date) as day, 
sum(quantity) as so_luong, sum(total_price) as doanh_thu from piz_sales
group by extract(DOW from order_date)
order by sum(quantity) desc
=> Thứ 6 và thứ 7
