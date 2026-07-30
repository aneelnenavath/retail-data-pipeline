CREATE TABLE customers (customer_id INT AUTO_INCREMENT PRIMARY KEY, first_name VARCHAR(50), last_name VARCHAR(50), email VARCHAR(100), city VARCHAR(50), signup_date DATE);

CREATE TABLE products (product_id INT AUTO_INCREMENT PRIMARY KEY, product_name VARCHAR(100), category VARCHAR(50), price DECIMAL(10,2));
