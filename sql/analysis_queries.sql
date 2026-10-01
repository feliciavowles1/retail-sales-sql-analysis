SELECT
    o.order_id,
    o.order_date,
    o.order_status,
    c.first_name,
    c.last_name,
    p.product_name,
    p.category,
    oi.quantity,
    oi.unit_price
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON oi.product_id = p.product_id
ORDER BY o.order_id;

SELECT
    o.order_id,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    ROUND(oi.quantity * oi.unit_price, 2) AS line_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'Completed'
ORDER BY o.order_id;

SELECT
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed';

SELECT
    p.product_name,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS product_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'Completed'
GROUP BY p.product_id, p.product_name
ORDER BY product_revenue DESC;

SELECT
    p.product_name,
    SUM(oi.quantity) AS units_sold
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'Completed'
GROUP BY p.product_id, p.product_name
ORDER BY units_sold DESC;

SELECT
    p.category,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS category_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'Completed'
GROUP BY p.category
ORDER BY category_revenue DESC;

SELECT
    ROUND(AVG(order_total), 2) AS average_order_value
FROM (
    SELECT
        o.order_id,
        SUM(oi.quantity * oi.unit_price) AS order_total
    FROM orders AS o
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY o.order_id
);

SELECT
    strftime('%Y-%m', o.order_date) AS sales_month,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS monthly_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY sales_month
ORDER BY sales_month;

SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(DISTINCT o.order_id) AS completed_orders,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS customer_revenue
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY customer_revenue DESC;

SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(o.order_id) AS completed_orders
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
    AND o.order_status = 'Completed'
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(o.order_id) = 0;

SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(o.order_id) AS completed_orders
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(o.order_id) > 1
ORDER BY completed_orders DESC, customer_name;

SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(DISTINCT o.order_id) AS completed_orders,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue,
    ROUND(
        SUM(oi.quantity * oi.unit_price) / COUNT(DISTINCT o.order_id),
        2
    ) AS avg_revenue_per_order
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY avg_revenue_per_order DESC;

SELECT
    order_status,
    COUNT(*) AS order_count,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders),
        2
    ) AS percentage_of_orders
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;

SELECT
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS cancelled_order_value
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Cancelled';

SELECT
    p.product_name,
    SUM(oi.quantity) AS cancelled_units,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS cancelled_value
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'Cancelled'
GROUP BY p.product_id, p.product_name
ORDER BY cancelled_value DESC;

SELECT
    c.state,
    COUNT(DISTINCT o.order_id) AS completed_orders,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS state_revenue
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY c.state
ORDER BY state_revenue DESC;

SELECT
    strftime('%Y-%m', o.order_date) AS sales_month,
    COUNT(DISTINCT o.order_id) AS completed_orders,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS monthly_revenue,
    ROUND(
        SUM(oi.quantity * oi.unit_price) / COUNT(DISTINCT o.order_id),
        2
    ) AS avg_order_value
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY sales_month
ORDER BY sales_month;

SELECT
    p.product_name,
    p.category,
    SUM(oi.quantity) AS units_sold,
    COUNT(DISTINCT o.order_id) AS orders_containing_product,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue
FROM products AS p
JOIN order_items AS oi
    ON p.product_id = oi.product_id
JOIN orders AS o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_revenue DESC;

SELECT
    p.category,
    COUNT(DISTINCT p.product_id) AS products_sold,
    SUM(oi.quantity) AS units_sold,
    COUNT(DISTINCT o.order_id) AS completed_orders,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue
FROM products AS p
JOIN order_items AS oi
    ON p.product_id = oi.product_id
JOIN orders AS o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY p.category
ORDER BY total_revenue DESC;

SELECT
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(DISTINCT o.order_id) AS completed_orders,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue,
    RANK() OVER (
        ORDER BY SUM(oi.quantity * oi.unit_price) DESC
    ) AS revenue_rank
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY revenue_rank;