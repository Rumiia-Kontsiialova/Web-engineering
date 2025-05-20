/* 1. Вывести названия продуктов таблица products, 
включая количество заказанных единиц quantity для каждого продукта таблица order_details.
Решить задачу с помощью cte и подзапроса */
WITH product_quantities AS (
SELECT product_id, SUM(quantity) AS total_quantity
FROM order_details
GROUP BY product_id )
SELECT 
(SELECT 
	product_name
FROM
	products p
WHERE
	p.id = pq.product_id) AS product_name,
    pq.total_quantity
FROM
    product_quantities pq;

/* 2.  Найти все заказы таблица orders, сделанные после даты самого первого заказа клиента Lee таблица customers. */
SELECT * FROM orders
WHERE
    order_date > (SELECT 
		MIN(o.order_date)
FROM
	orders o
JOIN
	customers c ON o.customer_id = c.id
WHERE
	c.last_name = 'Lee');
    
/* 3. Найти все продукты таблицы  products c максимальным target_level */
SELECT * FROM products
WHERE
    target_level = (SELECT 
		MAX(target_level)
FROM
	products);