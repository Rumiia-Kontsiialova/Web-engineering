-- Таблица order_details
SELECT * FROM order_details;

/* 1. Для каждого product_id выведите inventory_id,
а также предыдущий и последующей inventory_id по убыванию quantity */

SELECT product_id,
	inventory_id,
    quantity,
    LAG(inventory_id) OVER (ORDER BY quantity DESC) AS prev_inventory_id,
	LEAD(inventory_id) OVER (ORDER BY quantity DESC) AS next_inventory_id
FROM order_details;

/* 2. Выведите максимальный и минимальный unit_price для каждого order_id с помощью функции FIRST VALUE. 
Вывести order_id и полученные значения */

SELECT order_id,
	unit_price,
	FIRST_VALUE(unit_price) OVER (PARTITION BY order_id ORDER BY unit_price ASC) AS min_unit_price,
    FIRST_VALUE(unit_price) OVER (PARTITION BY order_id ORDER BY unit_price DESC) AS max_unit_price
FROM order_details;

/* 3 Выведите order_id и столбец с разницей между unit_price для каждого заказа 
и минимальным unit_price в рамках одного заказа. 
Задачу решить двумя способами - с помощью First VAlue и MIN */

-- с помощью FIRST_VALUE
SELECT order_id,
	unit_price,
    unit_price - FIRST_VALUE(unit_price) OVER (PARTITION BY order_id) AS diff_unit_price_with_first_value
FROM order_details;

-- с помощью MIN
SELECT order_id,
	unit_price,
    unit_price - MIN(unit_price) OVER (PARTITION BY order_id) AS diff_unit_price_with_min
FROM order_details;

/* 4. Присвойте ранг каждой строке используя RANK по убыванию quantity */

SELECT quantity,
	RANK() OVER (ORDER BY quantity DESC) AS rank_quantity
FROM order_details;

/* 5. Из предыдущего запроса выберите только строки с рангом до 10 включительно */

SELECT quantity,
	RANK() OVER (ORDER BY quantity DESC) AS rank_quantity
FROM order_details
LIMIT 10;
