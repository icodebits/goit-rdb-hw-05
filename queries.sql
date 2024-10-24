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
