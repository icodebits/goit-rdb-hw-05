-- p1 -- ********************************************************************
SELECT 
    order_details.*, 
    (SELECT orders.customer_id 
     FROM orders 
     WHERE orders.id = order_details.order_id) AS customer_id
FROM 
    order_details;

-- p2 -- ********************************************************************
SELECT 
    * 
FROM 
    order_details
WHERE 
    order_id IN (
        SELECT id 
        FROM orders 
        WHERE shipper_id = 3
    );

-- p3 -- ********************************************************************
SELECT 
    order_id, 
    AVG(quantity) AS avg_quantity
FROM 
    (SELECT order_id, quantity 
     FROM order_details 
     WHERE quantity > 10) AS filtered_order_details
GROUP BY 
    order_id;

-- p4 -- ********************************************************************
WITH temp AS (
    SELECT order_id, quantity 
    FROM order_details 
    WHERE quantity > 10
)
SELECT 
    order_id, 
    AVG(quantity) AS avg_quantity
FROM 
    temp
GROUP BY 
    order_id;

-- p5 -- ********************************************************************
-- Встановлюємо новий роздільник
DELIMITER //

-- Видаляємо функцію, якщо вона вже існує
DROP FUNCTION IF EXISTS divide_numbers //

-- Створюємо функцію
CREATE FUNCTION divide_numbers(a FLOAT, b FLOAT)
RETURNS FLOAT
DETERMINISTIC
BEGIN
    RETURN a / b;
END //

-- Повертаємо роздільник на стандартний
DELIMITER ;

-- Застосовуємо функцію
SELECT 
    order_id,
    quantity,
    divide_numbers(quantity, 2.5) AS divided_quantity
FROM 
    order_details;
