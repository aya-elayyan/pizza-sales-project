create database pizza;
use pizza;
show tables;
alter table `pizza_sales excel file` rename pizza_orders;
select * from pizza_orders;
-- DATA CLEANING :


-- to make sure we dont hve duplicates in the id columns:

select pizza_id, count(*)
from pizza_orders
group by pizza_id
having count(*) > 1;


-- lets modify order_date to date:

alter table pizza_orders
modify column order_date date;

-- lets modify order_time to time:

select order_time from pizza_orders;

select str_to_date(order_time, '%H:%i:%s'),order_time
from pizza_orders;

set sql_safe_updates=0;

update pizza_orders
set order_time= str_to_date(order_time, '%H:%i:%s');

alter table pizza_orders
modify column order_time time;

-- lets add a column that tells the time of the day in words:

select order_time, case when order_time <= '12:00:00' then 'morning'
when order_time>'12:00:00' and order_time <='18:00:00' then 'afternoon'
else 'evening'
end
from pizza_orders;


alter table pizza_orders
add column time_inwords text;

update pizza_orders
set time_inwords= case when order_time <= '12:00:00' then 'morning'
when order_time>'12:00:00' and order_time <='18:00:00' then 'afternoon'
else 'evening'
end;

-- lets add column that counts the ingredients:

select pizza_ingredients, LENGTH(pizza_ingredients) - LENGTH(REPLACE(pizza_ingredients, ',', ''))+1
from pizza_orders;

alter table pizza_orders 
add column ingtredients_num int;

update pizza_orders
set ingtredients_num= LENGTH(pizza_ingredients) - LENGTH(REPLACE(pizza_ingredients, ',', ''))+1;

select * from pizza_orders;