-- Drop tables if they already exist
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

-- Create customers table
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    customer_name TEXT,
    email TEXT,
    city TEXT
);

-- Create products table
CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT,
    category TEXT,
    price DECIMAL(10,2)
);

-- Create orders table
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    total DECIMAL(10,2),
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert sample customers
INSERT INTO customers VALUES
(1, 'Alice Smith', 'alice@example.com', 'New York'),
(2, 'Bob Johnson', 'bob@example.com', 'Los Angeles'),
(3, 'Carol Davis', 'carol@example.com', 'Chicago');

-- Insert sample products
INSERT INTO products VALUES
(101, 'Smartphone', 'Electronics', 699.99),
(102, 'Laptop', 'Electronics', 1199.99),
(103, 'Book', 'Books', 15.49),
(104, 'Backpack', 'Accessories', 49.99);

-- Insert sample orders
INSERT INTO orders VALUES
(1001, 1, 101, 1, 699.99, '2024-06-01'),
(1002, 2, 102, 1, 1199.99, '2024-06-03'),
(1003, 1, 103, 2, 30.98, '2024-06-04'),
(1004, 3, 104, 1, 49.99, '2024-06-05'),
(1005, 3, 103, 3, 46.47, '2024-06-06');

SELECT * FROM customers;

SELECT * FROM orders WHERE order_date > '2024-06-04';

SELECT * FROM products ORDER BY price DESC;

SELECT category, COUNT(*) AS total_products FROM products GROUP BY category;

SELECT o.order_id, c.customer_name 
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

SELECT * FROM customers 
WHERE customer_id IN (SELECT customer_id FROM orders WHERE total > 500);

CREATE VIEW high_value_customers AS 
SELECT customer_id, SUM(total) AS total_spent 
FROM orders 
GROUP BY customer_id 
HAVING SUM(total) > 1000;

SELECT * FROM high_value_customers;

CREATE INDEX idx_customer_id ON orders(customer_id);
SHOW INDEX FROM orders;
