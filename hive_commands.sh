# Hive stage: external tables, partitioning, and data loading
# 1. Create database and external tables (pointing at Sqoop-imported HDFS data)
CREATE DATABASE retail_db;
CREATE EXTERNAL TABLE customers (customer_id INT, first_name STRING, last_name STRING, email STRING, city STRING, signup_date STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE LOCATION '/user/cloudera/retail_db/customers';
CREATE EXTERNAL TABLE products (product_id INT, product_name STRING, category STRING, price DECIMAL(10,2)) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE LOCATION '/user/cloudera/retail_db/products';
CREATE EXTERNAL TABLE orders (order_id INT, customer_id INT, order_date STRING, status STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE LOCATION '/user/cloudera/retail_db/orders';
CREATE EXTERNAL TABLE order_items (order_item_id INT, order_id INT, product_id INT, quantity INT, price_at_purchase DECIMAL(10,2)) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE LOCATION '/user/cloudera/retail_db/order_items';
# 2. Partitioning demonstration - dynamic partitioning of orders by status
SET hive.exec.dynamic.partition = true;
SET hive.exec.dynamic.partition.mode = nonstrict;
CREATE TABLE orders_by_status (order_id INT, customer_id INT, order_date STRING) PARTITIONED BY (status STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;
INSERT INTO TABLE orders_by_status PARTITION (status) SELECT order_id, customer_id, order_date, status FROM orders;
# 3. LOAD DATA demonstration - static partition load of a manually created file
LOAD DATA LOCAL INPATH '/home/cloudera/manual_order.csv' INTO TABLE orders_by_status PARTITION (status='Pending');
