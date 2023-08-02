use pizza;


select dayname(order_date) , count(*)
from pizza_orders
group by dayname(order_date);