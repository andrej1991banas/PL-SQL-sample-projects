-- Method 1: Using LEFT JOIN
SELECT p.product_id, p.product_name
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.order_id IS NULL;

-- Method 2: Using NOT EXISTS
SELECT p.product_id, p.product_name
FROM products p
WHERE NOT EXISTS (
    SELECT 1 
    FROM order_items oi 
    WHERE oi.product_id = p.product_id
);

-- Method 3: Using NOT IN
SELECT p.product_id, p.product_name
FROM products p
WHERE p.product_id NOT IN (
    SELECT product_id 
    FROM order_items
    WHERE product_id IS NOT NULL
);

-- Method 4: Using LEFT JOIN with orders table (if you need order details)
SELECT p.product_id, p.product_name
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
LEFT JOIN orders o ON oi.order_id = o.order_id
WHERE oi.order_id IS NULL;


---- Sample data visualization
Products Table        OrderItems Table        After LEFT JOIN
--------------       ----------------        ---------------
product_id: 1        order_id: 100          product_id: 1, order_id: 100
product_id: 2        product_id: 1          product_id: 2, order_id: NULL
product_id: 3        product_id: 4          product_id: 3, order_id: NULL
product_id: 4                               product_id: 4, order_id: 100