with cte as
(select *, 
case when position('//' in Title) = 0 then Title else
left (Title,(position('//' in Title)-1)) end as Eng_Title
	from Netflix),
-- Tách season
cte2 as
(select *, 
case when position(': Season' in Title) = 0 then 'Movie' else
'Series' end as film_Category
	from cte),
-- Tách title
cte3 as
(select *, 
case when film_category = 'Movie' then eng_title 
else left(eng_title, position(': Season' in Title)-1) end as only_title
	from cte2)
-- kiểm tra xem còn sót season trong tên không
select title, eng_title, only_title, hours_viewed
from cte3
where only_title like '%Season%' or only_title like '%season%'
order by hours_viewed desc


with cte as
(select *, 
case when position('//' in Title) = 0 then Title else
left (Title,(position('//' in Title)-1)) end as Eng_Title
	from Netflix),
-- Tách season
cte2 as
(select *, 
case when position(': Season' in Title) = 0 then 'Movie' else
'Series' end as film_Category
	from cte)
-- Tách title
select  
case when film_category = 'Movie' then eng_title 
else left(eng_title, position(': Season' in Title)-1) end as only_title,
avaiable_globally, release_date, hours_viewed, film_category
from cte2


-- Phân tích 1: Số lượng phim được phát hành global và không global
/* select available_globally, count(available_globally),sum(hours_viewed)
from cte3
group by available_globally 
-- Phân tích 2: Phân tích số lượng giờ view theo film
select only_title, count(only_title), sum(hours_viewed)
from cte3
group by only_title
order by sum(hours_viewed) desc => "Ginny & Georgia" 
-- Phân tích 3: 
select * from cte3
where eng_title like '%Season%' and film_category like 'Movie'	
order by eng_title  ---=> "The Night Agent: Season 1" */
-- 


with cte as
(select *, 
case when position('//' in Title) = 0 then Title else
left (Title,(position('//' in Title)-1)) end as Eng_Title
	from Netflix),
-- Tách title
cte2 as (
select eng_title,
case when (position(':' in Title)) = 0 then eng_title 
else left(eng_title, position(':' in Title)-1) end as only_title,
available_globally, release_date, hours_viewed
from cte)

select *,
row_number() over(partition by only_title order by only_title) 
	from cte2
where only_Title like 'I%'
order by row_number() over(partition by only_title order by only_title) desc
