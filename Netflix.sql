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
