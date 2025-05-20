-- Таблица purchase_order_details
SELECT * FROM purchase_order_details;

/* 1. Для каждого заказа order_id выведите минимальный, максмальный и средний unit_cost */
SELECT 
	purchase_order_id,
	MIN(unit_cost) OVER() AS min_init_cost,
    MAX(unit_cost) OVER() AS max_init_cost,
    AVG(unit_cost) OVER() AS avg_init_cost
FROM 
	purchase_order_details;

/* 2. Оставьте только уникальные строки из предыдущего запроса */
SELECT 
	purchase_order_id,
	MIN(unit_cost) AS min_init_cost,
    MAX(unit_cost) AS max_init_cost,
    AVG(unit_cost) AS avg_init_cost
FROM 
	purchase_order_details
GROUP BY 
	purchase_order_id;

/* Посчитайте стоимость продукта в заказе как quantity*unit_cost.
Выведите суммарную стоимость продуктов с помощью оконной функции. */
SELECT 
	purchase_order_id,
	quantity,
    unit_cost,
    quantity * unit_cost AS multiply_quantity_unit_cost,
	SUM(quantity * unit_cost) OVER(PARTITION BY purchase_order_id) AS sum_quantity_unit_cost 
FROM 
	purchase_order_details;

-- Сделайте то же самое с помощью GROUP BY
SELECT 
	purchase_order_id,
	quantity * unit_cost AS multiply_quantity_unit_cost
FROM 
	purchase_order_details
GROUP BY 
	purchase_order_id;
    
/* Посчитайте количество заказов по дате получения и posted_to_inventory.
Если оно превышает 1 - то выведите '>1' в противном случае '=1'
Выведите purchase_order_id, date_received и вычисленный столбец */
SELECT
	purchase_order_id,
    date_received,
    COUNT(date_received) OVER() AS count_date_received,
    CASE 
		WHEN COUNT(*) OVER (PARTITION BY posted_to_inventory) > 1 THEN '>1'
		ELSE '=1'
	END AS condition_posted_to_inventory
FROM purchase_order_details;