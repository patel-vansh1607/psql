/* creating customers table*/

CREATE TABLE customers (customer_id SERIAL PRIMARY KEY, customer_name VARCHAR(100)
name VARCHAR(100), email VARCHAR(100) UNIQUE, address TEXT);

/* creating products table */

CREATE TABLE products ( product_id INT PRIMARY KEY, product_name VARCHAR(100),
product_price DECIMAL(10, 2));

/* creating orders table */
CREATE TABLE orders ( order_id INT PRIMARY KEY, customer_id INT, product_id INT,
order_date DATE, order_quantity INT, FOREIGN KEY (customer_id) REFERENCES 
customers(customer_id), FOREIGN KEY (product_id) REFERENCES products(product_id));

/* creating bankaccounts table */

CREATE TABLE bank_accounts ( account_id INT PRIMARY KEY, customer_id INT,
balance DECIMAL(15, 2),FOREIGN KEY (customer_id) REFERENCES customers(customer_id));

/* QUERY 1 */
SELECT * FROM customers
WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM orders);

/* QUERY 2 */
SELECT SUM(order_quantity * product_price) AS total_revenue
FROM orders
JOIN products ON orders.product_id = products.product_id;

/* QUERY 3 */
SELECT products.product_id, products.product_name, 
       SUM(orders.order_quantity * products.product_price) AS revenue
FROM orders
JOIN products ON orders.product_id = products.product_id
GROUP BY products.product_id, products.product_name
ORDER BY revenue DESC
LIMIT 5;

/* QUERY 4 */
UPDATE customers
SET address = 'New Address Here'
WHERE customer_id = 101;

/* QUERY 5 */
BEGIN;

UPDATE bank_accounts
SET balance = balance - 100
WHERE account_id = 1;

UPDATE bank_accounts
SET balance = balance + 100
WHERE account_id = 2;

COMMIT;
