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
