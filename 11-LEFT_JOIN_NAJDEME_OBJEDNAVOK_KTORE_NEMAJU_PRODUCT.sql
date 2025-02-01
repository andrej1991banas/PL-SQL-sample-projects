-- Find products that have never been ordered
select p.product_id,
       p.product_name
  from products p
  left join order_items oi
on p.product_id = oi.product_id
 where oi.order_id is null;

--zmazeme product_id z objednavky cislo 7
--najprv vypneme constraint, ze product is not null
-- Find orders that don't have any products
select o.order_id
  from orders o
  left join order_items oi
on o.order_id = oi.order_id
 where oi.product_id is null;

-- Optional: More detailed version showing order details
select o.order_id,
       o.order_date, -- add other order columns you need
       count(oi.product_id) as number_of_products
  from orders o
  left join order_items oi
on o.order_id = oi.order_id
 group by o.order_id,
          o.order_date
having count(oi.product_id) = 0;